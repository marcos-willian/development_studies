cls
@echo off
del PlcParser.yacc.sml
del PlcParser.yacc.sig
del PlcLexer.lex.sml

ml-yacc PlcParser.yacc && ml-lex PlcLexer.lex