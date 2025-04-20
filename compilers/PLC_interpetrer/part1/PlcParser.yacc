
%%

%name PlcParser

%pos int

%term  NUM of int | NAME of string | TRUE | FALSE 
    |  OPnot  | OPminus | HD | TL | ISE | PRINT 
    | OPdisjun | OPplus | OPtimes | OPdiv | OPequal | OPVbar
    | OPdiff | OPless | OPlessEq | OP2cons | OPsemicolon 
    | OParrow | OP2arrow | OPcons | OPunder | OPcolon
    |  Lbrace | Rbrace | Lpar | Rpar | Lbracket | Rbracket 
    |  FUN  | REC | IF | THEN | ELSE | MATCH | WITH | VAR | FN 
    | END | NIL | BOOL | INT |  EOF  

%right OPsemicolon OParrow
%nonassoc IF 
%left ELSE
%left OPdisjun
%left OPequal OPdiff
%left OPless OPlessEq
%right OP2cons 
%left OPplus OPminus
%left OPtimes OPdiv
%nonassoc OPnot HD TL ISE PRINT 
%left Lbracket

%keyword FUN REC IF THEN ELSE MATCH WITH VAR FN END NIL BOOL INT FALSE TRUE HD TL PRINT OPunder ISE
%nonterm PLC of expr | prog of expr | EXPR of expr  | decl of expr 
        | args of (plcType*string) list | TYPE of plcType 
        | atomicExpr of expr | appExpr of expr 
        | matchExpr of (expr option * expr) list 
        | condExpr of expr option | const of expr | comps of expr list
        | typedVar of plcType*string | params of (plcType*string) list 
        | types of plcType list| atomicType of plcType

%eop EOF 

%noshift EOF

%start PLC



%%

PLC:        prog                        ( prog )
prog:       EXPR                        ( EXPR )      
    |       decl (* OPsemicolon prog *)      ( decl)

decl:       VAR NAME OPequal EXPR OPsemicolon prog      ( Let(NAME, EXPR, prog) )
    |       FUN NAME args OPequal EXPR OPsemicolon prog ( Let(NAME, makeAnon(args, EXPR), prog) )
    |       FUN REC NAME args OPcons TYPE OPequal EXPR OPsemicolon prog ( makeFun(NAME, args, TYPE, EXPR, prog) )

EXPR:       atomicExpr                  ( atomicExpr )
    |       appExpr                     ( appExpr )
    |       IF EXPR THEN EXPR ELSE EXPR ( If(EXPR1, EXPR2, EXPR3) )
    |       MATCH EXPR WITH matchExpr   ( Match(EXPR, matchExpr) )
    |       OPnot EXPR                  ( Prim1("!", EXPR) )
    |       OPminus EXPR                ( Prim1("-", EXPR) )
    |       HD EXPR                     ( Prim1("hd", EXPR) )
    |       TL EXPR                     ( Prim1("tl", EXPR) )
    |       ISE EXPR                    ( Prim1("ise", EXPR) )
    |       PRINT EXPR                  ( Prim1("print", EXPR) )
    |       EXPR OPdisjun EXPR          ( Prim2("&&", EXPR1, EXPR2) )
    |       EXPR OPplus EXPR            ( Prim2("+", EXPR1 , EXPR2 ) )
    |       EXPR OPminus EXPR           ( Prim2("-", EXPR1 , EXPR2 ) )
    |       EXPR OPtimes EXPR           ( Prim2("*", EXPR1 , EXPR2 ) )
    |       EXPR OPdiv EXPR             ( Prim2("/", EXPR1 , EXPR2 ) )
    |       EXPR OPequal EXPR           ( Prim2("=", EXPR1 , EXPR2 ) )
    |       EXPR OPdiff EXPR            ( Prim2("<>", EXPR1 , EXPR2 ) )
    |       EXPR OPless EXPR            ( Prim2("<", EXPR1 , EXPR2 ) )
    |       EXPR OPlessEq EXPR          ( Prim2("<=", EXPR1 , EXPR2 ) )
    |       EXPR OP2cons EXPR           ( Prim2("::", EXPR1 , EXPR2 ) )
    |       EXPR OPsemicolon EXPR       ( Prim2(";", EXPR1 , EXPR2 ) )
    |       EXPR Lbracket NUM Rbracket  ( Item (NUM, EXPR) )

atomicExpr: const                       ( const )
    |       NAME                        ( Var NAME )
    |       Lbrace prog Rbrace          ( prog )
    |       Lpar EXPR Rpar              ( EXPR )
    |       Lpar comps Rpar             ( List comps )
    |       FN args OP2arrow EXPR END   ( makeAnon(args, EXPR) )

appExpr:    atomicExpr atomicExpr       ( Call( atomicExpr1, atomicExpr2) )
    |       appExpr atomicExpr          ( Call( appExpr, atomicExpr) )

const:      TRUE                        ( ConB true )
    |       FALSE                       ( ConB false)
    |       NUM                         ( ConI NUM )
    |       Lpar Rpar                   ( List [] )
    |       Lpar TYPE Lbracket Rbracket Rpar    ( ESeq (TYPE) )

comps:      EXPR OPcolon EXPR           ( (EXPR1)::(EXPR2)::[])
    |       EXPR OPcolon comps          ( (EXPR)::comps )

matchExpr:  END                         ( [ ] )
    |       OPVbar condExpr OParrow EXPR matchExpr ( (condExpr, EXPR)::matchExpr )

condExpr:   EXPR                        ( SOME (EXPR) )
    |       OPunder                     ( NONE )

args:       Lpar Rpar                   ( [] )
    |       Lpar params Rpar            ( params )

params:     typedVar                    ( (typedVar)::[] )
    |       typedVar OPcolon params     ( (typedVar)::(params) )

typedVar:   TYPE NAME                   ( (TYPE, NAME))

TYPE:       atomicType                  ( atomicType )
    |       Lpar types Rpar             ( ListT types)
    |       Lbracket TYPE Rbracket      ( SeqT TYPE )
    |       TYPE OParrow TYPE           ( FunT (TYPE1, TYPE2) )

atomicType: NIL                         ( ListT [] )
    |       BOOL                        ( BoolT )
    |       INT                         ( IntT )
    |       Lpar TYPE Rpar              ( TYPE )

types:      TYPE OPcolon TYPE           ( (TYPE1)::(TYPE2)::[])
    |       TYPE OPcolon types          ( (TYPE)::(types))
