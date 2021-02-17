// Generated from Test.g4 by ANTLR 4.9.1
package de.projekt.parser;
import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link TestParser}.
 */
public interface TestListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link TestParser#start}.
	 * @param ctx the parse tree
	 */
	void enterStart(TestParser.StartContext ctx);
	/**
	 * Exit a parse tree produced by {@link TestParser#start}.
	 * @param ctx the parse tree
	 */
	void exitStart(TestParser.StartContext ctx);
	/**
	 * Enter a parse tree produced by {@link TestParser#command}.
	 * @param ctx the parse tree
	 */
	void enterCommand(TestParser.CommandContext ctx);
	/**
	 * Exit a parse tree produced by {@link TestParser#command}.
	 * @param ctx the parse tree
	 */
	void exitCommand(TestParser.CommandContext ctx);
	/**
	 * Enter a parse tree produced by {@link TestParser#no_op}.
	 * @param ctx the parse tree
	 */
	void enterNo_op(TestParser.No_opContext ctx);
	/**
	 * Exit a parse tree produced by {@link TestParser#no_op}.
	 * @param ctx the parse tree
	 */
	void exitNo_op(TestParser.No_opContext ctx);
	/**
	 * Enter a parse tree produced by {@link TestParser#two_op}.
	 * @param ctx the parse tree
	 */
	void enterTwo_op(TestParser.Two_opContext ctx);
	/**
	 * Exit a parse tree produced by {@link TestParser#two_op}.
	 * @param ctx the parse tree
	 */
	void exitTwo_op(TestParser.Two_opContext ctx);
	/**
	 * Enter a parse tree produced by {@link TestParser#three_op}.
	 * @param ctx the parse tree
	 */
	void enterThree_op(TestParser.Three_opContext ctx);
	/**
	 * Exit a parse tree produced by {@link TestParser#three_op}.
	 * @param ctx the parse tree
	 */
	void exitThree_op(TestParser.Three_opContext ctx);
	/**
	 * Enter a parse tree produced by {@link TestParser#jmp_op}.
	 * @param ctx the parse tree
	 */
	void enterJmp_op(TestParser.Jmp_opContext ctx);
	/**
	 * Exit a parse tree produced by {@link TestParser#jmp_op}.
	 * @param ctx the parse tree
	 */
	void exitJmp_op(TestParser.Jmp_opContext ctx);
	/**
	 * Enter a parse tree produced by {@link TestParser#mul_op}.
	 * @param ctx the parse tree
	 */
	void enterMul_op(TestParser.Mul_opContext ctx);
	/**
	 * Exit a parse tree produced by {@link TestParser#mul_op}.
	 * @param ctx the parse tree
	 */
	void exitMul_op(TestParser.Mul_opContext ctx);
	/**
	 * Enter a parse tree produced by {@link TestParser#not_op}.
	 * @param ctx the parse tree
	 */
	void enterNot_op(TestParser.Not_opContext ctx);
	/**
	 * Exit a parse tree produced by {@link TestParser#not_op}.
	 * @param ctx the parse tree
	 */
	void exitNot_op(TestParser.Not_opContext ctx);
	/**
	 * Enter a parse tree produced by {@link TestParser#save_label}.
	 * @param ctx the parse tree
	 */
	void enterSave_label(TestParser.Save_labelContext ctx);
	/**
	 * Exit a parse tree produced by {@link TestParser#save_label}.
	 * @param ctx the parse tree
	 */
	void exitSave_label(TestParser.Save_labelContext ctx);
	/**
	 * Enter a parse tree produced by {@link TestParser#load_label}.
	 * @param ctx the parse tree
	 */
	void enterLoad_label(TestParser.Load_labelContext ctx);
	/**
	 * Exit a parse tree produced by {@link TestParser#load_label}.
	 * @param ctx the parse tree
	 */
	void exitLoad_label(TestParser.Load_labelContext ctx);
	/**
	 * Enter a parse tree produced by {@link TestParser#no_op_opcode}.
	 * @param ctx the parse tree
	 */
	void enterNo_op_opcode(TestParser.No_op_opcodeContext ctx);
	/**
	 * Exit a parse tree produced by {@link TestParser#no_op_opcode}.
	 * @param ctx the parse tree
	 */
	void exitNo_op_opcode(TestParser.No_op_opcodeContext ctx);
	/**
	 * Enter a parse tree produced by {@link TestParser#two_op_opcode}.
	 * @param ctx the parse tree
	 */
	void enterTwo_op_opcode(TestParser.Two_op_opcodeContext ctx);
	/**
	 * Exit a parse tree produced by {@link TestParser#two_op_opcode}.
	 * @param ctx the parse tree
	 */
	void exitTwo_op_opcode(TestParser.Two_op_opcodeContext ctx);
	/**
	 * Enter a parse tree produced by {@link TestParser#three_op_opcode}.
	 * @param ctx the parse tree
	 */
	void enterThree_op_opcode(TestParser.Three_op_opcodeContext ctx);
	/**
	 * Exit a parse tree produced by {@link TestParser#three_op_opcode}.
	 * @param ctx the parse tree
	 */
	void exitThree_op_opcode(TestParser.Three_op_opcodeContext ctx);
	/**
	 * Enter a parse tree produced by {@link TestParser#jmp_op_opcode}.
	 * @param ctx the parse tree
	 */
	void enterJmp_op_opcode(TestParser.Jmp_op_opcodeContext ctx);
	/**
	 * Exit a parse tree produced by {@link TestParser#jmp_op_opcode}.
	 * @param ctx the parse tree
	 */
	void exitJmp_op_opcode(TestParser.Jmp_op_opcodeContext ctx);
	/**
	 * Enter a parse tree produced by {@link TestParser#mul_opcode}.
	 * @param ctx the parse tree
	 */
	void enterMul_opcode(TestParser.Mul_opcodeContext ctx);
	/**
	 * Exit a parse tree produced by {@link TestParser#mul_opcode}.
	 * @param ctx the parse tree
	 */
	void exitMul_opcode(TestParser.Mul_opcodeContext ctx);
	/**
	 * Enter a parse tree produced by {@link TestParser#not_opcode}.
	 * @param ctx the parse tree
	 */
	void enterNot_opcode(TestParser.Not_opcodeContext ctx);
	/**
	 * Exit a parse tree produced by {@link TestParser#not_opcode}.
	 * @param ctx the parse tree
	 */
	void exitNot_opcode(TestParser.Not_opcodeContext ctx);
	/**
	 * Enter a parse tree produced by {@link TestParser#regOne}.
	 * @param ctx the parse tree
	 */
	void enterRegOne(TestParser.RegOneContext ctx);
	/**
	 * Exit a parse tree produced by {@link TestParser#regOne}.
	 * @param ctx the parse tree
	 */
	void exitRegOne(TestParser.RegOneContext ctx);
	/**
	 * Enter a parse tree produced by {@link TestParser#regTwo}.
	 * @param ctx the parse tree
	 */
	void enterRegTwo(TestParser.RegTwoContext ctx);
	/**
	 * Exit a parse tree produced by {@link TestParser#regTwo}.
	 * @param ctx the parse tree
	 */
	void exitRegTwo(TestParser.RegTwoContext ctx);
	/**
	 * Enter a parse tree produced by {@link TestParser#regOrIm}.
	 * @param ctx the parse tree
	 */
	void enterRegOrIm(TestParser.RegOrImContext ctx);
	/**
	 * Exit a parse tree produced by {@link TestParser#regOrIm}.
	 * @param ctx the parse tree
	 */
	void exitRegOrIm(TestParser.RegOrImContext ctx);
}