package de.projekt.compiler;

import de.projekt.parser.TestBaseVisitor;
import de.projekt.parser.TestParser.CommandContext;
import de.projekt.parser.TestParser.Jmp_opContext;
import de.projekt.parser.TestParser.Mul_opContext;
import de.projekt.parser.TestParser.No_opContext;
import de.projekt.parser.TestParser.Not_opContext;
import de.projekt.parser.TestParser.Save_labelContext;
import de.projekt.parser.TestParser.Three_opContext;
import de.projekt.parser.TestParser.Two_opContext;

public class MacroVisitor extends TestBaseVisitor<String>{
	int counter = 0;
	String tmp = "25";
	String tmpResult = "r24";
	
	@Override
	public String visitCommand(CommandContext ctx) {
		
		return visitChildren(ctx);
	}
	
	
	@Override
	public String visitMul_op(Mul_opContext ctx) {
		
		String result = ctx.regOne().getText();
		String op1= ctx.regTwo().getText();
		String op2= ctx.regOrIm().getText(); //Der Imm Fall muss gehandelt werden
	
		String mulLabel = ".mul" + counter;
		String shiftLabel = ".shift" + counter;
		String endLabel = ".end" + counter;
		String switchLabel = ".switch" + counter;
		String macro = 
				"MOV" + tmpResult + ", 0;\n"+
				"CMPGT" + op1 + "," + op2 + ";" +
				"B r0," + switchLabel +";\n" +
				mulLabel + "\n" +
				"AND" + tmp + "," + op1 + "," + "1" + "; \n" +
				"CMPEQ" + tmp + "," + "0" +"; \n"+
				"B r0,"+ shiftLabel + "; \n" +
				"ADD" + tmpResult + "," + tmpResult + ","+ op2 + "; \n" +
				shiftLabel + "\n" +
				"SRL" + op1 + "," + op1 + ",1; \n" +
				"SL" + op2 + "," + op2 + ",1; \n" +
				"CMPGT" + op1 + "," + "0" +"; \n" +
				"B r0," + mulLabel + "; \n" +
				"JMP" +"r0," + endLabel + "; \n" +
				switchLabel + "\n" +
				"MOV" + tmp + "," + op1 +"; \n" +
				"MOV" + op1 + "," + op2 +"; \n" +
				"MOV" + op2 + "," + op1 +"; \n" +
				"JMP" + "r0," + mulLabel + ";" +
				endLabel + "\n" +
				"MOV"+ result +"," + tmpResult +";";
		counter ++;
		return macro;
	}
	
	@Override
	public String visitNot_op(Not_opContext ctx) {
		String result = ctx.regOne().getText();
		String op2= ctx.regOrIm().getText();
		
		String macro =
				"MOV " + tmp + "0xFFFFFFFF; \n" +
				"XOR " + result + op2 + tmp + "; \n";
		
		return macro;
	}

	@Override
	public String visitThree_op(Three_opContext ctx) {
		return ctx.getText() + "\n";
	}
	
	@Override
	public String visitTwo_op(Two_opContext ctx) {
		return ctx.getText() + "\n";
	}
	
	@Override
	public String visitJmp_op(Jmp_opContext ctx) {
		return ctx.getText() + "\n";
	}
	@Override
	public String visitSave_label(Save_labelContext ctx) {
		return ctx.getText() + "\n";
	}
	
	@Override
	public String visitNo_op(No_opContext ctx) {
		return ctx.getText() + "\n";
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
	
}