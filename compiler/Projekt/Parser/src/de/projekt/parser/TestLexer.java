// Generated from Test.g4 by ANTLR 4.9.1
package de.projekt.parser;
import org.antlr.v4.runtime.Lexer;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.Token;
import org.antlr.v4.runtime.TokenStream;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.misc.*;

@SuppressWarnings({"all", "warnings", "unchecked", "unused", "cast"})
public class TestLexer extends Lexer {
	static { RuntimeMetaData.checkVersion("4.9.1", RuntimeMetaData.VERSION); }

	protected static final DFA[] _decisionToDFA;
	protected static final PredictionContextCache _sharedContextCache =
		new PredictionContextCache();
	public static final int
		T__0=1, CMPEQ=2, CMPGT=3, MOV=4, JMP=5, B=6, ADC=7, ADD=8, SBC=9, SUB=10, 
		SL=11, SRA=12, SRL=13, AND=14, ORR=15, XOR=16, LDR=17, STR=18, NOP=19, 
		BINARY=20, DECIMAL=21, HEXADECIMAL=22, MUL=23, NOT=24, COMMA=25, COLON=26, 
		COMMENT=27, LINE_COMMENT=28, ALT_LINE_COMMENT=29, WS=30, LABEL=31;
	public static String[] channelNames = {
		"DEFAULT_TOKEN_CHANNEL", "HIDDEN"
	};

	public static String[] modeNames = {
		"DEFAULT_MODE"
	};

	private static String[] makeRuleNames() {
		return new String[] {
			"T__0", "CMPEQ", "CMPGT", "MOV", "JMP", "B", "ADC", "ADD", "SBC", "SUB", 
			"SL", "SRA", "SRL", "AND", "ORR", "XOR", "LDR", "STR", "NOP", "BINARY", 
			"DECIMAL", "HEXADECIMAL", "MUL", "NOT", "COMMA", "COLON", "COMMENT", 
			"LINE_COMMENT", "ALT_LINE_COMMENT", "WS", "LABEL"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, "'r'", "'CMPEQ'", "'CMPGT'", "'MOV'", "'JMP'", "'B'", "'ADC'", 
			"'ADD'", "'SBC'", "'SUB'", "'SL'", "'SRA'", "'SRL'", "'AND'", "'OR'", 
			"'XOR'", "'LDR'", "'STR'", "'NOP'", null, null, null, "'MUL'", "'NOT'", 
			"','", "';'"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, null, "CMPEQ", "CMPGT", "MOV", "JMP", "B", "ADC", "ADD", "SBC", 
			"SUB", "SL", "SRA", "SRL", "AND", "ORR", "XOR", "LDR", "STR", "NOP", 
			"BINARY", "DECIMAL", "HEXADECIMAL", "MUL", "NOT", "COMMA", "COLON", "COMMENT", 
			"LINE_COMMENT", "ALT_LINE_COMMENT", "WS", "LABEL"
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


	public TestLexer(CharStream input) {
		super(input);
		_interp = new LexerATNSimulator(this,_ATN,_decisionToDFA,_sharedContextCache);
	}

	@Override
	public String getGrammarFileName() { return "Test.g4"; }

	@Override
	public String[] getRuleNames() { return ruleNames; }

	@Override
	public String getSerializedATN() { return _serializedATN; }

	@Override
	public String[] getChannelNames() { return channelNames; }

	@Override
	public String[] getModeNames() { return modeNames; }

	@Override
	public ATN getATN() { return _ATN; }

	public static final String _serializedATN =
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\2!\u00db\b\1\4\2\t"+
		"\2\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4\13"+
		"\t\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\4\22\t\22"+
		"\4\23\t\23\4\24\t\24\4\25\t\25\4\26\t\26\4\27\t\27\4\30\t\30\4\31\t\31"+
		"\4\32\t\32\4\33\t\33\4\34\t\34\4\35\t\35\4\36\t\36\4\37\t\37\4 \t \3\2"+
		"\3\2\3\3\3\3\3\3\3\3\3\3\3\3\3\4\3\4\3\4\3\4\3\4\3\4\3\5\3\5\3\5\3\5\3"+
		"\6\3\6\3\6\3\6\3\7\3\7\3\b\3\b\3\b\3\b\3\t\3\t\3\t\3\t\3\n\3\n\3\n\3\n"+
		"\3\13\3\13\3\13\3\13\3\f\3\f\3\f\3\r\3\r\3\r\3\r\3\16\3\16\3\16\3\16\3"+
		"\17\3\17\3\17\3\17\3\20\3\20\3\20\3\21\3\21\3\21\3\21\3\22\3\22\3\22\3"+
		"\22\3\23\3\23\3\23\3\23\3\24\3\24\3\24\3\24\3\25\3\25\3\25\3\25\6\25\u0090"+
		"\n\25\r\25\16\25\u0091\3\26\6\26\u0095\n\26\r\26\16\26\u0096\3\27\3\27"+
		"\3\27\3\27\6\27\u009d\n\27\r\27\16\27\u009e\3\30\3\30\3\30\3\30\3\31\3"+
		"\31\3\31\3\31\3\32\3\32\3\33\3\33\3\34\3\34\3\34\3\34\7\34\u00b1\n\34"+
		"\f\34\16\34\u00b4\13\34\3\34\3\34\3\34\3\34\3\34\3\35\3\35\3\35\3\35\7"+
		"\35\u00bf\n\35\f\35\16\35\u00c2\13\35\3\35\3\35\3\36\3\36\7\36\u00c8\n"+
		"\36\f\36\16\36\u00cb\13\36\3\36\3\36\3\37\6\37\u00d0\n\37\r\37\16\37\u00d1"+
		"\3\37\3\37\3 \3 \6 \u00d8\n \r \16 \u00d9\3\u00b2\2!\3\3\5\4\7\5\t\6\13"+
		"\7\r\b\17\t\21\n\23\13\25\f\27\r\31\16\33\17\35\20\37\21!\22#\23%\24\'"+
		"\25)\26+\27-\30/\31\61\32\63\33\65\34\67\359\36;\37= ?!\3\2\b\3\2\62\63"+
		"\3\2\62;\4\2\62;CH\4\2\f\f\17\17\5\2\13\f\17\17\"\"\5\2\62;C\\c|\2\u00e2"+
		"\2\3\3\2\2\2\2\5\3\2\2\2\2\7\3\2\2\2\2\t\3\2\2\2\2\13\3\2\2\2\2\r\3\2"+
		"\2\2\2\17\3\2\2\2\2\21\3\2\2\2\2\23\3\2\2\2\2\25\3\2\2\2\2\27\3\2\2\2"+
		"\2\31\3\2\2\2\2\33\3\2\2\2\2\35\3\2\2\2\2\37\3\2\2\2\2!\3\2\2\2\2#\3\2"+
		"\2\2\2%\3\2\2\2\2\'\3\2\2\2\2)\3\2\2\2\2+\3\2\2\2\2-\3\2\2\2\2/\3\2\2"+
		"\2\2\61\3\2\2\2\2\63\3\2\2\2\2\65\3\2\2\2\2\67\3\2\2\2\29\3\2\2\2\2;\3"+
		"\2\2\2\2=\3\2\2\2\2?\3\2\2\2\3A\3\2\2\2\5C\3\2\2\2\7I\3\2\2\2\tO\3\2\2"+
		"\2\13S\3\2\2\2\rW\3\2\2\2\17Y\3\2\2\2\21]\3\2\2\2\23a\3\2\2\2\25e\3\2"+
		"\2\2\27i\3\2\2\2\31l\3\2\2\2\33p\3\2\2\2\35t\3\2\2\2\37x\3\2\2\2!{\3\2"+
		"\2\2#\177\3\2\2\2%\u0083\3\2\2\2\'\u0087\3\2\2\2)\u008b\3\2\2\2+\u0094"+
		"\3\2\2\2-\u0098\3\2\2\2/\u00a0\3\2\2\2\61\u00a4\3\2\2\2\63\u00a8\3\2\2"+
		"\2\65\u00aa\3\2\2\2\67\u00ac\3\2\2\29\u00ba\3\2\2\2;\u00c5\3\2\2\2=\u00cf"+
		"\3\2\2\2?\u00d5\3\2\2\2AB\7t\2\2B\4\3\2\2\2CD\7E\2\2DE\7O\2\2EF\7R\2\2"+
		"FG\7G\2\2GH\7S\2\2H\6\3\2\2\2IJ\7E\2\2JK\7O\2\2KL\7R\2\2LM\7I\2\2MN\7"+
		"V\2\2N\b\3\2\2\2OP\7O\2\2PQ\7Q\2\2QR\7X\2\2R\n\3\2\2\2ST\7L\2\2TU\7O\2"+
		"\2UV\7R\2\2V\f\3\2\2\2WX\7D\2\2X\16\3\2\2\2YZ\7C\2\2Z[\7F\2\2[\\\7E\2"+
		"\2\\\20\3\2\2\2]^\7C\2\2^_\7F\2\2_`\7F\2\2`\22\3\2\2\2ab\7U\2\2bc\7D\2"+
		"\2cd\7E\2\2d\24\3\2\2\2ef\7U\2\2fg\7W\2\2gh\7D\2\2h\26\3\2\2\2ij\7U\2"+
		"\2jk\7N\2\2k\30\3\2\2\2lm\7U\2\2mn\7T\2\2no\7C\2\2o\32\3\2\2\2pq\7U\2"+
		"\2qr\7T\2\2rs\7N\2\2s\34\3\2\2\2tu\7C\2\2uv\7P\2\2vw\7F\2\2w\36\3\2\2"+
		"\2xy\7Q\2\2yz\7T\2\2z \3\2\2\2{|\7Z\2\2|}\7Q\2\2}~\7T\2\2~\"\3\2\2\2\177"+
		"\u0080\7N\2\2\u0080\u0081\7F\2\2\u0081\u0082\7T\2\2\u0082$\3\2\2\2\u0083"+
		"\u0084\7U\2\2\u0084\u0085\7V\2\2\u0085\u0086\7T\2\2\u0086&\3\2\2\2\u0087"+
		"\u0088\7P\2\2\u0088\u0089\7Q\2\2\u0089\u008a\7R\2\2\u008a(\3\2\2\2\u008b"+
		"\u008c\7\62\2\2\u008c\u008d\7d\2\2\u008d\u008f\3\2\2\2\u008e\u0090\t\2"+
		"\2\2\u008f\u008e\3\2\2\2\u0090\u0091\3\2\2\2\u0091\u008f\3\2\2\2\u0091"+
		"\u0092\3\2\2\2\u0092*\3\2\2\2\u0093\u0095\t\3\2\2\u0094\u0093\3\2\2\2"+
		"\u0095\u0096\3\2\2\2\u0096\u0094\3\2\2\2\u0096\u0097\3\2\2\2\u0097,\3"+
		"\2\2\2\u0098\u0099\7\62\2\2\u0099\u009a\7z\2\2\u009a\u009c\3\2\2\2\u009b"+
		"\u009d\t\4\2\2\u009c\u009b\3\2\2\2\u009d\u009e\3\2\2\2\u009e\u009c\3\2"+
		"\2\2\u009e\u009f\3\2\2\2\u009f.\3\2\2\2\u00a0\u00a1\7O\2\2\u00a1\u00a2"+
		"\7W\2\2\u00a2\u00a3\7N\2\2\u00a3\60\3\2\2\2\u00a4\u00a5\7P\2\2\u00a5\u00a6"+
		"\7Q\2\2\u00a6\u00a7\7V\2\2\u00a7\62\3\2\2\2\u00a8\u00a9\7.\2\2\u00a9\64"+
		"\3\2\2\2\u00aa\u00ab\7=\2\2\u00ab\66\3\2\2\2\u00ac\u00ad\7\61\2\2\u00ad"+
		"\u00ae\7,\2\2\u00ae\u00b2\3\2\2\2\u00af\u00b1\13\2\2\2\u00b0\u00af\3\2"+
		"\2\2\u00b1\u00b4\3\2\2\2\u00b2\u00b3\3\2\2\2\u00b2\u00b0\3\2\2\2\u00b3"+
		"\u00b5\3\2\2\2\u00b4\u00b2\3\2\2\2\u00b5\u00b6\7,\2\2\u00b6\u00b7\7\61"+
		"\2\2\u00b7\u00b8\3\2\2\2\u00b8\u00b9\b\34\2\2\u00b98\3\2\2\2\u00ba\u00bb"+
		"\7\61\2\2\u00bb\u00bc\7\61\2\2\u00bc\u00c0\3\2\2\2\u00bd\u00bf\n\5\2\2"+
		"\u00be\u00bd\3\2\2\2\u00bf\u00c2\3\2\2\2\u00c0\u00be\3\2\2\2\u00c0\u00c1"+
		"\3\2\2\2\u00c1\u00c3\3\2\2\2\u00c2\u00c0\3\2\2\2\u00c3\u00c4\b\35\2\2"+
		"\u00c4:\3\2\2\2\u00c5\u00c9\7%\2\2\u00c6\u00c8\n\5\2\2\u00c7\u00c6\3\2"+
		"\2\2\u00c8\u00cb\3\2\2\2\u00c9\u00c7\3\2\2\2\u00c9\u00ca\3\2\2\2\u00ca"+
		"\u00cc\3\2\2\2\u00cb\u00c9\3\2\2\2\u00cc\u00cd\b\36\2\2\u00cd<\3\2\2\2"+
		"\u00ce\u00d0\t\6\2\2\u00cf\u00ce\3\2\2\2\u00d0\u00d1\3\2\2\2\u00d1\u00cf"+
		"\3\2\2\2\u00d1\u00d2\3\2\2\2\u00d2\u00d3\3\2\2\2\u00d3\u00d4\b\37\2\2"+
		"\u00d4>\3\2\2\2\u00d5\u00d7\7\60\2\2\u00d6\u00d8\t\7\2\2\u00d7\u00d6\3"+
		"\2\2\2\u00d8\u00d9\3\2\2\2\u00d9\u00d7\3\2\2\2\u00d9\u00da\3\2\2\2\u00da"+
		"@\3\2\2\2\13\2\u0091\u0096\u009e\u00b2\u00c0\u00c9\u00d1\u00d9\3\b\2\2";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}