// Generated from /Users/xudong/PycharmProjects/ObjCParser/Sources/Turing.g4 by ANTLR 4.7
import Antlr4

open class TuringParser: Parser {

	internal static var _decisionToDFA: [DFA] = {
          var decisionToDFA = [DFA]()
          let length = TuringParser._ATN.getNumberOfDecisions()
          for i in 0..<length {
            decisionToDFA.append(DFA(TuringParser._ATN.getDecisionState(i)!, i))
           }
           return decisionToDFA
     }()
	internal static let _sharedContextCache: PredictionContextCache = PredictionContextCache()
	public enum Tokens: Int {
		case EOF = -1, CHECK = 1, PUSH = 2, POP = 3, STACK = 4, INITIAL = 5, ACTION = 6, 
                 LEFT_SQUARE_BRACKET = 7, RIGHT_SQUARE_BRACKET = 8, EQUAL = 9, 
                 IDENTIFIER = 10, WS = 11, COMMENT = 12, LINE_COMMENT = 13
	}
	public static let RULE_entry = 0, RULE_stack_define = 1, RULE_state_machine_define = 2, 
                   RULE_initial_define = 3, RULE_transition_define = 4, 
                   RULE_transition_from = 5, RULE_transition_to = 6, RULE_input = 7, 
                   RULE_stack_op = 8, RULE_check_stack = 9, RULE_push_stack = 10, 
                   RULE_pop_stack = 11
	public static let ruleNames: [String] = [
		"entry", "stack_define", "state_machine_define", "initial_define", "transition_define", 
		"transition_from", "transition_to", "input", "stack_op", "check_stack", 
		"push_stack", "pop_stack"
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

	override
	open func getGrammarFileName() -> String { return "Turing.g4" }

	override
	open func getRuleNames() -> [String] { return TuringParser.ruleNames }

	override
	open func getSerializedATN() -> String { return TuringParser._serializedATN }

	override
	open func getATN() -> ATN { return TuringParser._ATN }

	open override func getVocabulary() -> Vocabulary {
	    return TuringParser.VOCABULARY
	}

	public override init(_ input:TokenStream)throws {
	    RuntimeMetaData.checkVersion("4.7", RuntimeMetaData.VERSION)
		try super.init(input)
		_interp = ParserATNSimulator(self,TuringParser._ATN,TuringParser._decisionToDFA, TuringParser._sharedContextCache)
	}
	open class EntryContext:ParserRuleContext {
		open func state_machine_define() -> State_machine_defineContext? {
			return getRuleContext(State_machine_defineContext.self,0)
		}
		open func EOF() -> TerminalNode? { return getToken(TuringParser.Tokens.EOF.rawValue, 0) }
		open func stack_define() -> Stack_defineContext? {
			return getRuleContext(Stack_defineContext.self,0)
		}
		open override func getRuleIndex() -> Int { return TuringParser.RULE_entry }
		override
		open func enterRule(_ listener: ParseTreeListener) {
			if listener is TuringListener {
			 	(listener as! TuringListener).enterEntry(self)
			}
		}
		override
		open func exitRule(_ listener: ParseTreeListener) {
			if listener is TuringListener {
			 	(listener as! TuringListener).exitEntry(self)
			}
		}
	}
	@discardableResult
	open func entry() throws -> EntryContext {
		var _localctx: EntryContext = EntryContext(_ctx, getState())
		try enterRule(_localctx, 0, TuringParser.RULE_entry)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(25)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	if (//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = _la == TuringParser.Tokens.STACK.rawValue
		 	      return testSet
		 	 }()) {
		 		setState(24)
		 		try stack_define()

		 	}

		 	setState(27)
		 	try state_machine_define()
		 	setState(28)
		 	try match(TuringParser.Tokens.EOF.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}
	open class Stack_defineContext:ParserRuleContext {
		open func STACK() -> TerminalNode? { return getToken(TuringParser.Tokens.STACK.rawValue, 0) }
		open func IDENTIFIER() -> Array<TerminalNode> { return getTokens(TuringParser.Tokens.IDENTIFIER.rawValue) }
		open func IDENTIFIER(_ i:Int) -> TerminalNode?{
			return getToken(TuringParser.Tokens.IDENTIFIER.rawValue, i)
		}
		open override func getRuleIndex() -> Int { return TuringParser.RULE_stack_define }
		override
		open func enterRule(_ listener: ParseTreeListener) {
			if listener is TuringListener {
			 	(listener as! TuringListener).enterStack_define(self)
			}
		}
		override
		open func exitRule(_ listener: ParseTreeListener) {
			if listener is TuringListener {
			 	(listener as! TuringListener).exitStack_define(self)
			}
		}
	}
	@discardableResult
	open func stack_define() throws -> Stack_defineContext {
		var _localctx: Stack_defineContext = Stack_defineContext(_ctx, getState())
		try enterRule(_localctx, 2, TuringParser.RULE_stack_define)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(30)
		 	try match(TuringParser.Tokens.STACK.rawValue)
		 	setState(32) 
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	repeat {
		 		setState(31)
		 		try match(TuringParser.Tokens.IDENTIFIER.rawValue)


		 		setState(34); 
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 	} while (//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = _la == TuringParser.Tokens.IDENTIFIER.rawValue
		 	      return testSet
		 	 }())

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}
	open class State_machine_defineContext:ParserRuleContext {
		open func initial_define() -> Initial_defineContext? {
			return getRuleContext(Initial_defineContext.self,0)
		}
		open func transition_define() -> Array<Transition_defineContext> {
			return getRuleContexts(Transition_defineContext.self)
		}
		open func transition_define(_ i: Int) -> Transition_defineContext? {
			return getRuleContext(Transition_defineContext.self,i)
		}
		open override func getRuleIndex() -> Int { return TuringParser.RULE_state_machine_define }
		override
		open func enterRule(_ listener: ParseTreeListener) {
			if listener is TuringListener {
			 	(listener as! TuringListener).enterState_machine_define(self)
			}
		}
		override
		open func exitRule(_ listener: ParseTreeListener) {
			if listener is TuringListener {
			 	(listener as! TuringListener).exitState_machine_define(self)
			}
		}
	}
	@discardableResult
	open func state_machine_define() throws -> State_machine_defineContext {
		var _localctx: State_machine_defineContext = State_machine_defineContext(_ctx, getState())
		try enterRule(_localctx, 4, TuringParser.RULE_state_machine_define)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(36)
		 	try initial_define()
		 	setState(38) 
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	repeat {
		 		setState(37)
		 		try transition_define()


		 		setState(40); 
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 	} while (//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = _la == TuringParser.Tokens.IDENTIFIER.rawValue
		 	      return testSet
		 	 }())

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}
	open class Initial_defineContext:ParserRuleContext {
		open func INITIAL() -> TerminalNode? { return getToken(TuringParser.Tokens.INITIAL.rawValue, 0) }
		open func IDENTIFIER() -> TerminalNode? { return getToken(TuringParser.Tokens.IDENTIFIER.rawValue, 0) }
		open override func getRuleIndex() -> Int { return TuringParser.RULE_initial_define }
		override
		open func enterRule(_ listener: ParseTreeListener) {
			if listener is TuringListener {
			 	(listener as! TuringListener).enterInitial_define(self)
			}
		}
		override
		open func exitRule(_ listener: ParseTreeListener) {
			if listener is TuringListener {
			 	(listener as! TuringListener).exitInitial_define(self)
			}
		}
	}
	@discardableResult
	open func initial_define() throws -> Initial_defineContext {
		var _localctx: Initial_defineContext = Initial_defineContext(_ctx, getState())
		try enterRule(_localctx, 6, TuringParser.RULE_initial_define)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(42)
		 	try match(TuringParser.Tokens.INITIAL.rawValue)
		 	setState(43)
		 	try match(TuringParser.Tokens.IDENTIFIER.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}
	open class Transition_defineContext:ParserRuleContext {
		open func transition_from() -> Transition_fromContext? {
			return getRuleContext(Transition_fromContext.self,0)
		}
		open func ACTION() -> Array<TerminalNode> { return getTokens(TuringParser.Tokens.ACTION.rawValue) }
		open func ACTION(_ i:Int) -> TerminalNode?{
			return getToken(TuringParser.Tokens.ACTION.rawValue, i)
		}
		open func input() -> InputContext? {
			return getRuleContext(InputContext.self,0)
		}
		open func transition_to() -> Transition_toContext? {
			return getRuleContext(Transition_toContext.self,0)
		}
		open func stack_op() -> Stack_opContext? {
			return getRuleContext(Stack_opContext.self,0)
		}
		open override func getRuleIndex() -> Int { return TuringParser.RULE_transition_define }
		override
		open func enterRule(_ listener: ParseTreeListener) {
			if listener is TuringListener {
			 	(listener as! TuringListener).enterTransition_define(self)
			}
		}
		override
		open func exitRule(_ listener: ParseTreeListener) {
			if listener is TuringListener {
			 	(listener as! TuringListener).exitTransition_define(self)
			}
		}
	}
	@discardableResult
	open func transition_define() throws -> Transition_defineContext {
		var _localctx: Transition_defineContext = Transition_defineContext(_ctx, getState())
		try enterRule(_localctx, 8, TuringParser.RULE_transition_define)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(45)
		 	try transition_from()
		 	setState(46)
		 	try match(TuringParser.Tokens.ACTION.rawValue)
		 	setState(47)
		 	try input()
		 	setState(48)
		 	try match(TuringParser.Tokens.ACTION.rawValue)
		 	setState(49)
		 	try transition_to()
		 	setState(51)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	if (//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = _la == TuringParser.Tokens.LEFT_SQUARE_BRACKET.rawValue
		 	      return testSet
		 	 }()) {
		 		setState(50)
		 		try stack_op()

		 	}


		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}
	open class Transition_fromContext:ParserRuleContext {
		open func IDENTIFIER() -> TerminalNode? { return getToken(TuringParser.Tokens.IDENTIFIER.rawValue, 0) }
		open override func getRuleIndex() -> Int { return TuringParser.RULE_transition_from }
		override
		open func enterRule(_ listener: ParseTreeListener) {
			if listener is TuringListener {
			 	(listener as! TuringListener).enterTransition_from(self)
			}
		}
		override
		open func exitRule(_ listener: ParseTreeListener) {
			if listener is TuringListener {
			 	(listener as! TuringListener).exitTransition_from(self)
			}
		}
	}
	@discardableResult
	open func transition_from() throws -> Transition_fromContext {
		var _localctx: Transition_fromContext = Transition_fromContext(_ctx, getState())
		try enterRule(_localctx, 10, TuringParser.RULE_transition_from)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(53)
		 	try match(TuringParser.Tokens.IDENTIFIER.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}
	open class Transition_toContext:ParserRuleContext {
		open func IDENTIFIER() -> TerminalNode? { return getToken(TuringParser.Tokens.IDENTIFIER.rawValue, 0) }
		open override func getRuleIndex() -> Int { return TuringParser.RULE_transition_to }
		override
		open func enterRule(_ listener: ParseTreeListener) {
			if listener is TuringListener {
			 	(listener as! TuringListener).enterTransition_to(self)
			}
		}
		override
		open func exitRule(_ listener: ParseTreeListener) {
			if listener is TuringListener {
			 	(listener as! TuringListener).exitTransition_to(self)
			}
		}
	}
	@discardableResult
	open func transition_to() throws -> Transition_toContext {
		var _localctx: Transition_toContext = Transition_toContext(_ctx, getState())
		try enterRule(_localctx, 12, TuringParser.RULE_transition_to)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(55)
		 	try match(TuringParser.Tokens.IDENTIFIER.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}
	open class InputContext:ParserRuleContext {
		open func IDENTIFIER() -> TerminalNode? { return getToken(TuringParser.Tokens.IDENTIFIER.rawValue, 0) }
		open override func getRuleIndex() -> Int { return TuringParser.RULE_input }
		override
		open func enterRule(_ listener: ParseTreeListener) {
			if listener is TuringListener {
			 	(listener as! TuringListener).enterInput(self)
			}
		}
		override
		open func exitRule(_ listener: ParseTreeListener) {
			if listener is TuringListener {
			 	(listener as! TuringListener).exitInput(self)
			}
		}
	}
	@discardableResult
	open func input() throws -> InputContext {
		var _localctx: InputContext = InputContext(_ctx, getState())
		try enterRule(_localctx, 14, TuringParser.RULE_input)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(57)
		 	try match(TuringParser.Tokens.IDENTIFIER.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}
	open class Stack_opContext:ParserRuleContext {
		open func LEFT_SQUARE_BRACKET() -> TerminalNode? { return getToken(TuringParser.Tokens.LEFT_SQUARE_BRACKET.rawValue, 0) }
		open func RIGHT_SQUARE_BRACKET() -> TerminalNode? { return getToken(TuringParser.Tokens.RIGHT_SQUARE_BRACKET.rawValue, 0) }
		open func check_stack() -> Check_stackContext? {
			return getRuleContext(Check_stackContext.self,0)
		}
		open func push_stack() -> Push_stackContext? {
			return getRuleContext(Push_stackContext.self,0)
		}
		open func pop_stack() -> Pop_stackContext? {
			return getRuleContext(Pop_stackContext.self,0)
		}
		open override func getRuleIndex() -> Int { return TuringParser.RULE_stack_op }
		override
		open func enterRule(_ listener: ParseTreeListener) {
			if listener is TuringListener {
			 	(listener as! TuringListener).enterStack_op(self)
			}
		}
		override
		open func exitRule(_ listener: ParseTreeListener) {
			if listener is TuringListener {
			 	(listener as! TuringListener).exitStack_op(self)
			}
		}
	}
	@discardableResult
	open func stack_op() throws -> Stack_opContext {
		var _localctx: Stack_opContext = Stack_opContext(_ctx, getState())
		try enterRule(_localctx, 16, TuringParser.RULE_stack_op)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(59)
		 	try match(TuringParser.Tokens.LEFT_SQUARE_BRACKET.rawValue)
		 	setState(61)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	if (//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = _la == TuringParser.Tokens.CHECK.rawValue
		 	      return testSet
		 	 }()) {
		 		setState(60)
		 		try check_stack()

		 	}

		 	setState(65)
		 	try _errHandler.sync(self)
		 	switch (TuringParser.Tokens(rawValue: try _input.LA(1))!) {
		 	case .PUSH:
		 	 	setState(63)
		 	 	try push_stack()

		 		break

		 	case .POP:
		 	 	setState(64)
		 	 	try pop_stack()

		 		break

		 	case .RIGHT_SQUARE_BRACKET:
		 		break
		 	default:
		 		break
		 	}
		 	setState(67)
		 	try match(TuringParser.Tokens.RIGHT_SQUARE_BRACKET.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}
	open class Check_stackContext:ParserRuleContext {
		open func CHECK() -> TerminalNode? { return getToken(TuringParser.Tokens.CHECK.rawValue, 0) }
		open func IDENTIFIER() -> TerminalNode? { return getToken(TuringParser.Tokens.IDENTIFIER.rawValue, 0) }
		open override func getRuleIndex() -> Int { return TuringParser.RULE_check_stack }
		override
		open func enterRule(_ listener: ParseTreeListener) {
			if listener is TuringListener {
			 	(listener as! TuringListener).enterCheck_stack(self)
			}
		}
		override
		open func exitRule(_ listener: ParseTreeListener) {
			if listener is TuringListener {
			 	(listener as! TuringListener).exitCheck_stack(self)
			}
		}
	}
	@discardableResult
	open func check_stack() throws -> Check_stackContext {
		var _localctx: Check_stackContext = Check_stackContext(_ctx, getState())
		try enterRule(_localctx, 18, TuringParser.RULE_check_stack)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(69)
		 	try match(TuringParser.Tokens.CHECK.rawValue)
		 	setState(70)
		 	try match(TuringParser.Tokens.IDENTIFIER.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}
	open class Push_stackContext:ParserRuleContext {
		open func PUSH() -> TerminalNode? { return getToken(TuringParser.Tokens.PUSH.rawValue, 0) }
		open func IDENTIFIER() -> TerminalNode? { return getToken(TuringParser.Tokens.IDENTIFIER.rawValue, 0) }
		open override func getRuleIndex() -> Int { return TuringParser.RULE_push_stack }
		override
		open func enterRule(_ listener: ParseTreeListener) {
			if listener is TuringListener {
			 	(listener as! TuringListener).enterPush_stack(self)
			}
		}
		override
		open func exitRule(_ listener: ParseTreeListener) {
			if listener is TuringListener {
			 	(listener as! TuringListener).exitPush_stack(self)
			}
		}
	}
	@discardableResult
	open func push_stack() throws -> Push_stackContext {
		var _localctx: Push_stackContext = Push_stackContext(_ctx, getState())
		try enterRule(_localctx, 20, TuringParser.RULE_push_stack)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(72)
		 	try match(TuringParser.Tokens.PUSH.rawValue)
		 	setState(73)
		 	try match(TuringParser.Tokens.IDENTIFIER.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}
	open class Pop_stackContext:ParserRuleContext {
		open func POP() -> TerminalNode? { return getToken(TuringParser.Tokens.POP.rawValue, 0) }
		open override func getRuleIndex() -> Int { return TuringParser.RULE_pop_stack }
		override
		open func enterRule(_ listener: ParseTreeListener) {
			if listener is TuringListener {
			 	(listener as! TuringListener).enterPop_stack(self)
			}
		}
		override
		open func exitRule(_ listener: ParseTreeListener) {
			if listener is TuringListener {
			 	(listener as! TuringListener).exitPop_stack(self)
			}
		}
	}
	@discardableResult
	open func pop_stack() throws -> Pop_stackContext {
		var _localctx: Pop_stackContext = Pop_stackContext(_ctx, getState())
		try enterRule(_localctx, 22, TuringParser.RULE_pop_stack)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(75)
		 	try match(TuringParser.Tokens.POP.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

   public static let _serializedATN : String = TuringParserATN().jsonString
   public static let _ATN: ATN = ATNDeserializer().deserializeFromJson(_serializedATN)
}
