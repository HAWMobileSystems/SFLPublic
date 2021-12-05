parser grammar StepFunctionParser;

options { tokenVocab = StepFunctionLexer; }

stepFunctionLanguageFile
    : staticsDeclaration functionsDeclaration stateCodeDeclaration EOF
    ;


/**************************
*      STATICS PART       *
**************************/
staticsDeclaration
    : STATICS NewLine* LBRACE NewLine* (staticDeclaration semis?)* NewLine* RBRACE NewLine*
    ;

staticDeclaration
    : variableModifier? type (variableDeclaration | multiVariableDeclaration)
    ;

variableDeclaration
    : Identifier
    ;

multiVariableDeclaration
    : variableDeclaration (COMMA variableDeclaration)*
    ;

type
    : simpleType
    | array
    | object
    ;

variableModifier
    : GLOBAL
    ;

simpleType
    : INTEGER
    | STRING
    | DOUBLE
    | BOOLEAN
    ;

array
    : ARRAY LT simpleType GT
    ;

object
    : OBJECT NewLine* LBRACE NewLine* (staticDeclaration semis?)+ NewLine* RBRACE
    ;

semis
    : (NewLine | SEMICOLON)+
    | EOF
    ;


/**************************
*     FUNCTIONS PART      *
**************************/
functionsDeclaration
    : FUNCTIONS NewLine* LBRACE NewLine* (functionDeclaration semis?)* NewLine* RBRACE NewLine*
    ;

functionDeclaration
    : functionModifier? Identifier LT languageType GT functionValueParameters (NewLine* FunctionCode)?
    ;

functionModifier
    : EXTERN
    ;

languageType
    : JAVA_11
    | PYTHON_3_8
    ;

functionValueParameters
    : LPAREN (functionValueParameter (COMMA functionValueParameter)* COMMA?)? RPAREN
    ;

functionValueParameter
    : Identifier
    ;



/**************************
*     STATE CODE PART     *
**************************/
stateCodeDeclaration
    : STATECODE NewLine* LBRACE NewLine* startFunction NewLine* RBRACE NewLine*
    ;

startFunction
    : STARTFUNCTION LPAREN RPAREN functionBody
    ;

functionBody
    : block
    ;

block
    : LBRACE NewLine* statements NewLine* RBRACE
    ;

statements
    : (statement (semis statement)*)? semis?
    ;

statement
    : assignment    #AssignmentStatement
    | loop          #LoopStatement
    | expression    #ExpressionStatement
    | ifClause      #IfStatement
    /*| try           #TryStatement*/
    ;

assignment
    : directlyAssignableExpression EQ NewLine* expression
    | assignableExpression assignmentAndOperator NewLine* expression
    ;

assignmentAndOperator
    : PLUSEQ
    | MINUSEQ
    | MULEQ
    | DIVEQ
    | MODEQ
    ;

directlyAssignableExpression
    :  postfixUnaryExpression assignableSuffix
    | Identifier
    | parenthesizedDirectlyAssignableExpression
    ;

assignableSuffix
    : indexingSuffix
    ;

parenthesizedDirectlyAssignableExpression
    : LPAREN NewLine* directlyAssignableExpression NewLine* RPAREN
    ;

assignableExpression
    : prefixUnaryExpression
    | parenthesizedAssignableExpression
    ;

parenthesizedAssignableExpression
    : LPAREN NewLine* assignableExpression NewLine* RPAREN
    ;




loop
    : whileLoop       #WhileLoopStatement
    | doWhileLoop   #DoWhileLoopStatement
    /*| forStatement */
    ;

whileLoop
    : WHILE NewLine* LPAREN expression RPAREN NewLine* controlStructureBody
    ;

doWhileLoop
    : DO NewLine* controlStructureBody NewLine* WHILE NewLine* LPAREN expression RPAREN
    ;

controlStructureBody
    : block
    | statement
    ;


ifClause
    : IF NewLine* LPAREN NewLine* expression NewLine* RPAREN NewLine* controlStructureBody
    | IF NewLine* LPAREN NewLine* expression NewLine* RPAREN NewLine* controlStructureBody? NewLine* ELSE NewLine* controlStructureBody
    ;


expression
    : disjunction
    ;

// ||
disjunction
    : conjunction (NewLine* OROR NewLine* conjunction)*
    ;

// &&
conjunction
    : equality (NewLine* ANDAND NewLine* equality)*
    ;

// == !=
equality
    : comparison (equalityOperator NewLine* comparison)*
    ;

equalityOperator
    : EXCLEQ
    | EQEQ
    ;

// < > <= >=
comparison
    : rangeExpression (comparisonOperator NewLine* rangeExpression)*
    ;

comparisonOperator
    : LT
    | GT
    | LTEQ
    | GTEQ
    ;

// ..
rangeExpression
    : additiveExpression (DOTDOT NewLine* additiveExpression)*
    ;

// + -
additiveExpression
    : multiplicativeExpression (additiveOperator NewLine* multiplicativeExpression)*
    ;

additiveOperator
    : PLUS
    | MINUS
    ;

// * / %
multiplicativeExpression
    : prefixUnaryExpression (multiplicativeOperator NewLine* prefixUnaryExpression)*
    ;

multiplicativeOperator
    : MUL
    | DIV
    | MOD
    ;


// async ++X --X +X -X !X
prefixUnaryExpression
    : unaryPrefix? postfixUnaryExpression
    ;

unaryPrefix
    : (modifier | prefixUnaryOperator)
    ;

modifier
    : ASYNC
    ;

prefixUnaryOperator
    :/* PLUSPLUS
    | MINUSMINUS
    | MINUS
    | PLUS
    |*/ EXCL
    ;


// () (params...) X++ X-- [index]
postfixUnaryExpression
    : primaryExpression
    | primaryExpression postfixUnarySuffix?
    ;

postfixUnarySuffix
    : callSuffix
    /*| postfixUnaryOperator*/
    | indexingSuffix
    ;

callSuffix
    : LPAREN NewLine* RPAREN
    /*| LPAREN NewLine* expression (NewLine* COMMA NewLine* expression)* (NewLine* COMMA)? NewLine* RPAREN*/
    ;

/*postfixUnaryOperator
    : PLUSPLUS
    | MINUSMINUS
    ;*/

indexingSuffix
    : LBRACK NewLine* expression NewLine* RBRACK
    ;


// (exp) identifier true 100 1.0 null "string"
primaryExpression
    : parenthesizedExpression
    | simpleIdentifier
    | literalConstant
    | stringLiteral
    ;

parenthesizedExpression
    : LPAREN NewLine* expression NewLine* RPAREN
    ;

simpleIdentifier
    : Identifier                    #DirectIdentifier
    | Identifier (DOT Identifier)*  #ObjectIdentifier
    ;

literalConstant
    : BooleanLiteral
    | IntegerLiteral
    | DoubleLiteral
    | NullLiteral
    ;

stringLiteral
    : QUOTE_OPEN (StringText)* QUOTE_CLOSE
    ;
