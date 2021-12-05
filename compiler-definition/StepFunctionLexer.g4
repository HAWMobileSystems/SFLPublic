lexer grammar StepFunctionLexer;

BlockComment : '/*' ( BlockComment | . )*? '*/'
    -> channel(HIDDEN);

LineComment : '//'  ~[\r\n]*
    -> channel(HIDDEN);

WhiteSpace : [\u0020\u0009\u000C]
    -> channel(HIDDEN);

NewLine : '\n' | '\r' '\n'?;

fragment Hidden: BlockComment | LineComment | WhiteSpace;


LBRACE      :  '{'  -> pushMode(DEFAULT_MODE);
RBRACE      :  '}'  { if (!_modeStack.isEmpty()) { popMode(); } };
LBRACK      :  '['  -> pushMode(Inside);
RBRACK      :  ']'          ;
LPAREN      :  '('  -> pushMode(Inside);
RPAREN      :  ')'          ;
SEMICOLON   :  ';'          ;
COMMA       :  ','          ;
EQ          :  '='          ;
EXCLEQ      :  '!='         ;
EQEQ        :  '=='         ;
GTEQ        :  '>='         ;
LTEQ        :  '<='         ;
EXCL        :  '!'  Hidden  ;
PLUSEQ      :  '+='         ;
PLUS        :  '+'          ;
PLUSPLUS    :  '++'         ;
MINUSEQ     :  '-='         ;
MINUS       :  '-'          ;
MINUSMINUS  :  '--'         ;
ANDAND      :  '&&'         ;
AND         :  '&'          ;
OR          :  '|'          ;
OROR        :  '||'         ;
LT          :  '<'          ;
MULEQ       :  '*='         ;
MUL         :  '*'          ;
DIVEQ       :  '/='         ;
DIV         :  '/'          ;
MODEQ       :  '%='         ;
MOD         :  '%'          ;
GT          :  '>'          ;
DOT         :  '.'          ;
DOTDOT      :  '..'         ;
UNDERSCORE  :  '_'          ;

//Keywords

STATICS:'Statics';
FUNCTIONS:'Functions';
STATECODE:'StateCode';

STARTFUNCTION:'Start';

INTEGER:'Integer';
STRING:'String';
DOUBLE:'Double';
BOOLEAN:'Boolean';
ARRAY:'Array';
OBJECT:'Object';

GLOBAL:'global';

WHILE:'while';
DO:'do';

IF:'if';
ELSE:'else';
TRY:'try';
CATCH:'catch';
FINALLY:'finally';

EXTERN: 'extern';
ASYNC: 'async';
JAVA_11: 'java11';
PYTHON_3_8: 'python3_8';



//Literals

fragment DecDigit: '0'..'9';
fragment DecDigitNoZero: '1'..'9';
fragment DecDigitOrSeparator: DecDigit | '_';

fragment DecDigits
    : DecDigit DecDigitOrSeparator* DecDigit
    | DecDigit
    ;

fragment DoubleExponent: [eE] [+-]? DecDigits;

DoubleLiteral
    : DecDigits? '.' DecDigits DoubleExponent?
    | DecDigits DoubleExponent
    ;

IntegerLiteral
    : DecDigitNoZero DecDigitOrSeparator* DecDigit
    | DecDigit
    ;

BooleanLiteral: 'true' | 'false';

NullLiteral: 'null';

Identifier : [a-zA-Z_][a-zA-Z0-9_]*;


//String
QUOTE_OPEN: '"' -> pushMode(String);


//Workaround, could be changed to mode
FunctionCode: '~!{' (Code | NewLine)*? '}!~';

Code: ~('\n' | '\r');



mode String;

QUOTE_CLOSE: '"' -> popMode;

StringText: ~('\\' | '"')+;

//TODO: Add Escaped Chars


//Insides

mode Inside;

Inside_LPAREN: LPAREN -> pushMode(Inside), type(LPAREN);
Inside_RPAREN: RPAREN -> popMode, type(RPAREN);

Inside_LBRACK: LBRACK -> pushMode(Inside), type(LBRACK);
Inside_RBRACK: RBRACK -> popMode, type(RBRACK);

Inside_LBRACE: LBRACE -> pushMode(DEFAULT_MODE), type(LBRACE);
Inside_RBRACE: RBRACE -> popMode, type(RBRACE);

Inside_DOT: DOT -> type(DOT);
Inside_COMMA: COMMA  -> type(COMMA);
Inside_MULT: MUL -> type(MUL);
Inside_MOD: MOD  -> type(MOD);
Inside_DIV: DIV -> type(DIV);
Inside_ADD: PLUS  -> type(PLUS);
Inside_SUB: MINUS  -> type(MINUS);
Inside_INCR: PLUSPLUS  -> type(PLUSPLUS);
Inside_DECR: MINUSMINUS  -> type(MINUSMINUS);
Inside_CONJ: ANDAND  -> type(ANDAND);
Inside_DISJ: OROR  -> type(OROR);
Inside_EXCL: '!' (Hidden|NewLine) -> type(EXCL);

Inside_SEMICOLON: SEMICOLON  -> type(SEMICOLON);
Inside_ASSIGNMENT: EQ  -> type(EQ);
Inside_ADD_ASSIGNMENT: PLUSEQ  -> type(PLUSEQ);
Inside_SUB_ASSIGNMENT: MINUSEQ  -> type(MINUSEQ);
Inside_MULT_ASSIGNMENT: MULEQ  -> type(MULEQ);
Inside_DIV_ASSIGNMENT: DIVEQ  -> type(DIVEQ);
Inside_MOD_ASSIGNMENT: MODEQ  -> type(MODEQ);

Inside_RANGE: DOTDOT  -> type(DOTDOT);

Inside_LANGLE: LT  -> type(LT);
Inside_RANGLE: GT  -> type(GT);
Inside_LE: LTEQ  -> type(LTEQ);
Inside_GE: GTEQ  -> type(GTEQ);
Inside_EXCL_EQ: EXCLEQ  -> type(EXCLEQ);
Inside_EQEQ: EQEQ  -> type(EQEQ);
Inside_QUOTE_OPEN: QUOTE_OPEN -> pushMode(String), type(QUOTE_OPEN);


Inside_Statics:STATICS ->type(STATICS);
Inside_FUNCTIONS:FUNCTIONS->type(FUNCTIONS);
Inside_STATECODE:STATECODE->type(STATECODE);

Inside_STARTFUNCTION:STARTFUNCTION->type(STARTFUNCTION);

Inside_INTEGER:INTEGER->type(INTEGER);
Inside_STRING:STRING->type(STRING);
Inside_DOUBLE:DOUBLE->type(DOUBLE);
Inside_BOOLEAN:BOOLEAN->type(BOOLEAN);
Inside_ARRAY:ARRAY->type(ARRAY);
Inside_OBJECT:OBJECT->type(OBJECT);


Inside_WHILE:WHILE->type(WHILE);
Inside_DO:DO->type(DO);

Inside_IF:IF->type(IF);
Inside_ELSE:ELSE->type(ELSE);
Inside_TRY:TRY->type(TRY);
Inside_CATCH:CATCH->type(CATCH);
Inside_FINALLY:FINALLY->type(FINALLY);

Inside_EXTERN: EXTERN->type(EXTERN);
Inside_ASYNC: ASYNC->type(ASYNC);
Inside_JAVA_11: JAVA_11->type(JAVA_11);
Inside_PYTHON_3_8: PYTHON_3_8->type(PYTHON_3_8);


Inside_BooleanLiteral: BooleanLiteral -> type(BooleanLiteral);
Inside_IntegerLiteral: IntegerLiteral -> type(IntegerLiteral);
Inside_NullLiteral: NullLiteral -> type(NullLiteral);

Inside_Identifier: Identifier -> type(Identifier);
Inside_Comment: (LineComment) -> channel(HIDDEN);
Inside_WS: WhiteSpace -> channel(HIDDEN);
Inside_NL: NewLine -> channel(HIDDEN);


mode DEFAULT_MODE;

ErrorCharacter: .;