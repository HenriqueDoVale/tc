grammar Aguda;

program: declaration+ EOF;

declaration
    : 'let' ID ':' type '=' block                               #variableDeclaration
    | 'let' ID '(' paramList? ')' ':' type '=' block            #functionDeclaration
    ;

paramList: ID (',' ID)*;

type
    : 'Int'
    | 'Bool'
    | 'Unit'
    | 'String'
    | type '[]'
    | '(' type (',' type)* ')' '->' type
    | type '->' type
    ;

expression
    : ifExpr                                                       #passToIf
    | whileExpr                                                    #passToWhileExpr
    | logicExpr                                                    #passToLogic
    ;

block
    : (expression (';' expression)*)?                              #seqExpr
    ;

ifExpr
    : 'if' expression 'then' expression 'else' expression          #ifThenElseExpr
    | 'if' expression 'then' expression                            #ifThenExpr
    ;

whileExpr
    : 'while' expression 'do' '(' block ')'                        #whileLoop
    ;

logicExpr
    : logicExpr '||' andExpr                                         #logicalOrExpr
    | andExpr                                                        #passToAnd
    ;

andExpr
    : andExpr '&&' relExpr                                           #logicalAndExpr
    | relExpr                                                        #passToRel
    ;

relExpr
    : relExpr op=('==' | '!=' | '<' | '<=' | '>' | '>=') addExpr     #relationalExpr
    | addExpr                                                        #passToAdd
    ;

addExpr
    : addExpr op=('+' | '-') multExpr                                #addSubExpr
    | multExpr                                                       #passToMult
    ;

multExpr
    : multExpr op=('*' | '/' | '%' | '^') unaryExpr                  #mulDivModExpr
    | unaryExpr                                                      #passToUnary
    ;

unaryExpr
    : '-' unaryExpr                                                  #negateExpr
    | '!' unaryExpr                                                  #notExpr
    | primary                                                        #passToPrimary
    ;

primary
    : ID '(' argumentList? ')'                                       #functionCall
    | 'set' lhs '=' expression                                       #setExpr
    | 'let' ID ':' type '=' expression                               #letInExpr
    | 'new' type '[' expression '|' expression ']'                  #arrayCreation
    | primary '[' expression ']'                                     #arrayAccess
    | literal                                                        #literalExpr
    | ID                                                             #idExpr
    | '(' expression ')'                                             #parenExpr
    ;

lhs: ID | lhs '[' expression ']';

argumentList: expression (',' expression)*;

literal
    : INT
    | BOOL
    | STRING
    | 'null'
    ;

// --- Lexer rules ---

BOOL: 'true' | 'false';
ID: [a-zA-Z_] [a-zA-Z0-9_']*;
INT: '-'? [1-9] [0-9]* | '0';
STRING: '"' (~["\r\n])* '"';

WS: [ \t\r\n]+ -> skip;
LINE_COMMENT: '--' ~[\r\n]* -> skip;
