// Generated from /Users/xudong/PycharmProjects/ObjCParser/Sources/Turing.g4 by ANTLR 4.7
import Antlr4

open class TuringLexer: Lexer {
	internal static var _decisionToDFA: [DFA] = {
          var decisionToDFA = [DFA]()
          let length = TuringLexer._ATN.getNumberOfDecisions()
          for i in 0..<length {
          	    decisionToDFA.append(DFA(TuringLexer._ATN.getDecisionState(i)!, i))
          }
           return decisionToDFA
     }()

	internal static let _sharedContextCache:PredictionContextCache = PredictionContextCache()
	public static let CHECK=1, PUSH=2, POP=3, STACK=4, INITIAL=5, ACTION=6, 
                   LEFT_SQUARE_BRACKET=7, RIGHT_SQUARE_BRACKET=8, EQUAL=9, 
                   IDENTIFIER=10, WS=11, COMMENT=12, LINE_COMMENT=13
	public static let channelNames: [String] = [
		"DEFAULT_TOKEN_CHANNEL", "HIDDEN"
	]

	public static let modeNames: [String] = [
		"DEFAULT_MODE"
	]

	public static let ruleNames: [String] = [
		"CHECK", "PUSH", "POP", "STACK", "INITIAL", "ACTION", "LEFT_SQUARE_BRACKET", 
		"RIGHT_SQUARE_BRACKET", "EQUAL", "IDENTIFIER", "LETTER", "WS", "COMMENT", 
		"LINE_COMMENT"
	]

	private static let _LITERAL_NAMES: [String?] = [
		nil, "'check'", "'push'", "'pop'", "'stack'", "'initial'", "'>'", "'['", 
		"']'", "'='"
	]
	private static let _SYMBOLIC_NAMES: [String?] = [
		nil, "CHECK", "PUSH", "POP", "STACK", "INITIAL", "ACTION", "LEFT_SQUARE_BRACKET", 
		"RIGHT_SQUARE_BRACKET", "EQUAL", "IDENTIFIER", "WS", "COMMENT", "LINE_COMMENT"
	]
	public static let VOCABULARY: Vocabulary = Vocabulary(_LITERAL_NAMES, _SYMBOLIC_NAMES)

	/**
	 * @deprecated Use {@link #VOCABULARY} instead.
	 */
	//@Deprecated
	public let tokenNames: [String?]? = {
	    let length = _SYMBOLIC_NAMES.count
	    var tokenNames = [String?](repeating: nil, count: length)
		for i in 0..<length {
			var name = VOCABULARY.getLiteralName(i)
			if name == nil {
				name = VOCABULARY.getSymbolicName(i)
			}
			if name == nil {
				name = "<INVALID>"
			}
			tokenNames[i] = name
		}
		return tokenNames
	}()

	
	open func getTokenNames() -> [String?]? {
		return tokenNames
	}

    open override func getVocabulary() -> Vocabulary {
        return TuringLexer.VOCABULARY
    }

    public required init(_ input: CharStream) {
	    RuntimeMetaData.checkVersion("4.7", RuntimeMetaData.VERSION)
		super.init(input)
		_interp = LexerATNSimulator(self, TuringLexer._ATN, TuringLexer._decisionToDFA, TuringLexer._sharedContextCache)
	}

	override
	open func getGrammarFileName() -> String { return "Turing.g4" }

    override
	open func getRuleNames() -> [String] { return TuringLexer.ruleNames }

	override
	open func getSerializedATN() -> String { return TuringLexer._serializedATN }

	override
	open func getChannelNames() -> [String] { return TuringLexer.channelNames }

	override
	open func getModeNames() -> [String] { return TuringLexer.modeNames }

	override
	open func getATN() -> ATN { return TuringLexer._ATN }

    public static let _serializedATN: String = TuringLexerATN().jsonString
	public static let _ATN: ATN = ATNDeserializer().deserializeFromJson(_serializedATN)
}
