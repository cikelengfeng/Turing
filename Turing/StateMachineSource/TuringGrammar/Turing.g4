grammar Turing;


entry
    :   stack_define? state_machine_define EOF
    ;

stack_define
    :   STACK IDENTIFIER+
    ;

state_machine_define
    :   initial_define transition_define+
    ;
initial_define
    :   INITIAL IDENTIFIER
    ;
transition_define
    :   transition_from ACTION input ACTION transition_to stack_op
    ;
transition_from
    :   IDENTIFIER
    ;
transition_to
    :   IDENTIFIER
    ;
input
    :   IDENTIFIER
    ;
stack_op
    :   check_stack? (push_stack | pop_stack)?
    ;
check_stack
    :   LEFT_SQUARE_BRACKET IDENTIFIER RIGHT_SQUARE_BRACKET
    ;
push_stack
    :   PUSH IDENTIFIER
    ;
pop_stack
    :   POP
    ;


PUSH
    :   'push'
    ;
POP
    :   'pop'
    ;

STACK
    :   'stack'
    ;
INITIAL
    :   'initial'
    ;
ACTION
    :   '>'
    ;
LEFT_SQUARE_BRACKET
    :   '['
    ;
RIGHT_SQUARE_BRACKET
    :   ']'
    ;
EQUAL
    : '='
    ;
IDENTIFIER
	:	LETTER (LETTER|'0'..'9')*
	;

fragment
LETTER
	:	'$'
	|	'A'..'Z'
	|	'a'..'z'
	|	'_'
	;

WS  :  [ \r\n\t\u000C] -> channel(HIDDEN) ;

COMMENT
    :   '/*' .*? '*/'  -> channel(HIDDEN)
    ;

LINE_COMMENT
    : '//' ~[\r\n]*  -> channel(HIDDEN)
    ;

