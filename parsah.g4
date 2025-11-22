// It all starts here...
grammar parsah;

// Entry point
program
    : statement* EOF
    ;

statement
    : simpleStatement
    | ifStatement
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
    : 'if' expression ':' NEWLINE then
      ('elif' expression ':' NEWLINE then)*
      ('else' ':' NEWLINE then)?
    ;
// add then statment here


// expression
// we need to add more for boolean
expression
  : '(' expression ')'                                   
  | literal                                              
  | array                                                
  | expression op=('*' | '/' | '%') expression           
  | expression op=('+' | '-') expression                
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

// ===== Literals =====
STRING
  : '"'  ( ~["\\] | '\\' . )*  '"'
  | '\'' ( ~['\\] | '\\' . )*  '\''
  ;

// Literals (Matches parsalicious style [cite: 46])
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

// ===== End-of-line =====
NEWLINE : ('\r'? '\n')+ ;

// ===== Skipped stuff =====
WS : [ \t]+ -> skip ;