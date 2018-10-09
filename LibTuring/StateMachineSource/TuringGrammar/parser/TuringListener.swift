// Generated from /Users/xudong/PycharmProjects/ObjCParser/Sources/Turing.g4 by ANTLR 4.7
import Antlr4

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link TuringParser}.
 */
public protocol TuringListener: ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link TuringParser#entry}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterEntry(_ ctx: TuringParser.EntryContext)
	/**
	 * Exit a parse tree produced by {@link TuringParser#entry}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitEntry(_ ctx: TuringParser.EntryContext)
	/**
	 * Enter a parse tree produced by {@link TuringParser#state_machine_define}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterState_machine_define(_ ctx: TuringParser.State_machine_defineContext)
	/**
	 * Exit a parse tree produced by {@link TuringParser#state_machine_define}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitState_machine_define(_ ctx: TuringParser.State_machine_defineContext)
	/**
	 * Enter a parse tree produced by {@link TuringParser#initial_define}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterInitial_define(_ ctx: TuringParser.Initial_defineContext)
	/**
	 * Exit a parse tree produced by {@link TuringParser#initial_define}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitInitial_define(_ ctx: TuringParser.Initial_defineContext)
	/**
	 * Enter a parse tree produced by {@link TuringParser#transition_define}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterTransition_define(_ ctx: TuringParser.Transition_defineContext)
	/**
	 * Exit a parse tree produced by {@link TuringParser#transition_define}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitTransition_define(_ ctx: TuringParser.Transition_defineContext)
	/**
	 * Enter a parse tree produced by {@link TuringParser#transition_from}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterTransition_from(_ ctx: TuringParser.Transition_fromContext)
	/**
	 * Exit a parse tree produced by {@link TuringParser#transition_from}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitTransition_from(_ ctx: TuringParser.Transition_fromContext)
	/**
	 * Enter a parse tree produced by {@link TuringParser#transition_to}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterTransition_to(_ ctx: TuringParser.Transition_toContext)
	/**
	 * Exit a parse tree produced by {@link TuringParser#transition_to}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitTransition_to(_ ctx: TuringParser.Transition_toContext)
	/**
	 * Enter a parse tree produced by {@link TuringParser#input}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterInput(_ ctx: TuringParser.InputContext)
	/**
	 * Exit a parse tree produced by {@link TuringParser#input}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitInput(_ ctx: TuringParser.InputContext)
	/**
	 * Enter a parse tree produced by {@link TuringParser#stack_op}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterStack_op(_ ctx: TuringParser.Stack_opContext)
	/**
	 * Exit a parse tree produced by {@link TuringParser#stack_op}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitStack_op(_ ctx: TuringParser.Stack_opContext)
	/**
	 * Enter a parse tree produced by {@link TuringParser#check_stack}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterCheck_stack(_ ctx: TuringParser.Check_stackContext)
	/**
	 * Exit a parse tree produced by {@link TuringParser#check_stack}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitCheck_stack(_ ctx: TuringParser.Check_stackContext)
	/**
	 * Enter a parse tree produced by {@link TuringParser#push_stack}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterPush_stack(_ ctx: TuringParser.Push_stackContext)
	/**
	 * Exit a parse tree produced by {@link TuringParser#push_stack}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitPush_stack(_ ctx: TuringParser.Push_stackContext)
	/**
	 * Enter a parse tree produced by {@link TuringParser#pop_stack}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterPop_stack(_ ctx: TuringParser.Pop_stackContext)
	/**
	 * Exit a parse tree produced by {@link TuringParser#pop_stack}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitPop_stack(_ ctx: TuringParser.Pop_stackContext)
}