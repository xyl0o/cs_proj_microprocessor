// Generated from Test.g4 by ANTLR 4.9.1
package de.projekt.parser;
import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.misc.*;
import org.antlr.v4.runtime.tree.*;
import java.util.List;
import java.util.Iterator;
import java.util.ArrayList;

@SuppressWarnings({"all", "warnings", "unchecked", "unused", "cast"})
public class TestParser extends Parser {
	static { RuntimeMetaData.checkVersion("4.9.1", RuntimeMetaData.VERSION); }

	protected static final DFA[] _decisionToDFA;
	protected static final PredictionContextCache _sharedContextCache =
		new PredictionContextCache();
	public static final int
		T__0=1, CMPEQ=2, CMPGT=3, MOV=4, JMP=5, B=6, ADC=7, ADD=8, SBC=9, SUB=10, 
		SL=11, SRA=12, SRL=13, AND=14, ORR=15, XOR=16, LDR=17, STR=18, NOP=19, 
		NUMBER=20, MUL=21, COMMA=22, COLON=23, SPECIFIER=24, COMMENT=25, LINE_COMMENT=26, 
		ALT_LINE_COMMENT=27, WS=28, LABEL=29;
	public static final int
		RULE_start = 0, RULE_command = 1, RULE_no_op = 2, RULE_two_op = 3, RULE_three_op = 4, 
		RULE_jmp_op = 5, RULE_mul_op = 6, RULE_save_label = 7, RULE_load_label = 8, 
		RULE_no_op_opcode = 9, RULE_two_op_opcode = 10, RULE_three_op_opcode = 11, 
		RULE_jmp_op_opcode = 12, RULE_mul_opcode = 13, RULE_regOne = 14, RULE_regTwo = 15, 
		RULE_regOrIm = 16;
	private static String[] makeRuleNames() {
		return new String[] {
			"start", "command", "no_op", "two_op", "three_op", "jmp_op", "mul_op", 
			"save_label", "load_label", "no_op_opcode", "two_op_opcode", "three_op_opcode", 
			"jmp_op_opcode", "mul_opcode", "regOne", "regTwo", "regOrIm"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, "'r'", "'CMPEQ'", "'CMPGT'", "'MOV'", "'JMP'", "'B'", "'ADC'", 
			"'ADD'", "'SBC'", "'SUB'", "'SL'", "'SRA'", "'SRL'", "'AND'", "'OR'", 
			"'XOR'", "'LDR'", "'STR'", "'NOP'", null, "'MUL'", "','", "';'"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, null, "CMPEQ", "CMPGT", "MOV", "JMP", "B", "ADC", "ADD", "SBC", 
			"SUB", "SL", "SRA", "SRL", "AND", "ORR", "XOR", "LDR", "STR", "NOP", 
			"NUMBER", "MUL", "COMMA", "COLON", "SPECIFIER", "COMMENT", "LINE_COMMENT", 
			"ALT_LINE_COMMENT", "WS", "LABEL"
		};
	}
	private static final String[] _SYMBOLIC_NAMES = makeSymbolicNames();
	public static final Vocabulary VOCABULARY = new VocabularyImpl(_LITERAL_NAMES, _SYMBOLIC_NAMES);

	/**
	 * @deprecated Use {@link #VOCABULARY} instead.
	 */
	@Deprecated
	public static final String[] tokenNames;
	static {
		tokenNames = new String[_SYMBOLIC_NAMES.length];
		for (int i = 0; i < tokenNames.length; i++) {
			tokenNames[i] = VOCABULARY.getLiteralName(i);
			if (tokenNames[i] == null) {
				tokenNames[i] = VOCABULARY.getSymbolicName(i);
			}

			if (tokenNames[i] == null) {
				tokenNames[i] = "<INVALID>";
			}
		}
	}

	@Override
	@Deprecated
	public String[] getTokenNames() {
		return tokenNames;
	}

	@Override

	public Vocabulary getVocabulary() {
		return VOCABULARY;
	}

	@Override
	public String getGrammarFileName() { return "Test.g4"; }

	@Override
	public String[] getRuleNames() { return ruleNames; }

	@Override
	public String getSerializedATN() { return _serializedATN; }

	@Override
	public ATN getATN() { return _ATN; }

	public TestParser(TokenStream input) {
		super(input);
		_interp = new ParserATNSimulator(this,_ATN,_decisionToDFA,_sharedContextCache);
	}

	public static class StartContext extends ParserRuleContext {
		public CommandContext command() {
			return getRuleContext(CommandContext.class,0);
		}
		public StartContext start() {
			return getRuleContext(StartContext.class,0);
		}
		public StartContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_start; }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof TestVisitor ) return ((TestVisitor<? extends T>)visitor).visitStart(this);
			else return visitor.visitChildren(this);
		}
	}

	public final StartContext start() throws RecognitionException {
		return start(0);
	}

	private StartContext start(int _p) throws RecognitionException {
		ParserRuleContext _parentctx = _ctx;
		int _parentState = getState();
		StartContext _localctx = new StartContext(_ctx, _parentState);
		StartContext _prevctx = _localctx;
		int _startState = 0;
		enterRecursionRule(_localctx, 0, RULE_start, _p);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			{
			setState(35);
			command();
			}
			_ctx.stop = _input.LT(-1);
			setState(41);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,0,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					if ( _parseListeners!=null ) triggerExitRuleEvent();
					_prevctx = _localctx;
					{
					{
					_localctx = new StartContext(_parentctx, _parentState);
					pushNewRecursionContext(_localctx, _startState, RULE_start);
					setState(37);
					if (!(precpred(_ctx, 2))) throw new FailedPredicateException(this, "precpred(_ctx, 2)");
					setState(38);
					command();
					}
					} 
				}
				setState(43);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,0,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			unrollRecursionContexts(_parentctx);
		}
		return _localctx;
	}

	public static class CommandContext extends ParserRuleContext {
		public No_opContext no_op() {
			return getRuleContext(No_opContext.class,0);
		}
		public Two_opContext two_op() {
			return getRuleContext(Two_opContext.class,0);
		}
		public Three_opContext three_op() {
			return getRuleContext(Three_opContext.class,0);
		}
		public Save_labelContext save_label() {
			return getRuleContext(Save_labelContext.class,0);
		}
		public Jmp_opContext jmp_op() {
			return getRuleContext(Jmp_opContext.class,0);
		}
		public Mul_opContext mul_op() {
			return getRuleContext(Mul_opContext.class,0);
		}
		public CommandContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_command; }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof TestVisitor ) return ((TestVisitor<? extends T>)visitor).visitCommand(this);
			else return visitor.visitChildren(this);
		}
	}

	public final CommandContext command() throws RecognitionException {
		CommandContext _localctx = new CommandContext(_ctx, getState());
		enterRule(_localctx, 2, RULE_command);
		try {
			setState(50);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case NOP:
				enterOuterAlt(_localctx, 1);
				{
				setState(44);
				no_op();
				}
				break;
			case CMPEQ:
			case CMPGT:
			case MOV:
				enterOuterAlt(_localctx, 2);
				{
				setState(45);
				two_op();
				}
				break;
			case ADC:
			case ADD:
			case SBC:
			case SUB:
			case SL:
			case SRA:
			case SRL:
			case AND:
			case ORR:
			case XOR:
			case LDR:
			case STR:
				enterOuterAlt(_localctx, 3);
				{
				setState(46);
				three_op();
				}
				break;
			case LABEL:
				enterOuterAlt(_localctx, 4);
				{
				setState(47);
				save_label();
				}
				break;
			case JMP:
			case B:
				enterOuterAlt(_localctx, 5);
				{
				setState(48);
				jmp_op();
				}
				break;
			case MUL:
				enterOuterAlt(_localctx, 6);
				{
				setState(49);
				mul_op();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class No_opContext extends ParserRuleContext {
		public No_op_opcodeContext no_op_opcode() {
			return getRuleContext(No_op_opcodeContext.class,0);
		}
		public TerminalNode COLON() { return getToken(TestParser.COLON, 0); }
		public No_opContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_no_op; }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof TestVisitor ) return ((TestVisitor<? extends T>)visitor).visitNo_op(this);
			else return visitor.visitChildren(this);
		}
	}

	public final No_opContext no_op() throws RecognitionException {
		No_opContext _localctx = new No_opContext(_ctx, getState());
		enterRule(_localctx, 4, RULE_no_op);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(52);
			no_op_opcode();
			setState(53);
			match(COLON);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Two_opContext extends ParserRuleContext {
		public Two_op_opcodeContext two_op_opcode() {
			return getRuleContext(Two_op_opcodeContext.class,0);
		}
		public RegOneContext regOne() {
			return getRuleContext(RegOneContext.class,0);
		}
		public TerminalNode COMMA() { return getToken(TestParser.COMMA, 0); }
		public RegOrImContext regOrIm() {
			return getRuleContext(RegOrImContext.class,0);
		}
		public TerminalNode COLON() { return getToken(TestParser.COLON, 0); }
		public Two_opContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_two_op; }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof TestVisitor ) return ((TestVisitor<? extends T>)visitor).visitTwo_op(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Two_opContext two_op() throws RecognitionException {
		Two_opContext _localctx = new Two_opContext(_ctx, getState());
		enterRule(_localctx, 6, RULE_two_op);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(55);
			two_op_opcode();
			setState(56);
			regOne();
			setState(57);
			match(COMMA);
			setState(58);
			regOrIm();
			setState(59);
			match(COLON);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Three_opContext extends ParserRuleContext {
		public Three_op_opcodeContext three_op_opcode() {
			return getRuleContext(Three_op_opcodeContext.class,0);
		}
		public RegOneContext regOne() {
			return getRuleContext(RegOneContext.class,0);
		}
		public List<TerminalNode> COMMA() { return getTokens(TestParser.COMMA); }
		public TerminalNode COMMA(int i) {
			return getToken(TestParser.COMMA, i);
		}
		public RegTwoContext regTwo() {
			return getRuleContext(RegTwoContext.class,0);
		}
		public RegOrImContext regOrIm() {
			return getRuleContext(RegOrImContext.class,0);
		}
		public TerminalNode COLON() { return getToken(TestParser.COLON, 0); }
		public Three_opContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_three_op; }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof TestVisitor ) return ((TestVisitor<? extends T>)visitor).visitThree_op(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Three_opContext three_op() throws RecognitionException {
		Three_opContext _localctx = new Three_opContext(_ctx, getState());
		enterRule(_localctx, 8, RULE_three_op);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(61);
			three_op_opcode();
			setState(62);
			regOne();
			setState(63);
			match(COMMA);
			setState(64);
			regTwo();
			setState(65);
			match(COMMA);
			setState(66);
			regOrIm();
			setState(67);
			match(COLON);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Jmp_opContext extends ParserRuleContext {
		public Jmp_op_opcodeContext jmp_op_opcode() {
			return getRuleContext(Jmp_op_opcodeContext.class,0);
		}
		public RegOneContext regOne() {
			return getRuleContext(RegOneContext.class,0);
		}
		public TerminalNode COMMA() { return getToken(TestParser.COMMA, 0); }
		public Load_labelContext load_label() {
			return getRuleContext(Load_labelContext.class,0);
		}
		public TerminalNode COLON() { return getToken(TestParser.COLON, 0); }
		public Jmp_opContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_jmp_op; }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof TestVisitor ) return ((TestVisitor<? extends T>)visitor).visitJmp_op(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Jmp_opContext jmp_op() throws RecognitionException {
		Jmp_opContext _localctx = new Jmp_opContext(_ctx, getState());
		enterRule(_localctx, 10, RULE_jmp_op);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(69);
			jmp_op_opcode();
			setState(70);
			regOne();
			setState(71);
			match(COMMA);
			setState(72);
			load_label();
			setState(73);
			match(COLON);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Mul_opContext extends ParserRuleContext {
		public Mul_opcodeContext mul_opcode() {
			return getRuleContext(Mul_opcodeContext.class,0);
		}
		public RegOneContext regOne() {
			return getRuleContext(RegOneContext.class,0);
		}
		public List<TerminalNode> COMMA() { return getTokens(TestParser.COMMA); }
		public TerminalNode COMMA(int i) {
			return getToken(TestParser.COMMA, i);
		}
		public RegTwoContext regTwo() {
			return getRuleContext(RegTwoContext.class,0);
		}
		public RegOrImContext regOrIm() {
			return getRuleContext(RegOrImContext.class,0);
		}
		public TerminalNode COLON() { return getToken(TestParser.COLON, 0); }
		public Mul_opContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_mul_op; }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof TestVisitor ) return ((TestVisitor<? extends T>)visitor).visitMul_op(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Mul_opContext mul_op() throws RecognitionException {
		Mul_opContext _localctx = new Mul_opContext(_ctx, getState());
		enterRule(_localctx, 12, RULE_mul_op);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(75);
			mul_opcode();
			setState(76);
			regOne();
			setState(77);
			match(COMMA);
			setState(78);
			regTwo();
			setState(79);
			match(COMMA);
			setState(80);
			regOrIm();
			setState(81);
			match(COLON);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Save_labelContext extends ParserRuleContext {
		public TerminalNode LABEL() { return getToken(TestParser.LABEL, 0); }
		public Save_labelContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_save_label; }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof TestVisitor ) return ((TestVisitor<? extends T>)visitor).visitSave_label(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Save_labelContext save_label() throws RecognitionException {
		Save_labelContext _localctx = new Save_labelContext(_ctx, getState());
		enterRule(_localctx, 14, RULE_save_label);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(83);
			match(LABEL);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Load_labelContext extends ParserRuleContext {
		public TerminalNode LABEL() { return getToken(TestParser.LABEL, 0); }
		public Load_labelContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_load_label; }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof TestVisitor ) return ((TestVisitor<? extends T>)visitor).visitLoad_label(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Load_labelContext load_label() throws RecognitionException {
		Load_labelContext _localctx = new Load_labelContext(_ctx, getState());
		enterRule(_localctx, 16, RULE_load_label);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(85);
			match(LABEL);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class No_op_opcodeContext extends ParserRuleContext {
		public TerminalNode NOP() { return getToken(TestParser.NOP, 0); }
		public No_op_opcodeContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_no_op_opcode; }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof TestVisitor ) return ((TestVisitor<? extends T>)visitor).visitNo_op_opcode(this);
			else return visitor.visitChildren(this);
		}
	}

	public final No_op_opcodeContext no_op_opcode() throws RecognitionException {
		No_op_opcodeContext _localctx = new No_op_opcodeContext(_ctx, getState());
		enterRule(_localctx, 18, RULE_no_op_opcode);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(87);
			match(NOP);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Two_op_opcodeContext extends ParserRuleContext {
		public TerminalNode CMPEQ() { return getToken(TestParser.CMPEQ, 0); }
		public TerminalNode CMPGT() { return getToken(TestParser.CMPGT, 0); }
		public TerminalNode MOV() { return getToken(TestParser.MOV, 0); }
		public Two_op_opcodeContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_two_op_opcode; }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof TestVisitor ) return ((TestVisitor<? extends T>)visitor).visitTwo_op_opcode(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Two_op_opcodeContext two_op_opcode() throws RecognitionException {
		Two_op_opcodeContext _localctx = new Two_op_opcodeContext(_ctx, getState());
		enterRule(_localctx, 20, RULE_two_op_opcode);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(89);
			_la = _input.LA(1);
			if ( !((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << CMPEQ) | (1L << CMPGT) | (1L << MOV))) != 0)) ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Three_op_opcodeContext extends ParserRuleContext {
		public TerminalNode ADC() { return getToken(TestParser.ADC, 0); }
		public TerminalNode ADD() { return getToken(TestParser.ADD, 0); }
		public TerminalNode SBC() { return getToken(TestParser.SBC, 0); }
		public TerminalNode SUB() { return getToken(TestParser.SUB, 0); }
		public TerminalNode SL() { return getToken(TestParser.SL, 0); }
		public TerminalNode SRA() { return getToken(TestParser.SRA, 0); }
		public TerminalNode SRL() { return getToken(TestParser.SRL, 0); }
		public TerminalNode AND() { return getToken(TestParser.AND, 0); }
		public TerminalNode ORR() { return getToken(TestParser.ORR, 0); }
		public TerminalNode XOR() { return getToken(TestParser.XOR, 0); }
		public TerminalNode LDR() { return getToken(TestParser.LDR, 0); }
		public TerminalNode STR() { return getToken(TestParser.STR, 0); }
		public Three_op_opcodeContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_three_op_opcode; }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof TestVisitor ) return ((TestVisitor<? extends T>)visitor).visitThree_op_opcode(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Three_op_opcodeContext three_op_opcode() throws RecognitionException {
		Three_op_opcodeContext _localctx = new Three_op_opcodeContext(_ctx, getState());
		enterRule(_localctx, 22, RULE_three_op_opcode);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(91);
			_la = _input.LA(1);
			if ( !((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << ADC) | (1L << ADD) | (1L << SBC) | (1L << SUB) | (1L << SL) | (1L << SRA) | (1L << SRL) | (1L << AND) | (1L << ORR) | (1L << XOR) | (1L << LDR) | (1L << STR))) != 0)) ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Jmp_op_opcodeContext extends ParserRuleContext {
		public TerminalNode JMP() { return getToken(TestParser.JMP, 0); }
		public TerminalNode B() { return getToken(TestParser.B, 0); }
		public Jmp_op_opcodeContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_jmp_op_opcode; }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof TestVisitor ) return ((TestVisitor<? extends T>)visitor).visitJmp_op_opcode(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Jmp_op_opcodeContext jmp_op_opcode() throws RecognitionException {
		Jmp_op_opcodeContext _localctx = new Jmp_op_opcodeContext(_ctx, getState());
		enterRule(_localctx, 24, RULE_jmp_op_opcode);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(93);
			_la = _input.LA(1);
			if ( !(_la==JMP || _la==B) ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Mul_opcodeContext extends ParserRuleContext {
		public TerminalNode MUL() { return getToken(TestParser.MUL, 0); }
		public Mul_opcodeContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_mul_opcode; }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof TestVisitor ) return ((TestVisitor<? extends T>)visitor).visitMul_opcode(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Mul_opcodeContext mul_opcode() throws RecognitionException {
		Mul_opcodeContext _localctx = new Mul_opcodeContext(_ctx, getState());
		enterRule(_localctx, 26, RULE_mul_opcode);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(95);
			match(MUL);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class RegOneContext extends ParserRuleContext {
		public Token registernumber;
		public TerminalNode NUMBER() { return getToken(TestParser.NUMBER, 0); }
		public RegOneContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_regOne; }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof TestVisitor ) return ((TestVisitor<? extends T>)visitor).visitRegOne(this);
			else return visitor.visitChildren(this);
		}
	}

	public final RegOneContext regOne() throws RecognitionException {
		RegOneContext _localctx = new RegOneContext(_ctx, getState());
		enterRule(_localctx, 28, RULE_regOne);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(97);
			match(T__0);
			setState(98);
			((RegOneContext)_localctx).registernumber = match(NUMBER);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class RegTwoContext extends ParserRuleContext {
		public Token registernumber;
		public TerminalNode NUMBER() { return getToken(TestParser.NUMBER, 0); }
		public RegTwoContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_regTwo; }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof TestVisitor ) return ((TestVisitor<? extends T>)visitor).visitRegTwo(this);
			else return visitor.visitChildren(this);
		}
	}

	public final RegTwoContext regTwo() throws RecognitionException {
		RegTwoContext _localctx = new RegTwoContext(_ctx, getState());
		enterRule(_localctx, 30, RULE_regTwo);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(100);
			match(T__0);
			setState(101);
			((RegTwoContext)_localctx).registernumber = match(NUMBER);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class RegOrImContext extends ParserRuleContext {
		public Token registernumber;
		public Token immediate;
		public Token specifier;
		public TerminalNode NUMBER() { return getToken(TestParser.NUMBER, 0); }
		public TerminalNode SPECIFIER() { return getToken(TestParser.SPECIFIER, 0); }
		public RegOrImContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_regOrIm; }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof TestVisitor ) return ((TestVisitor<? extends T>)visitor).visitRegOrIm(this);
			else return visitor.visitChildren(this);
		}
	}

	public final RegOrImContext regOrIm() throws RecognitionException {
		RegOrImContext _localctx = new RegOrImContext(_ctx, getState());
		enterRule(_localctx, 32, RULE_regOrIm);
		try {
			setState(107);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__0:
				enterOuterAlt(_localctx, 1);
				{
				setState(103);
				match(T__0);
				setState(104);
				((RegOrImContext)_localctx).registernumber = match(NUMBER);
				}
				break;
			case NUMBER:
				enterOuterAlt(_localctx, 2);
				{
				setState(105);
				((RegOrImContext)_localctx).immediate = match(NUMBER);
				setState(106);
				((RegOrImContext)_localctx).specifier = match(SPECIFIER);
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public boolean sempred(RuleContext _localctx, int ruleIndex, int predIndex) {
		switch (ruleIndex) {
		case 0:
			return start_sempred((StartContext)_localctx, predIndex);
		}
		return true;
	}
	private boolean start_sempred(StartContext _localctx, int predIndex) {
		switch (predIndex) {
		case 0:
			return precpred(_ctx, 2);
		}
		return true;
	}

	public static final String _serializedATN =
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\3\37p\4\2\t\2\4\3\t"+
		"\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4\13\t\13\4"+
		"\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\4\22\t\22\3\2\3"+
		"\2\3\2\3\2\3\2\7\2*\n\2\f\2\16\2-\13\2\3\3\3\3\3\3\3\3\3\3\3\3\5\3\65"+
		"\n\3\3\4\3\4\3\4\3\5\3\5\3\5\3\5\3\5\3\5\3\6\3\6\3\6\3\6\3\6\3\6\3\6\3"+
		"\6\3\7\3\7\3\7\3\7\3\7\3\7\3\b\3\b\3\b\3\b\3\b\3\b\3\b\3\b\3\t\3\t\3\n"+
		"\3\n\3\13\3\13\3\f\3\f\3\r\3\r\3\16\3\16\3\17\3\17\3\20\3\20\3\20\3\21"+
		"\3\21\3\21\3\22\3\22\3\22\3\22\5\22n\n\22\3\22\2\3\2\23\2\4\6\b\n\f\16"+
		"\20\22\24\26\30\32\34\36 \"\2\5\3\2\4\6\3\2\t\24\3\2\7\b\2e\2$\3\2\2\2"+
		"\4\64\3\2\2\2\6\66\3\2\2\2\b9\3\2\2\2\n?\3\2\2\2\fG\3\2\2\2\16M\3\2\2"+
		"\2\20U\3\2\2\2\22W\3\2\2\2\24Y\3\2\2\2\26[\3\2\2\2\30]\3\2\2\2\32_\3\2"+
		"\2\2\34a\3\2\2\2\36c\3\2\2\2 f\3\2\2\2\"m\3\2\2\2$%\b\2\1\2%&\5\4\3\2"+
		"&+\3\2\2\2\'(\f\4\2\2(*\5\4\3\2)\'\3\2\2\2*-\3\2\2\2+)\3\2\2\2+,\3\2\2"+
		"\2,\3\3\2\2\2-+\3\2\2\2.\65\5\6\4\2/\65\5\b\5\2\60\65\5\n\6\2\61\65\5"+
		"\20\t\2\62\65\5\f\7\2\63\65\5\16\b\2\64.\3\2\2\2\64/\3\2\2\2\64\60\3\2"+
		"\2\2\64\61\3\2\2\2\64\62\3\2\2\2\64\63\3\2\2\2\65\5\3\2\2\2\66\67\5\24"+
		"\13\2\678\7\31\2\28\7\3\2\2\29:\5\26\f\2:;\5\36\20\2;<\7\30\2\2<=\5\""+
		"\22\2=>\7\31\2\2>\t\3\2\2\2?@\5\30\r\2@A\5\36\20\2AB\7\30\2\2BC\5 \21"+
		"\2CD\7\30\2\2DE\5\"\22\2EF\7\31\2\2F\13\3\2\2\2GH\5\32\16\2HI\5\36\20"+
		"\2IJ\7\30\2\2JK\5\22\n\2KL\7\31\2\2L\r\3\2\2\2MN\5\34\17\2NO\5\36\20\2"+
		"OP\7\30\2\2PQ\5 \21\2QR\7\30\2\2RS\5\"\22\2ST\7\31\2\2T\17\3\2\2\2UV\7"+
		"\37\2\2V\21\3\2\2\2WX\7\37\2\2X\23\3\2\2\2YZ\7\25\2\2Z\25\3\2\2\2[\\\t"+
		"\2\2\2\\\27\3\2\2\2]^\t\3\2\2^\31\3\2\2\2_`\t\4\2\2`\33\3\2\2\2ab\7\27"+
		"\2\2b\35\3\2\2\2cd\7\3\2\2de\7\26\2\2e\37\3\2\2\2fg\7\3\2\2gh\7\26\2\2"+
		"h!\3\2\2\2ij\7\3\2\2jn\7\26\2\2kl\7\26\2\2ln\7\32\2\2mi\3\2\2\2mk\3\2"+
		"\2\2n#\3\2\2\2\5+\64m";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}