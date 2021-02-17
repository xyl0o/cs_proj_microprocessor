// Generated from Test.g4 by ANTLR 4.9.1
package de.projekt.parser;
import org.antlr.v4.runtime.tree.ParseTreeVisitor;

/**
 * This interface defines a complete generic visitor for a parse tree produced
 * by {@link TestParser}.
 *
 * @param <T> The return type of the visit operation. Use {@link Void} for
 * operations with no return type.
 */
public interface TestVisitor<T> extends ParseTreeVisitor<T> {
	/**
	 * Visit a parse tree produced by {@link TestParser#start}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitStart(TestParser.StartContext ctx);
	/**
	 * Visit a parse tree produced by {@link TestParser#command}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitCommand(TestParser.CommandContext ctx);
	/**
	 * Visit a parse tree produced by {@link TestParser#no_op}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitNo_op(TestParser.No_opContext ctx);
	/**
	 * Visit a parse tree produced by {@link TestParser#two_op}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitTwo_op(TestParser.Two_opContext ctx);
	/**
	 * Visit a parse tree produced by {@link TestParser#three_op}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitThree_op(TestParser.Three_opContext ctx);
	/**
	 * Visit a parse tree produced by {@link TestParser#jmp_op}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJmp_op(TestParser.Jmp_opContext ctx);
	/**
	 * Visit a parse tree produced by {@link TestParser#mul_op}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitMul_op(TestParser.Mul_opContext ctx);
	/**
	 * Visit a parse tree produced by {@link TestParser#not_op}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitNot_op(TestParser.Not_opContext ctx);
	/**
	 * Visit a parse tree produced by {@link TestParser#save_label}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSave_label(TestParser.Save_labelContext ctx);
	/**
	 * Visit a parse tree produced by {@link TestParser#load_label}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitLoad_label(TestParser.Load_labelContext ctx);
	/**
	 * Visit a parse tree produced by {@link TestParser#no_op_opcode}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitNo_op_opcode(TestParser.No_op_opcodeContext ctx);
	/**
	 * Visit a parse tree produced by {@link TestParser#two_op_opcode}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitTwo_op_opcode(TestParser.Two_op_opcodeContext ctx);
	/**
	 * Visit a parse tree produced by {@link TestParser#three_op_opcode}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitThree_op_opcode(TestParser.Three_op_opcodeContext ctx);
	/**
	 * Visit a parse tree produced by {@link TestParser#jmp_op_opcode}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJmp_op_opcode(TestParser.Jmp_op_opcodeContext ctx);
	/**
	 * Visit a parse tree produced by {@link TestParser#mul_opcode}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitMul_opcode(TestParser.Mul_opcodeContext ctx);
	/**
	 * Visit a parse tree produced by {@link TestParser#not_opcode}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitNot_opcode(TestParser.Not_opcodeContext ctx);
	/**
	 * Visit a parse tree produced by {@link TestParser#regOne}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitRegOne(TestParser.RegOneContext ctx);
	/**
	 * Visit a parse tree produced by {@link TestParser#regTwo}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitRegTwo(TestParser.RegTwoContext ctx);
	/**
	 * Visit a parse tree produced by {@link TestParser#regOrIm}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitRegOrIm(TestParser.RegOrImContext ctx);
}