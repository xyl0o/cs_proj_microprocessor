package de.projekt.compiler;

import java.util.HashMap;

import de.projekt.parser.TestBaseVisitor;
import de.projekt.parser.TestParser.CommandContext;
import de.projekt.parser.TestParser.Jmp_opContext;
import de.projekt.parser.TestParser.No_opContext;
import de.projekt.parser.TestParser.Save_labelContext;
import de.projekt.parser.TestParser.Three_opContext;
import de.projekt.parser.TestParser.Two_opContext;

public class PreProcessor extends TestBaseVisitor<String> {

	int line = 0;
	
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
		line ++;
		return visitChildren(ctx);
	}
	
	@Override
	public String visitThree_op(Three_opContext ctx) {
		for(int i = 0; i < deltaRegUsed.length; i++) {
			if(deltaRegUsed[i] > 0) {
				deltaRegUsed[i]--;
			}
		}
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
		for(int i = 0; i < deltaRegUsed.length; i++) {
			if(deltaRegUsed[i] > 0) {
				deltaRegUsed[i]--;
			}
		}
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
	public String visitNo_op(No_opContext ctx) {
		return ctx.getText() + "\n";
	}
	
	@Override
	public String visitJmp_op(Jmp_opContext ctx) {
		for(int i = 0; i < deltaRegUsed.length ; i++) {
			deltaRegUsed[i] = 0;
		}

		if(ctx.jmp_op_opcode().getText().equals("B")) {
			line +=6;
			return  "NOP;\nNOP;\nNOP;\n"+ ctx.getText()+ "\nNOP;\nNOP;\nNOP;\n";
		}
		else {
			line +=4;
			return ctx.getText()+ "\n" + nopstring;	
		}
	}
	
	@Override
	public String visitSave_label(Save_labelContext ctx) {
		String label = ctx.getText();
		
		if(!labels.containsKey(label)) {
			labels.put(label, line);
		}else if(labels.get(label) != line){
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
		
		for(int i = maxValue; i > 0; i--){
			line ++;
			nops = nops + "NOP;\n";
		}
		
		for(int i = 0; i < regs.length; i++){
			deltaRegUsed[regs[i]] = 4;
		}
		
		return nops;
	}
}
