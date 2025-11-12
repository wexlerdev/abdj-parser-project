//------------------
// LEXER RULES
//------------------
// ===== Keywords / Bools (place BEFORE identifiers so they win) =====
TRUE  : 'True' ;
FALSE : 'False' ;

// ===== Literals =====
STRING
  : '"'  ( ~["\\] | '\\' . )*  '"'
  | '\'' ( ~['\\] | '\\' . )*  '\''
  ;

FLOAT : [0-9]+ '.' [0-9]+ ;
INT   : [0-9]+;

// ===== Identifiers =====
VARNAME : [a-zA-Z_] [a-zA-Z_0-9]* ;
