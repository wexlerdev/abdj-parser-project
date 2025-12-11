// It all starts here...
grammar parsah;

// Entry point
program
    : statement* EOF
    ;

statement
    : simpleStatement
    | ifStatement
    | whileStatement
    | forStatement
    ;

simpleStatement
    : (assignment | compoundAssignment | expression) NEWLINE?
    ;

assignment
    : VARNAME ASSIGN expression
    ;

compoundAssignment
    : VARNAME (AUG_ADD | AUG_SUB | AUG_MUL | AUG_DIV | AUG_MOD) expression
    ;


// if statements
ifStatement
    : TAB* 'if' expression ':' NEWLINE then+
      TAB* ('elif' expression ':' NEWLINE then)*
      TAB* ('else' ':' NEWLINE then)?
    ;


whileStatement
    : 'while' expression ':' NEWLINE then+
    ;

forStatement
    : 'for' VARNAME 'in' expression ':' NEWLINE then+
    ;


then
    : indentedStatement+
    ;


indentedStatement
    : TAB+ statement
    ;

expression
    : functionCall
    |'(' expression ')'
    | literal
    | array                                     
    | '-' expression
    | 'not' expression                        
    | expression op=('*' | '/' | '%') expression  
    | expression op=('+' | '-') expression    
    | expression op=('<' | '<=' | '>' | '>=') expression 
    | expression op=('==' | '!=') expression     
    | expression 'and' expression              
    | expression 'or' expression             
    ;

// function call 
functionCall
    : VARNAME '(' (expression (',' expression)*)? ')'
    ;

// array!
array
    : LBRACKET (expression (COMMA expression)*)? RBRACKET
    ;

// literals
literal
    : INT
    | FLOAT
    | STRING
    | TRUE
    | FALSE
    | VARNAME
    ;

//------------------
// LEXER RULES
//------------------
// ===== Keywords / Bools (place BEFORE identifiers so they win) =====
TRUE  : 'True';
FALSE : 'False';

// ===== Comments =====
BLOCK_COMMENT
    : '\'\'\'' ( . | '\r' | '\n' )*? '\'\'\'' NEWLINE* -> skip
    ;

COMMENT
    : '#' ~[\r\n]* NEWLINE* -> skip
    ;

// ===== Literals =====
STRING
  : '"'  ( ~["\\] | '\\' . )* '"'
  | '\'' ( ~['\\] | '\\' . )* '\''
;

// Literals 
FLOAT : [0-9]+ '.' [0-9]+ ; 
INT   : [0-9]+;

// ===== Identifiers =====
VARNAME : [a-zA-Z_] [a-zA-Z_0-9]* ;

// ===== Operators (longest first) =====
// Augmented assignment
AUG_ADD : '+=' ;
AUG_SUB : '-=' ;
AUG_MUL : '*=' ;
AUG_DIV : '/=' ;
AUG_MOD : '%=' ;

// Plain assignment
ASSIGN  : '=' ;

// Arithmetic (you can use these tokens or literal chars in parser; both work)
PLUS  : '+' ;
MINUS : '-' ;
MULT  : '*' ;
DIV   : '/' ;
MOD   : '%' ;

// ===== Delimiters =====
LBRACKET : '[' ;
RBRACKET : ']' ;
COMMA    : ',' ;

TAB : '\t';

// ===== End-of-line =====
NEWLINE : ('\r'? '\n')+ ;


// Whitespace
WS : [ ]+ -> skip ;

