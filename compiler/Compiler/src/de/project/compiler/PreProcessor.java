package de.project.compiler;

import java.util.HashMap;

import de.projekt.parser.TestBaseVisitor;
import de.projekt.parser.TestParser.CommandContext;
import de.projekt.parser.TestParser.Jmp_opContext;
import de.projekt.parser.TestParser.Mul_opContext;
import de.projekt.parser.TestParser.Save_labelContext;
import de.projekt.parser.TestParser.Three_opContext;
import de.projekt.parser.TestParser.Two_opContext;

public class PreProcessor extends TestBaseVisitor<String> {

	int line = 0;
	int counter = 0;
	String tmp = "r31";
	
	String nopstring = "NOP;\nNOP;\nNOP;\nNOP;\n";
	private int[] deltaRegUsed = new int[32];
	
	HashMap<String,Integer> labels;
	
	public PreProcessor(HashMap<String,Integer> labels) {
		this.labels = labels;
		for(int i = 0; i < deltaRegUsed.length ; i++) {
			deltaRegUsed[i] = 0;
		}
	}
	
	public String visitCommand(CommandContext ctx) {
		for(int i = 0; i < deltaRegUsed.length; i++) {
			if(deltaRegUsed[i] > 0) {
				deltaRegUsed[i]--;
			}
		}
		line ++;
		return visitChildren(ctx);
	}
	
	@Override
	public String visitMul_op(Mul_opContext ctx) {
		int[] regs = new int[3];
		regs[0] = Integer.parseInt(ctx.regOne().registernumber.getText());
		regs[1] =  Integer.parseInt(ctx.regTwo().registernumber.getText());
		regs[2] =  Integer.parseInt(ctx.regOrIm().registernumber.getText());
		String nops = evalNops(regs);
		
		String result = ctx.regOne().getText();
		String op1= ctx.regTwo().getText();
		String op2= ctx.regOrIm().getText(); //Der Imm Fall muss gehandelt werden
	
		String mulLabel = ".mul" + counter;
		String shiftLabel = ".shift" + counter;
		labels.put(mulLabel,line);
		labels.put(shiftLabel,line+5);
		line += 7;
		String macro = 
				//mulLabel +
				"AND" + tmp + "," + op1 + "," + "1d" + "; \n" +
				"CMPEQ" + tmp + "," + "0d" +"; \n"+
				"B"  + shiftLabel + "; \n" +
				"ADD" + result + "," + result + ","+ op2 + "; \n" +
				//shiftLabel + "\n" +
				"SRL" + op1 + "," + op1 + ",1d; \n" +
				"SL" + op2 + "," + op2 + ",1d; \n" +
				"CMPGT" + op1 + "," + "0d" +"; \n" +
				"B" + mulLabel + "; \n";
		counter ++;
		return nops + macro;
	}
	
	@Override
	public String visitThree_op(Three_opContext ctx) {
		int[] regs ;
		if(ctx.regOrIm().immediate == null) {
			regs = new int[3];
			regs[2] = Integer.parseInt(ctx.regOrIm().registernumber.getText());}
		else {
			regs = new int[2];
		}
		regs[0] = Integer.parseInt(ctx.regOne().registernumber.getText());
		regs[1] = Integer.parseInt(ctx.regTwo().registernumber.getText());
		return evalNops(regs) + ctx.getText() + "\n";
	}
	
	@Override
	public String visitTwo_op(Two_opContext ctx) {
		int[] regs ;
		if(ctx.regOrIm().immediate == null) {
			regs = new int[2];
			regs[1] = Integer.parseInt(ctx.regOrIm().registernumber.getText());}
		else {
			regs = new int[1];
		}
		regs[0] = Integer.parseInt(ctx.regOne().registernumber.getText());
		return evalNops(regs) + ctx.getText() + "\n";
	}
	
	@Override
	public String visitJmp_op(Jmp_opContext ctx) {
		for(int i = 0; i < deltaRegUsed.length ; i++) {
			deltaRegUsed[i] = 0;
		}
		line +=4;
		return ctx.getText()+ "\n" + nopstring;
	}
	
	@Override
	public String visitSave_label(Save_labelContext ctx) {
		String label = ctx.getText();
		if(!labels.containsKey(label)) {
			labels.put(label, line - 1); //instruction memory fängt bei 0 an, daher line - 1
		}
		else if(labels.get(label) != line){
			System.err.println("Label: " + label + " already in use!");
		}
		line --;
		return null;
	}
	
	@Override
	protected String aggregateResult(String aggregate, String nextResult) {
		if(aggregate == null) {
			return  nextResult;
		}
		if(nextResult == null) {
			return aggregate;
		}
		return aggregate + nextResult;
	}
 	
	private String evalNops(int[] regs){
		int maxValue = 0;
		for(int i = 0; i < regs.length; i++){
			if(maxValue < deltaRegUsed[regs[i]]){
				maxValue = deltaRegUsed[regs[i]];
			}
		}
		String nops = "";
		for(int i = maxValue; i > 0; i--)
		{
			nops = nops + "NOP;\n";
		}
		for(int i = 0; i < regs.length; i++){
			deltaRegUsed[regs[i]] = 5;
		}
		return nops;
	}
}
