(* Plc Lexer *)

(* User declarations *)

open Tokens
type pos = int
type slvalue = Tokens.svalue
type ('a,'b) token = ('a,'b) Tokens.token
type lexresult = (slvalue, pos)token

(* A function to print a message error on the screen. *)
val error = fn x => TextIO.output(TextIO.stdOut, x ^ "\n")
val lineNumber = ref 0
val pos = ref 0

(* Get the current line being read. *)
fun getLineAsString() =
    let
        val lineNum = !lineNumber
    in
        Int.toString lineNum
    end

(* Define what to do when the end of the file is reached. *)
fun eof () = Tokens.EOF(!pos,!pos)

(* Initialize the lexer. *)
fun init() = ()
%%
%header (functor PlcLexerFun(structure Tokens: PlcParser_TOKENS));


digit=[0-9];
name=[a-z A-Z "_"][a-z A-Z "_" 0-9]*;

ws = [\ \t \n];

%s COMMENT;
simples = [^*];
complex = ("*"[^)]);



%%

"(*"  => (YYBEGIN COMMENT; lex());
<COMMENT> (\n)+ => (lex());
<COMMENT> {simples}+ => (lex());
<COMMENT> {complex}+ => (lex());
<COMMENT> "*)" => (YYBEGIN INITIAL; lex());
{ws}+       => (lex());
{digit}+    => (Tokens.NUM (valOf (Int.fromString yytext), !pos, !pos));
{name}+     => (case yytext of
                    "fun" => Tokens.FUN (!pos, !pos)
                |   "rec" => Tokens.REC(!pos, !pos)
                |   "if"  => Tokens.IF (!pos, !pos)
                |   "then" => Tokens.THEN(!pos, !pos)
                |   "else" => Tokens.ELSE(!pos, !pos)
                |   "match" => Tokens.MATCH(!pos, !pos)
                |   "with" => Tokens.WITH(!pos, !pos)
                |   "var" => Tokens.VAR(!pos, !pos)
                |   "fn"  => Tokens.FN(!pos, !pos)
                |   "end" => Tokens.END(!pos, !pos)
                |   "Nil" => Tokens.NIL(!pos, !pos)
                |   "Bool"=> Tokens.BOOL(!pos, !pos)
                |   "Int" => Tokens.INT(!pos, !pos)
                |   "false" => Tokens.FALSE(!pos, !pos)
                |   "true" => Tokens.TRUE(!pos, !pos)
                |   "hd" => Tokens.HD(!pos, !pos)
                |   "tl" => Tokens.TL(!pos,!pos)
                |   "print" => Tokens.PRINT(!pos, !pos)
                |   "_" => Tokens.OPunder(!pos, !pos)
                |   "ise" => Tokens.ISE(!pos, !pos)
                |   _ => Tokens.NAME (yytext, !pos, !pos));
"!"         => (Tokens.OPnot(!pos, !pos));
"-"         => (Tokens.OPminus(!pos, !pos));
"&&"        => (Tokens.OPdisjun(!pos, !pos));
"+"         => (Tokens.OPplus(!pos, !pos));
"*"         => (Tokens.OPtimes(!pos, !pos));
"/"         => (Tokens.OPdiv(!pos, !pos));
"="         => (Tokens.OPequal (!pos, !pos));
"|"         => (Tokens.OPVbar(!pos, !pos));
"!="        => (Tokens.OPdiff(!pos, !pos));
"<"         => (Tokens.OPless(!pos, !pos));
"<="        => (Tokens.OPlessEq(!pos, !pos));
"::"        => (Tokens.OP2cons(!pos, !pos));
";"         => (Tokens.OPsemicolon(!pos, !pos));
"->"        => (Tokens.OParrow(!pos, !pos));
"=>"        => (Tokens.OP2arrow(!pos, !pos));
":"         => (Tokens.OPcons(!pos, !pos));
","         => (Tokens.OPcolon(!pos, !pos));
"{"         => (Tokens.Lbrace(!pos, !pos));
"}"         => (Tokens.Rbrace(!pos, !pos));
"("         => (Tokens.Lpar(!pos, !pos));
")"         => (Tokens.Rpar(!pos, !pos));
"["         => (Tokens.Lbracket(!pos, !pos));
"]"         => (Tokens.Rbracket(!pos, !pos));


