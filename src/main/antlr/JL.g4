// https://www.youtube.com/watch?v=FCWMr0VzpWY
// https://habr.com/ru/post/110710/
// https://tomassetti.me/antlr-mega-tutorial/

grammar JL;

syntax          : expr *                                ;

expr            : ( EXP | FLOAT| INTEGER )
                | LP expr RP
                | ADD expr
                | SUB expr
                | expr ADD expr
                | expr SUB expr
                | expr MUL expr
                | expr DIV expr
                | expr POW expr
                ;

LP              : '('                                   ;
RP              : ')'                                   ;

ADD             : '+'                                   ;
SUB             : '-'                                   ;
MUL             : '*'                                   ;
DIV             : '/'                                   ;
POW             : '^'                                   ;

fragment Np     : [0-9]+                                ;
fragment Ns     : [0-9]*                                ;

EXP             :   Np('.'Ns)?[eE][+\-]?Np              ;
FLOAT           :   Np'.'Ns|'.'Np                       ;
INTEGER         :   Np                                  ;

WHITESPACE      :    [ \t\r\n]+     -> skip             ;

LINECOMMENT     :   '#'.*?[\r\n]+   -> skip             ;
