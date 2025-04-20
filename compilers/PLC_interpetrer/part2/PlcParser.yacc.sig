signature PlcParser_TOKENS =
sig
type ('a,'b) token
type svalue
val EOF:  'a * 'a -> (svalue,'a) token
val INT:  'a * 'a -> (svalue,'a) token
val BOOL:  'a * 'a -> (svalue,'a) token
val NIL:  'a * 'a -> (svalue,'a) token
val END:  'a * 'a -> (svalue,'a) token
val FN:  'a * 'a -> (svalue,'a) token
val VAR:  'a * 'a -> (svalue,'a) token
val WITH:  'a * 'a -> (svalue,'a) token
val MATCH:  'a * 'a -> (svalue,'a) token
val ELSE:  'a * 'a -> (svalue,'a) token
val THEN:  'a * 'a -> (svalue,'a) token
val IF:  'a * 'a -> (svalue,'a) token
val REC:  'a * 'a -> (svalue,'a) token
val FUN:  'a * 'a -> (svalue,'a) token
val Rbracket:  'a * 'a -> (svalue,'a) token
val Lbracket:  'a * 'a -> (svalue,'a) token
val Rpar:  'a * 'a -> (svalue,'a) token
val Lpar:  'a * 'a -> (svalue,'a) token
val Rbrace:  'a * 'a -> (svalue,'a) token
val Lbrace:  'a * 'a -> (svalue,'a) token
val OPcolon:  'a * 'a -> (svalue,'a) token
val OPunder:  'a * 'a -> (svalue,'a) token
val OPcons:  'a * 'a -> (svalue,'a) token
val OP2arrow:  'a * 'a -> (svalue,'a) token
val OParrow:  'a * 'a -> (svalue,'a) token
val OPsemicolon:  'a * 'a -> (svalue,'a) token
val OP2cons:  'a * 'a -> (svalue,'a) token
val OPlessEq:  'a * 'a -> (svalue,'a) token
val OPless:  'a * 'a -> (svalue,'a) token
val OPdiff:  'a * 'a -> (svalue,'a) token
val OPVbar:  'a * 'a -> (svalue,'a) token
val OPequal:  'a * 'a -> (svalue,'a) token
val OPdiv:  'a * 'a -> (svalue,'a) token
val OPtimes:  'a * 'a -> (svalue,'a) token
val OPplus:  'a * 'a -> (svalue,'a) token
val OPdisjun:  'a * 'a -> (svalue,'a) token
val PRINT:  'a * 'a -> (svalue,'a) token
val ISE:  'a * 'a -> (svalue,'a) token
val TL:  'a * 'a -> (svalue,'a) token
val HD:  'a * 'a -> (svalue,'a) token
val OPminus:  'a * 'a -> (svalue,'a) token
val OPnot:  'a * 'a -> (svalue,'a) token
val FALSE:  'a * 'a -> (svalue,'a) token
val TRUE:  'a * 'a -> (svalue,'a) token
val NAME: (string) *  'a * 'a -> (svalue,'a) token
val NUM: (int) *  'a * 'a -> (svalue,'a) token
end
signature PlcParser_LRVALS=
sig
structure Tokens : PlcParser_TOKENS
structure ParserData:PARSER_DATA
sharing type ParserData.Token.token = Tokens.token
sharing type ParserData.svalue = Tokens.svalue
end
