functor PlcParserLrValsFun(structure Token : TOKEN)
 : sig structure ParserData : PARSER_DATA
       structure Tokens : PlcParser_TOKENS
   end
 = 
struct
structure ParserData=
struct
structure Header = 
struct


end
structure LrTable = Token.LrTable
structure Token = Token
local open LrTable in 
val table=let val actionRows =
"\
\\001\000\001\000\025\000\002\000\024\000\003\000\023\000\004\000\022\000\
\\005\000\021\000\006\000\020\000\007\000\019\000\008\000\018\000\
\\009\000\017\000\010\000\016\000\025\000\122\000\027\000\015\000\
\\029\000\014\000\035\000\012\000\038\000\011\000\041\000\009\000\000\000\
\\001\000\001\000\025\000\002\000\024\000\003\000\023\000\004\000\022\000\
\\005\000\021\000\006\000\020\000\007\000\019\000\008\000\018\000\
\\009\000\017\000\010\000\016\000\027\000\015\000\029\000\014\000\
\\033\000\013\000\035\000\012\000\038\000\011\000\040\000\010\000\
\\041\000\009\000\000\000\
\\001\000\001\000\025\000\002\000\024\000\003\000\023\000\004\000\022\000\
\\005\000\021\000\006\000\020\000\007\000\019\000\008\000\018\000\
\\009\000\017\000\010\000\016\000\027\000\015\000\029\000\014\000\
\\035\000\012\000\038\000\011\000\041\000\009\000\000\000\
\\001\000\001\000\025\000\002\000\024\000\003\000\023\000\004\000\022\000\
\\005\000\021\000\006\000\020\000\007\000\019\000\008\000\018\000\
\\009\000\017\000\010\000\016\000\027\000\015\000\029\000\056\000\
\\030\000\055\000\031\000\054\000\035\000\012\000\038\000\011\000\
\\041\000\009\000\043\000\053\000\044\000\052\000\045\000\051\000\000\000\
\\001\000\001\000\064\000\000\000\
\\001\000\002\000\042\000\000\000\
\\001\000\002\000\046\000\034\000\045\000\000\000\
\\001\000\002\000\085\000\000\000\
\\001\000\002\000\100\000\022\000\089\000\000\000\
\\001\000\006\000\039\000\011\000\038\000\012\000\037\000\013\000\036\000\
\\014\000\035\000\015\000\034\000\016\000\105\000\017\000\033\000\
\\018\000\032\000\019\000\031\000\020\000\030\000\021\000\029\000\
\\031\000\028\000\042\000\104\000\000\000\
\\001\000\006\000\039\000\011\000\038\000\012\000\037\000\013\000\036\000\
\\014\000\035\000\015\000\034\000\017\000\033\000\018\000\032\000\
\\019\000\031\000\020\000\030\000\021\000\029\000\026\000\091\000\
\\030\000\090\000\031\000\028\000\000\000\
\\001\000\006\000\039\000\011\000\038\000\012\000\037\000\013\000\036\000\
\\014\000\035\000\015\000\034\000\017\000\033\000\018\000\032\000\
\\019\000\031\000\020\000\030\000\021\000\029\000\028\000\144\000\
\\031\000\028\000\046\000\144\000\000\000\
\\001\000\006\000\039\000\011\000\038\000\012\000\037\000\013\000\036\000\
\\014\000\035\000\015\000\034\000\017\000\033\000\018\000\032\000\
\\019\000\031\000\020\000\030\000\021\000\029\000\031\000\028\000\
\\036\000\084\000\000\000\
\\001\000\006\000\039\000\011\000\038\000\012\000\037\000\013\000\036\000\
\\014\000\035\000\015\000\034\000\017\000\033\000\018\000\032\000\
\\019\000\031\000\020\000\030\000\021\000\029\000\031\000\028\000\
\\037\000\123\000\000\000\
\\001\000\006\000\039\000\011\000\038\000\012\000\037\000\013\000\036\000\
\\014\000\035\000\015\000\034\000\017\000\033\000\018\000\032\000\
\\019\000\031\000\020\000\030\000\021\000\029\000\031\000\028\000\
\\039\000\083\000\000\000\
\\001\000\006\000\039\000\011\000\038\000\012\000\037\000\013\000\036\000\
\\014\000\035\000\015\000\034\000\017\000\033\000\018\000\032\000\
\\019\000\031\000\020\000\030\000\021\000\029\000\031\000\028\000\
\\042\000\117\000\000\000\
\\001\000\006\000\039\000\011\000\038\000\012\000\037\000\013\000\036\000\
\\014\000\035\000\015\000\034\000\017\000\033\000\018\000\032\000\
\\019\000\031\000\020\000\030\000\021\000\119\000\031\000\028\000\000\000\
\\001\000\006\000\039\000\011\000\038\000\012\000\037\000\013\000\036\000\
\\014\000\035\000\015\000\034\000\017\000\033\000\018\000\032\000\
\\019\000\031\000\020\000\030\000\021\000\134\000\031\000\028\000\000\000\
\\001\000\006\000\039\000\011\000\038\000\012\000\037\000\013\000\036\000\
\\014\000\035\000\015\000\034\000\017\000\033\000\018\000\032\000\
\\019\000\031\000\020\000\030\000\021\000\140\000\031\000\028\000\000\000\
\\001\000\015\000\082\000\000\000\
\\001\000\015\000\108\000\000\000\
\\001\000\015\000\136\000\022\000\089\000\000\000\
\\001\000\016\000\105\000\042\000\104\000\000\000\
\\001\000\022\000\089\000\026\000\116\000\030\000\115\000\000\000\
\\001\000\022\000\089\000\026\000\116\000\030\000\115\000\031\000\088\000\000\000\
\\001\000\022\000\089\000\031\000\088\000\000\000\
\\001\000\022\000\089\000\032\000\113\000\000\000\
\\001\000\022\000\131\000\000\000\
\\001\000\023\000\076\000\000\000\
\\001\000\024\000\124\000\000\000\
\\001\000\028\000\095\000\000\000\
\\001\000\029\000\041\000\000\000\
\\001\000\029\000\081\000\030\000\080\000\031\000\054\000\043\000\053\000\
\\044\000\052\000\045\000\051\000\000\000\
\\001\000\029\000\081\000\031\000\054\000\043\000\053\000\044\000\052\000\
\\045\000\051\000\000\000\
\\001\000\030\000\087\000\000\000\
\\001\000\030\000\098\000\000\000\
\\001\000\030\000\114\000\000\000\
\\001\000\030\000\126\000\000\000\
\\001\000\032\000\096\000\000\000\
\\001\000\032\000\109\000\000\000\
\\001\000\046\000\000\000\000\000\
\\143\000\000\000\
\\144\000\006\000\039\000\011\000\038\000\012\000\037\000\013\000\036\000\
\\014\000\035\000\015\000\034\000\017\000\033\000\018\000\032\000\
\\019\000\031\000\020\000\030\000\021\000\029\000\031\000\028\000\000\000\
\\145\000\000\000\
\\146\000\000\000\
\\147\000\000\000\
\\148\000\000\000\
\\149\000\001\000\025\000\002\000\024\000\003\000\023\000\004\000\022\000\
\\027\000\015\000\029\000\014\000\041\000\009\000\000\000\
\\150\000\001\000\025\000\002\000\024\000\003\000\023\000\004\000\022\000\
\\027\000\015\000\029\000\014\000\041\000\009\000\000\000\
\\151\000\006\000\039\000\011\000\038\000\012\000\037\000\013\000\036\000\
\\014\000\035\000\015\000\034\000\017\000\033\000\018\000\032\000\
\\019\000\031\000\020\000\030\000\031\000\028\000\000\000\
\\152\000\000\000\
\\153\000\031\000\028\000\000\000\
\\154\000\013\000\036\000\014\000\035\000\031\000\028\000\000\000\
\\155\000\031\000\028\000\000\000\
\\156\000\031\000\028\000\000\000\
\\157\000\031\000\028\000\000\000\
\\158\000\031\000\028\000\000\000\
\\159\000\006\000\039\000\012\000\037\000\013\000\036\000\014\000\035\000\
\\015\000\034\000\017\000\033\000\018\000\032\000\019\000\031\000\
\\020\000\030\000\031\000\028\000\000\000\
\\160\000\013\000\036\000\014\000\035\000\031\000\028\000\000\000\
\\161\000\013\000\036\000\014\000\035\000\031\000\028\000\000\000\
\\162\000\031\000\028\000\000\000\
\\163\000\031\000\028\000\000\000\
\\164\000\006\000\039\000\012\000\037\000\013\000\036\000\014\000\035\000\
\\018\000\032\000\019\000\031\000\020\000\030\000\031\000\028\000\000\000\
\\165\000\006\000\039\000\012\000\037\000\013\000\036\000\014\000\035\000\
\\018\000\032\000\019\000\031\000\020\000\030\000\031\000\028\000\000\000\
\\166\000\006\000\039\000\012\000\037\000\013\000\036\000\014\000\035\000\
\\020\000\030\000\031\000\028\000\000\000\
\\167\000\006\000\039\000\012\000\037\000\013\000\036\000\014\000\035\000\
\\020\000\030\000\031\000\028\000\000\000\
\\168\000\006\000\039\000\012\000\037\000\013\000\036\000\014\000\035\000\
\\020\000\030\000\031\000\028\000\000\000\
\\169\000\006\000\039\000\011\000\038\000\012\000\037\000\013\000\036\000\
\\014\000\035\000\015\000\034\000\017\000\033\000\018\000\032\000\
\\019\000\031\000\020\000\030\000\021\000\029\000\031\000\028\000\000\000\
\\170\000\000\000\
\\171\000\000\000\
\\172\000\000\000\
\\173\000\000\000\
\\174\000\000\000\
\\175\000\000\000\
\\176\000\000\000\
\\177\000\000\000\
\\178\000\000\000\
\\179\000\000\000\
\\180\000\000\000\
\\181\000\000\000\
\\182\000\000\000\
\\183\000\000\000\
\\184\000\006\000\039\000\011\000\038\000\012\000\037\000\013\000\036\000\
\\014\000\035\000\015\000\034\000\017\000\033\000\018\000\032\000\
\\019\000\031\000\020\000\030\000\021\000\029\000\026\000\091\000\
\\031\000\028\000\000\000\
\\185\000\000\000\
\\186\000\000\000\
\\187\000\000\000\
\\188\000\006\000\039\000\011\000\038\000\012\000\037\000\013\000\036\000\
\\014\000\035\000\015\000\034\000\017\000\033\000\018\000\032\000\
\\019\000\031\000\020\000\030\000\021\000\029\000\031\000\028\000\000\000\
\\189\000\000\000\
\\190\000\000\000\
\\191\000\000\000\
\\192\000\026\000\099\000\000\000\
\\193\000\000\000\
\\194\000\000\000\
\\195\000\000\000\
\\196\000\000\000\
\\197\000\000\000\
\\198\000\022\000\089\000\000\000\
\\199\000\000\000\
\\200\000\000\000\
\\201\000\000\000\
\\202\000\000\000\
\\203\000\022\000\089\000\026\000\116\000\000\000\
\\204\000\000\000\
\"
val actionRowNumbers =
"\001\000\069\000\048\000\047\000\
\\043\000\042\000\041\000\031\000\
\\005\000\002\000\002\000\006\000\
\\003\000\001\000\002\000\002\000\
\\002\000\002\000\002\000\002\000\
\\078\000\077\000\070\000\079\000\
\\076\000\075\000\004\000\002\000\
\\002\000\002\000\002\000\002\000\
\\002\000\002\000\002\000\002\000\
\\002\000\002\000\028\000\032\000\
\\019\000\014\000\012\000\007\000\
\\031\000\093\000\034\000\025\000\
\\010\000\099\000\098\000\097\000\
\\033\000\080\000\003\000\030\000\
\\056\000\055\000\054\000\053\000\
\\052\000\051\000\038\000\067\000\
\\066\000\065\000\064\000\063\000\
\\062\000\061\000\060\000\058\000\
\\057\000\059\000\002\000\035\000\
\\090\000\008\000\088\000\033\000\
\\002\000\022\000\002\000\031\000\
\\020\000\073\000\039\000\033\000\
\\072\000\002\000\026\000\036\000\
\\024\000\071\000\068\000\015\000\
\\089\000\033\000\092\000\023\000\
\\016\000\050\000\084\000\000\000\
\\013\000\029\000\002\000\037\000\
\\096\000\083\000\082\000\095\000\
\\094\000\100\000\033\000\074\000\
\\091\000\001\000\027\000\086\000\
\\087\000\002\000\033\000\017\000\
\\081\000\102\000\101\000\011\000\
\\044\000\002\000\049\000\021\000\
\\001\000\009\000\002\000\045\000\
\\085\000\018\000\001\000\046\000\
\\040\000"
val gotoT =
"\
\\001\000\140\000\002\000\006\000\003\000\005\000\004\000\004\000\
\\007\000\003\000\008\000\002\000\011\000\001\000\000\000\
\\000\000\
\\007\000\024\000\011\000\001\000\000\000\
\\007\000\025\000\011\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\005\000\038\000\000\000\
\\000\000\
\\003\000\041\000\007\000\003\000\008\000\002\000\011\000\001\000\000\000\
\\003\000\042\000\007\000\003\000\008\000\002\000\011\000\001\000\000\000\
\\000\000\
\\003\000\048\000\006\000\047\000\007\000\003\000\008\000\002\000\
\\011\000\001\000\012\000\046\000\016\000\045\000\000\000\
\\002\000\055\000\003\000\005\000\004\000\004\000\007\000\003\000\
\\008\000\002\000\011\000\001\000\000\000\
\\003\000\056\000\007\000\003\000\008\000\002\000\011\000\001\000\000\000\
\\003\000\057\000\007\000\003\000\008\000\002\000\011\000\001\000\000\000\
\\003\000\058\000\007\000\003\000\008\000\002\000\011\000\001\000\000\000\
\\003\000\059\000\007\000\003\000\008\000\002\000\011\000\001\000\000\000\
\\003\000\060\000\007\000\003\000\008\000\002\000\011\000\001\000\000\000\
\\003\000\061\000\007\000\003\000\008\000\002\000\011\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\003\000\063\000\007\000\003\000\008\000\002\000\011\000\001\000\000\000\
\\003\000\064\000\007\000\003\000\008\000\002\000\011\000\001\000\000\000\
\\003\000\065\000\007\000\003\000\008\000\002\000\011\000\001\000\000\000\
\\003\000\066\000\007\000\003\000\008\000\002\000\011\000\001\000\000\000\
\\003\000\067\000\007\000\003\000\008\000\002\000\011\000\001\000\000\000\
\\003\000\068\000\007\000\003\000\008\000\002\000\011\000\001\000\000\000\
\\003\000\069\000\007\000\003\000\008\000\002\000\011\000\001\000\000\000\
\\003\000\070\000\007\000\003\000\008\000\002\000\011\000\001\000\000\000\
\\003\000\071\000\007\000\003\000\008\000\002\000\011\000\001\000\000\000\
\\003\000\072\000\007\000\003\000\008\000\002\000\011\000\001\000\000\000\
\\003\000\073\000\007\000\003\000\008\000\002\000\011\000\001\000\000\000\
\\000\000\
\\006\000\077\000\013\000\076\000\014\000\075\000\016\000\045\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\005\000\084\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\006\000\090\000\016\000\045\000\000\000\
\\000\000\
\\003\000\048\000\006\000\092\000\007\000\003\000\008\000\002\000\
\\011\000\001\000\012\000\046\000\015\000\091\000\016\000\045\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\003\000\095\000\007\000\003\000\008\000\002\000\011\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\006\000\099\000\015\000\091\000\016\000\045\000\000\000\
\\003\000\100\000\007\000\003\000\008\000\002\000\011\000\001\000\000\000\
\\009\000\101\000\000\000\
\\003\000\104\000\007\000\003\000\008\000\002\000\011\000\001\000\000\000\
\\005\000\105\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\006\000\108\000\016\000\045\000\000\000\
\\000\000\
\\003\000\110\000\007\000\003\000\008\000\002\000\011\000\001\000\
\\012\000\109\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\006\000\077\000\013\000\076\000\014\000\116\000\016\000\045\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\003\000\119\000\007\000\003\000\008\000\002\000\010\000\118\000\
\\011\000\001\000\000\000\
\\000\000\
\\000\000\
\\003\000\123\000\007\000\003\000\008\000\002\000\011\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\006\000\126\000\015\000\125\000\016\000\045\000\000\000\
\\000\000\
\\000\000\
\\002\000\128\000\003\000\127\000\004\000\004\000\007\000\003\000\
\\008\000\002\000\011\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\003\000\130\000\007\000\003\000\008\000\002\000\011\000\001\000\000\000\
\\006\000\131\000\016\000\045\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\003\000\133\000\007\000\003\000\008\000\002\000\011\000\001\000\000\000\
\\000\000\
\\000\000\
\\002\000\135\000\003\000\127\000\004\000\004\000\007\000\003\000\
\\008\000\002\000\011\000\001\000\000\000\
\\009\000\136\000\000\000\
\\003\000\137\000\007\000\003\000\008\000\002\000\011\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\002\000\139\000\003\000\127\000\004\000\004\000\007\000\003\000\
\\008\000\002\000\011\000\001\000\000\000\
\\000\000\
\\000\000\
\"
val numstates = 141
val numrules = 62
val s = ref "" and index = ref 0
val string_to_int = fn () => 
let val i = !index
in index := i+2; Char.ord(String.sub(!s,i)) + Char.ord(String.sub(!s,i+1)) * 256
end
val string_to_list = fn s' =>
    let val len = String.size s'
        fun f () =
           if !index < len then string_to_int() :: f()
           else nil
   in index := 0; s := s'; f ()
   end
val string_to_pairlist = fn (conv_key,conv_entry) =>
     let fun f () =
         case string_to_int()
         of 0 => EMPTY
          | n => PAIR(conv_key (n-1),conv_entry (string_to_int()),f())
     in f
     end
val string_to_pairlist_default = fn (conv_key,conv_entry) =>
    let val conv_row = string_to_pairlist(conv_key,conv_entry)
    in fn () =>
       let val default = conv_entry(string_to_int())
           val row = conv_row()
       in (row,default)
       end
   end
val string_to_table = fn (convert_row,s') =>
    let val len = String.size s'
        fun f ()=
           if !index < len then convert_row() :: f()
           else nil
     in (s := s'; index := 0; f ())
     end
local
  val memo = Array.array(numstates+numrules,ERROR)
  val _ =let fun g i=(Array.update(memo,i,REDUCE(i-numstates)); g(i+1))
       fun f i =
            if i=numstates then g i
            else (Array.update(memo,i,SHIFT (STATE i)); f (i+1))
          in f 0 handle General.Subscript => ()
          end
in
val entry_to_action = fn 0 => ACCEPT | 1 => ERROR | j => Array.sub(memo,(j-2))
end
val gotoT=Array.fromList(string_to_table(string_to_pairlist(NT,STATE),gotoT))
val actionRows=string_to_table(string_to_pairlist_default(T,entry_to_action),actionRows)
val actionRowNumbers = string_to_list actionRowNumbers
val actionT = let val actionRowLookUp=
let val a=Array.fromList(actionRows) in fn i=>Array.sub(a,i) end
in Array.fromList(List.map actionRowLookUp actionRowNumbers)
end
in LrTable.mkLrTable {actions=actionT,gotos=gotoT,numRules=numrules,
numStates=numstates,initialState=STATE 0}
end
end
local open Header in
type pos = int
type arg = unit
structure MlyValue = 
struct
datatype svalue = VOID | ntVOID of unit ->  unit
 | NAME of unit ->  (string) | NUM of unit ->  (int)
 | atomicType of unit ->  (plcType) | types of unit ->  (plcType list)
 | params of unit ->  ( ( plcType*string )  list)
 | typedVar of unit ->  (plcType*string)
 | comps of unit ->  (expr list) | const of unit ->  (expr)
 | condExpr of unit ->  (expr option)
 | matchExpr of unit ->  ( ( expr option * expr )  list)
 | appExpr of unit ->  (expr) | atomicExpr of unit ->  (expr)
 | TYPE of unit ->  (plcType)
 | args of unit ->  ( ( plcType*string )  list)
 | decl of unit ->  (expr) | EXPR of unit ->  (expr)
 | prog of unit ->  (expr) | PLC of unit ->  (expr)
end
type svalue = MlyValue.svalue
type result = expr
end
structure EC=
struct
open LrTable
infix 5 $$
fun x $$ y = y::x
val is_keyword =
fn (T 32) => true | (T 33) => true | (T 34) => true | (T 35) => true
 | (T 36) => true | (T 37) => true | (T 38) => true | (T 39) => true
 | (T 40) => true | (T 41) => true | (T 42) => true | (T 43) => true
 | (T 44) => true | (T 3) => true | (T 2) => true | (T 6) => true | 
(T 7) => true | (T 9) => true | (T 24) => true | (T 8) => true | _ => false
val preferred_change : (term list * term list) list = 
nil
val noShift = 
fn (T 45) => true | _ => false
val showTerminal =
fn (T 0) => "NUM"
  | (T 1) => "NAME"
  | (T 2) => "TRUE"
  | (T 3) => "FALSE"
  | (T 4) => "OPnot"
  | (T 5) => "OPminus"
  | (T 6) => "HD"
  | (T 7) => "TL"
  | (T 8) => "ISE"
  | (T 9) => "PRINT"
  | (T 10) => "OPdisjun"
  | (T 11) => "OPplus"
  | (T 12) => "OPtimes"
  | (T 13) => "OPdiv"
  | (T 14) => "OPequal"
  | (T 15) => "OPVbar"
  | (T 16) => "OPdiff"
  | (T 17) => "OPless"
  | (T 18) => "OPlessEq"
  | (T 19) => "OP2cons"
  | (T 20) => "OPsemicolon"
  | (T 21) => "OParrow"
  | (T 22) => "OP2arrow"
  | (T 23) => "OPcons"
  | (T 24) => "OPunder"
  | (T 25) => "OPcolon"
  | (T 26) => "Lbrace"
  | (T 27) => "Rbrace"
  | (T 28) => "Lpar"
  | (T 29) => "Rpar"
  | (T 30) => "Lbracket"
  | (T 31) => "Rbracket"
  | (T 32) => "FUN"
  | (T 33) => "REC"
  | (T 34) => "IF"
  | (T 35) => "THEN"
  | (T 36) => "ELSE"
  | (T 37) => "MATCH"
  | (T 38) => "WITH"
  | (T 39) => "VAR"
  | (T 40) => "FN"
  | (T 41) => "END"
  | (T 42) => "NIL"
  | (T 43) => "BOOL"
  | (T 44) => "INT"
  | (T 45) => "EOF"
  | _ => "bogus-term"
local open Header in
val errtermvalue=
fn _ => MlyValue.VOID
end
val terms : term list = nil
 $$ (T 45) $$ (T 44) $$ (T 43) $$ (T 42) $$ (T 41) $$ (T 40) $$ (T 39)
 $$ (T 38) $$ (T 37) $$ (T 36) $$ (T 35) $$ (T 34) $$ (T 33) $$ (T 32)
 $$ (T 31) $$ (T 30) $$ (T 29) $$ (T 28) $$ (T 27) $$ (T 26) $$ (T 25)
 $$ (T 24) $$ (T 23) $$ (T 22) $$ (T 21) $$ (T 20) $$ (T 19) $$ (T 18)
 $$ (T 17) $$ (T 16) $$ (T 15) $$ (T 14) $$ (T 13) $$ (T 12) $$ (T 11)
 $$ (T 10) $$ (T 9) $$ (T 8) $$ (T 7) $$ (T 6) $$ (T 5) $$ (T 4) $$ 
(T 3) $$ (T 2)end
structure Actions =
struct 
exception mlyAction of int
local open Header in
val actions = 
fn (i392,defaultPos,stack,
    (()):arg) =>
case (i392,stack)
of  ( 0, ( ( _, ( MlyValue.prog prog1, prog1left, prog1right)) :: 
rest671)) => let val  result = MlyValue.PLC (fn _ => let val  (prog
 as prog1) = prog1 ()
 in ( prog )
end)
 in ( LrTable.NT 0, ( result, prog1left, prog1right), rest671)
end
|  ( 1, ( ( _, ( MlyValue.EXPR EXPR1, EXPR1left, EXPR1right)) :: 
rest671)) => let val  result = MlyValue.prog (fn _ => let val  (EXPR
 as EXPR1) = EXPR1 ()
 in ( EXPR )
end)
 in ( LrTable.NT 1, ( result, EXPR1left, EXPR1right), rest671)
end
|  ( 2, ( ( _, ( MlyValue.decl decl1, decl1left, decl1right)) :: 
rest671)) => let val  result = MlyValue.prog (fn _ => let val  (decl
 as decl1) = decl1 ()
 in ( decl)
end)
 in ( LrTable.NT 1, ( result, decl1left, decl1right), rest671)
end
|  ( 3, ( ( _, ( MlyValue.prog prog1, _, prog1right)) :: _ :: ( _, ( 
MlyValue.EXPR EXPR1, _, _)) :: _ :: ( _, ( MlyValue.NAME NAME1, _, _))
 :: ( _, ( _, VAR1left, _)) :: rest671)) => let val  result = 
MlyValue.decl (fn _ => let val  (NAME as NAME1) = NAME1 ()
 val  (EXPR as EXPR1) = EXPR1 ()
 val  (prog as prog1) = prog1 ()
 in ( Let(NAME, EXPR, prog) )
end)
 in ( LrTable.NT 3, ( result, VAR1left, prog1right), rest671)
end
|  ( 4, ( ( _, ( MlyValue.prog prog1, _, prog1right)) :: _ :: ( _, ( 
MlyValue.EXPR EXPR1, _, _)) :: _ :: ( _, ( MlyValue.args args1, _, _))
 :: ( _, ( MlyValue.NAME NAME1, _, _)) :: ( _, ( _, FUN1left, _)) :: 
rest671)) => let val  result = MlyValue.decl (fn _ => let val  (NAME
 as NAME1) = NAME1 ()
 val  (args as args1) = args1 ()
 val  (EXPR as EXPR1) = EXPR1 ()
 val  (prog as prog1) = prog1 ()
 in ( Let(NAME, makeAnon(args, EXPR), prog) )
end)
 in ( LrTable.NT 3, ( result, FUN1left, prog1right), rest671)
end
|  ( 5, ( ( _, ( MlyValue.prog prog1, _, prog1right)) :: _ :: ( _, ( 
MlyValue.EXPR EXPR1, _, _)) :: _ :: ( _, ( MlyValue.TYPE TYPE1, _, _))
 :: _ :: ( _, ( MlyValue.args args1, _, _)) :: ( _, ( MlyValue.NAME 
NAME1, _, _)) :: _ :: ( _, ( _, FUN1left, _)) :: rest671)) => let val 
 result = MlyValue.decl (fn _ => let val  (NAME as NAME1) = NAME1 ()
 val  (args as args1) = args1 ()
 val  (TYPE as TYPE1) = TYPE1 ()
 val  (EXPR as EXPR1) = EXPR1 ()
 val  (prog as prog1) = prog1 ()
 in ( makeFun(NAME, args, TYPE, EXPR, prog) )
end)
 in ( LrTable.NT 3, ( result, FUN1left, prog1right), rest671)
end
|  ( 6, ( ( _, ( MlyValue.atomicExpr atomicExpr1, atomicExpr1left, 
atomicExpr1right)) :: rest671)) => let val  result = MlyValue.EXPR (fn
 _ => let val  (atomicExpr as atomicExpr1) = atomicExpr1 ()
 in ( atomicExpr )
end)
 in ( LrTable.NT 2, ( result, atomicExpr1left, atomicExpr1right), 
rest671)
end
|  ( 7, ( ( _, ( MlyValue.appExpr appExpr1, appExpr1left, 
appExpr1right)) :: rest671)) => let val  result = MlyValue.EXPR (fn _
 => let val  (appExpr as appExpr1) = appExpr1 ()
 in ( appExpr )
end)
 in ( LrTable.NT 2, ( result, appExpr1left, appExpr1right), rest671)

end
|  ( 8, ( ( _, ( MlyValue.EXPR EXPR3, _, EXPR3right)) :: _ :: ( _, ( 
MlyValue.EXPR EXPR2, _, _)) :: _ :: ( _, ( MlyValue.EXPR EXPR1, _, _))
 :: ( _, ( _, IF1left, _)) :: rest671)) => let val  result = 
MlyValue.EXPR (fn _ => let val  EXPR1 = EXPR1 ()
 val  EXPR2 = EXPR2 ()
 val  EXPR3 = EXPR3 ()
 in ( If(EXPR1, EXPR2, EXPR3) )
end)
 in ( LrTable.NT 2, ( result, IF1left, EXPR3right), rest671)
end
|  ( 9, ( ( _, ( MlyValue.matchExpr matchExpr1, _, matchExpr1right))
 :: _ :: ( _, ( MlyValue.EXPR EXPR1, _, _)) :: ( _, ( _, MATCH1left, _
)) :: rest671)) => let val  result = MlyValue.EXPR (fn _ => let val  (
EXPR as EXPR1) = EXPR1 ()
 val  (matchExpr as matchExpr1) = matchExpr1 ()
 in ( Match(EXPR, matchExpr) )
end)
 in ( LrTable.NT 2, ( result, MATCH1left, matchExpr1right), rest671)

end
|  ( 10, ( ( _, ( MlyValue.EXPR EXPR1, _, EXPR1right)) :: ( _, ( _, 
OPnot1left, _)) :: rest671)) => let val  result = MlyValue.EXPR (fn _
 => let val  (EXPR as EXPR1) = EXPR1 ()
 in ( Prim1("!", EXPR) )
end)
 in ( LrTable.NT 2, ( result, OPnot1left, EXPR1right), rest671)
end
|  ( 11, ( ( _, ( MlyValue.EXPR EXPR1, _, EXPR1right)) :: ( _, ( _, 
OPminus1left, _)) :: rest671)) => let val  result = MlyValue.EXPR (fn
 _ => let val  (EXPR as EXPR1) = EXPR1 ()
 in ( Prim1("-", EXPR) )
end)
 in ( LrTable.NT 2, ( result, OPminus1left, EXPR1right), rest671)
end
|  ( 12, ( ( _, ( MlyValue.EXPR EXPR1, _, EXPR1right)) :: ( _, ( _, 
HD1left, _)) :: rest671)) => let val  result = MlyValue.EXPR (fn _ =>
 let val  (EXPR as EXPR1) = EXPR1 ()
 in ( Prim1("hd", EXPR) )
end)
 in ( LrTable.NT 2, ( result, HD1left, EXPR1right), rest671)
end
|  ( 13, ( ( _, ( MlyValue.EXPR EXPR1, _, EXPR1right)) :: ( _, ( _, 
TL1left, _)) :: rest671)) => let val  result = MlyValue.EXPR (fn _ =>
 let val  (EXPR as EXPR1) = EXPR1 ()
 in ( Prim1("tl", EXPR) )
end)
 in ( LrTable.NT 2, ( result, TL1left, EXPR1right), rest671)
end
|  ( 14, ( ( _, ( MlyValue.EXPR EXPR1, _, EXPR1right)) :: ( _, ( _, 
ISE1left, _)) :: rest671)) => let val  result = MlyValue.EXPR (fn _ =>
 let val  (EXPR as EXPR1) = EXPR1 ()
 in ( Prim1("ise", EXPR) )
end)
 in ( LrTable.NT 2, ( result, ISE1left, EXPR1right), rest671)
end
|  ( 15, ( ( _, ( MlyValue.EXPR EXPR1, _, EXPR1right)) :: ( _, ( _, 
PRINT1left, _)) :: rest671)) => let val  result = MlyValue.EXPR (fn _
 => let val  (EXPR as EXPR1) = EXPR1 ()
 in ( Prim1("print", EXPR) )
end)
 in ( LrTable.NT 2, ( result, PRINT1left, EXPR1right), rest671)
end
|  ( 16, ( ( _, ( MlyValue.EXPR EXPR2, _, EXPR2right)) :: _ :: ( _, ( 
MlyValue.EXPR EXPR1, EXPR1left, _)) :: rest671)) => let val  result = 
MlyValue.EXPR (fn _ => let val  EXPR1 = EXPR1 ()
 val  EXPR2 = EXPR2 ()
 in ( Prim2("&&", EXPR1, EXPR2) )
end)
 in ( LrTable.NT 2, ( result, EXPR1left, EXPR2right), rest671)
end
|  ( 17, ( ( _, ( MlyValue.EXPR EXPR2, _, EXPR2right)) :: _ :: ( _, ( 
MlyValue.EXPR EXPR1, EXPR1left, _)) :: rest671)) => let val  result = 
MlyValue.EXPR (fn _ => let val  EXPR1 = EXPR1 ()
 val  EXPR2 = EXPR2 ()
 in ( Prim2("+", EXPR1 , EXPR2 ) )
end)
 in ( LrTable.NT 2, ( result, EXPR1left, EXPR2right), rest671)
end
|  ( 18, ( ( _, ( MlyValue.EXPR EXPR2, _, EXPR2right)) :: _ :: ( _, ( 
MlyValue.EXPR EXPR1, EXPR1left, _)) :: rest671)) => let val  result = 
MlyValue.EXPR (fn _ => let val  EXPR1 = EXPR1 ()
 val  EXPR2 = EXPR2 ()
 in ( Prim2("-", EXPR1 , EXPR2 ) )
end)
 in ( LrTable.NT 2, ( result, EXPR1left, EXPR2right), rest671)
end
|  ( 19, ( ( _, ( MlyValue.EXPR EXPR2, _, EXPR2right)) :: _ :: ( _, ( 
MlyValue.EXPR EXPR1, EXPR1left, _)) :: rest671)) => let val  result = 
MlyValue.EXPR (fn _ => let val  EXPR1 = EXPR1 ()
 val  EXPR2 = EXPR2 ()
 in ( Prim2("*", EXPR1 , EXPR2 ) )
end)
 in ( LrTable.NT 2, ( result, EXPR1left, EXPR2right), rest671)
end
|  ( 20, ( ( _, ( MlyValue.EXPR EXPR2, _, EXPR2right)) :: _ :: ( _, ( 
MlyValue.EXPR EXPR1, EXPR1left, _)) :: rest671)) => let val  result = 
MlyValue.EXPR (fn _ => let val  EXPR1 = EXPR1 ()
 val  EXPR2 = EXPR2 ()
 in ( Prim2("/", EXPR1 , EXPR2 ) )
end)
 in ( LrTable.NT 2, ( result, EXPR1left, EXPR2right), rest671)
end
|  ( 21, ( ( _, ( MlyValue.EXPR EXPR2, _, EXPR2right)) :: _ :: ( _, ( 
MlyValue.EXPR EXPR1, EXPR1left, _)) :: rest671)) => let val  result = 
MlyValue.EXPR (fn _ => let val  EXPR1 = EXPR1 ()
 val  EXPR2 = EXPR2 ()
 in ( Prim2("=", EXPR1 , EXPR2 ) )
end)
 in ( LrTable.NT 2, ( result, EXPR1left, EXPR2right), rest671)
end
|  ( 22, ( ( _, ( MlyValue.EXPR EXPR2, _, EXPR2right)) :: _ :: ( _, ( 
MlyValue.EXPR EXPR1, EXPR1left, _)) :: rest671)) => let val  result = 
MlyValue.EXPR (fn _ => let val  EXPR1 = EXPR1 ()
 val  EXPR2 = EXPR2 ()
 in ( Prim2("<>", EXPR1 , EXPR2 ) )
end)
 in ( LrTable.NT 2, ( result, EXPR1left, EXPR2right), rest671)
end
|  ( 23, ( ( _, ( MlyValue.EXPR EXPR2, _, EXPR2right)) :: _ :: ( _, ( 
MlyValue.EXPR EXPR1, EXPR1left, _)) :: rest671)) => let val  result = 
MlyValue.EXPR (fn _ => let val  EXPR1 = EXPR1 ()
 val  EXPR2 = EXPR2 ()
 in ( Prim2("<", EXPR1 , EXPR2 ) )
end)
 in ( LrTable.NT 2, ( result, EXPR1left, EXPR2right), rest671)
end
|  ( 24, ( ( _, ( MlyValue.EXPR EXPR2, _, EXPR2right)) :: _ :: ( _, ( 
MlyValue.EXPR EXPR1, EXPR1left, _)) :: rest671)) => let val  result = 
MlyValue.EXPR (fn _ => let val  EXPR1 = EXPR1 ()
 val  EXPR2 = EXPR2 ()
 in ( Prim2("<=", EXPR1 , EXPR2 ) )
end)
 in ( LrTable.NT 2, ( result, EXPR1left, EXPR2right), rest671)
end
|  ( 25, ( ( _, ( MlyValue.EXPR EXPR2, _, EXPR2right)) :: _ :: ( _, ( 
MlyValue.EXPR EXPR1, EXPR1left, _)) :: rest671)) => let val  result = 
MlyValue.EXPR (fn _ => let val  EXPR1 = EXPR1 ()
 val  EXPR2 = EXPR2 ()
 in ( Prim2("::", EXPR1 , EXPR2 ) )
end)
 in ( LrTable.NT 2, ( result, EXPR1left, EXPR2right), rest671)
end
|  ( 26, ( ( _, ( MlyValue.EXPR EXPR2, _, EXPR2right)) :: _ :: ( _, ( 
MlyValue.EXPR EXPR1, EXPR1left, _)) :: rest671)) => let val  result = 
MlyValue.EXPR (fn _ => let val  EXPR1 = EXPR1 ()
 val  EXPR2 = EXPR2 ()
 in ( Prim2(";", EXPR1 , EXPR2 ) )
end)
 in ( LrTable.NT 2, ( result, EXPR1left, EXPR2right), rest671)
end
|  ( 27, ( ( _, ( _, _, Rbracket1right)) :: ( _, ( MlyValue.NUM NUM1,
 _, _)) :: _ :: ( _, ( MlyValue.EXPR EXPR1, EXPR1left, _)) :: rest671)
) => let val  result = MlyValue.EXPR (fn _ => let val  (EXPR as EXPR1)
 = EXPR1 ()
 val  (NUM as NUM1) = NUM1 ()
 in ( Item (NUM, EXPR) )
end)
 in ( LrTable.NT 2, ( result, EXPR1left, Rbracket1right), rest671)
end
|  ( 28, ( ( _, ( MlyValue.const const1, const1left, const1right)) :: 
rest671)) => let val  result = MlyValue.atomicExpr (fn _ => let val  (
const as const1) = const1 ()
 in ( const )
end)
 in ( LrTable.NT 6, ( result, const1left, const1right), rest671)
end
|  ( 29, ( ( _, ( MlyValue.NAME NAME1, NAME1left, NAME1right)) :: 
rest671)) => let val  result = MlyValue.atomicExpr (fn _ => let val  (
NAME as NAME1) = NAME1 ()
 in ( Var NAME )
end)
 in ( LrTable.NT 6, ( result, NAME1left, NAME1right), rest671)
end
|  ( 30, ( ( _, ( _, _, Rbrace1right)) :: ( _, ( MlyValue.prog prog1,
 _, _)) :: ( _, ( _, Lbrace1left, _)) :: rest671)) => let val  result
 = MlyValue.atomicExpr (fn _ => let val  (prog as prog1) = prog1 ()
 in ( prog )
end)
 in ( LrTable.NT 6, ( result, Lbrace1left, Rbrace1right), rest671)
end
|  ( 31, ( ( _, ( _, _, Rpar1right)) :: ( _, ( MlyValue.EXPR EXPR1, _,
 _)) :: ( _, ( _, Lpar1left, _)) :: rest671)) => let val  result = 
MlyValue.atomicExpr (fn _ => let val  (EXPR as EXPR1) = EXPR1 ()
 in ( EXPR )
end)
 in ( LrTable.NT 6, ( result, Lpar1left, Rpar1right), rest671)
end
|  ( 32, ( ( _, ( _, _, Rpar1right)) :: ( _, ( MlyValue.comps comps1,
 _, _)) :: ( _, ( _, Lpar1left, _)) :: rest671)) => let val  result = 
MlyValue.atomicExpr (fn _ => let val  (comps as comps1) = comps1 ()
 in ( List comps )
end)
 in ( LrTable.NT 6, ( result, Lpar1left, Rpar1right), rest671)
end
|  ( 33, ( ( _, ( _, _, END1right)) :: ( _, ( MlyValue.EXPR EXPR1, _,
 _)) :: _ :: ( _, ( MlyValue.args args1, _, _)) :: ( _, ( _, FN1left,
 _)) :: rest671)) => let val  result = MlyValue.atomicExpr (fn _ =>
 let val  (args as args1) = args1 ()
 val  (EXPR as EXPR1) = EXPR1 ()
 in ( makeAnon(args, EXPR) )
end)
 in ( LrTable.NT 6, ( result, FN1left, END1right), rest671)
end
|  ( 34, ( ( _, ( MlyValue.atomicExpr atomicExpr2, _, atomicExpr2right
)) :: ( _, ( MlyValue.atomicExpr atomicExpr1, atomicExpr1left, _)) :: 
rest671)) => let val  result = MlyValue.appExpr (fn _ => let val  
atomicExpr1 = atomicExpr1 ()
 val  atomicExpr2 = atomicExpr2 ()
 in ( Call( atomicExpr1, atomicExpr2) )
end)
 in ( LrTable.NT 7, ( result, atomicExpr1left, atomicExpr2right), 
rest671)
end
|  ( 35, ( ( _, ( MlyValue.atomicExpr atomicExpr1, _, atomicExpr1right
)) :: ( _, ( MlyValue.appExpr appExpr1, appExpr1left, _)) :: rest671))
 => let val  result = MlyValue.appExpr (fn _ => let val  (appExpr as 
appExpr1) = appExpr1 ()
 val  (atomicExpr as atomicExpr1) = atomicExpr1 ()
 in ( Call( appExpr, atomicExpr) )
end)
 in ( LrTable.NT 7, ( result, appExpr1left, atomicExpr1right), rest671
)
end
|  ( 36, ( ( _, ( _, TRUE1left, TRUE1right)) :: rest671)) => let val  
result = MlyValue.const (fn _ => ( ConB true ))
 in ( LrTable.NT 10, ( result, TRUE1left, TRUE1right), rest671)
end
|  ( 37, ( ( _, ( _, FALSE1left, FALSE1right)) :: rest671)) => let
 val  result = MlyValue.const (fn _ => ( ConB false))
 in ( LrTable.NT 10, ( result, FALSE1left, FALSE1right), rest671)
end
|  ( 38, ( ( _, ( MlyValue.NUM NUM1, NUM1left, NUM1right)) :: rest671)
) => let val  result = MlyValue.const (fn _ => let val  (NUM as NUM1)
 = NUM1 ()
 in ( ConI NUM )
end)
 in ( LrTable.NT 10, ( result, NUM1left, NUM1right), rest671)
end
|  ( 39, ( ( _, ( _, _, Rpar1right)) :: ( _, ( _, Lpar1left, _)) :: 
rest671)) => let val  result = MlyValue.const (fn _ => ( List [] ))
 in ( LrTable.NT 10, ( result, Lpar1left, Rpar1right), rest671)
end
|  ( 40, ( ( _, ( _, _, Rpar1right)) :: _ :: _ :: ( _, ( MlyValue.TYPE
 TYPE1, _, _)) :: ( _, ( _, Lpar1left, _)) :: rest671)) => let val  
result = MlyValue.const (fn _ => let val  (TYPE as TYPE1) = TYPE1 ()
 in ( ESeq (TYPE) )
end)
 in ( LrTable.NT 10, ( result, Lpar1left, Rpar1right), rest671)
end
|  ( 41, ( ( _, ( MlyValue.EXPR EXPR2, _, EXPR2right)) :: _ :: ( _, ( 
MlyValue.EXPR EXPR1, EXPR1left, _)) :: rest671)) => let val  result = 
MlyValue.comps (fn _ => let val  EXPR1 = EXPR1 ()
 val  EXPR2 = EXPR2 ()
 in ( (EXPR1)::(EXPR2)::[])
end)
 in ( LrTable.NT 11, ( result, EXPR1left, EXPR2right), rest671)
end
|  ( 42, ( ( _, ( MlyValue.comps comps1, _, comps1right)) :: _ :: ( _,
 ( MlyValue.EXPR EXPR1, EXPR1left, _)) :: rest671)) => let val  result
 = MlyValue.comps (fn _ => let val  (EXPR as EXPR1) = EXPR1 ()
 val  (comps as comps1) = comps1 ()
 in ( (EXPR)::comps )
end)
 in ( LrTable.NT 11, ( result, EXPR1left, comps1right), rest671)
end
|  ( 43, ( ( _, ( _, END1left, END1right)) :: rest671)) => let val  
result = MlyValue.matchExpr (fn _ => ( [ ] ))
 in ( LrTable.NT 8, ( result, END1left, END1right), rest671)
end
|  ( 44, ( ( _, ( MlyValue.matchExpr matchExpr1, _, matchExpr1right))
 :: ( _, ( MlyValue.EXPR EXPR1, _, _)) :: _ :: ( _, ( 
MlyValue.condExpr condExpr1, _, _)) :: ( _, ( _, OPVbar1left, _)) :: 
rest671)) => let val  result = MlyValue.matchExpr (fn _ => let val  (
condExpr as condExpr1) = condExpr1 ()
 val  (EXPR as EXPR1) = EXPR1 ()
 val  (matchExpr as matchExpr1) = matchExpr1 ()
 in ( (condExpr, EXPR)::matchExpr )
end)
 in ( LrTable.NT 8, ( result, OPVbar1left, matchExpr1right), rest671)

end
|  ( 45, ( ( _, ( MlyValue.EXPR EXPR1, EXPR1left, EXPR1right)) :: 
rest671)) => let val  result = MlyValue.condExpr (fn _ => let val  (
EXPR as EXPR1) = EXPR1 ()
 in ( SOME (EXPR) )
end)
 in ( LrTable.NT 9, ( result, EXPR1left, EXPR1right), rest671)
end
|  ( 46, ( ( _, ( _, OPunder1left, OPunder1right)) :: rest671)) => let
 val  result = MlyValue.condExpr (fn _ => ( NONE ))
 in ( LrTable.NT 9, ( result, OPunder1left, OPunder1right), rest671)

end
|  ( 47, ( ( _, ( _, _, Rpar1right)) :: ( _, ( _, Lpar1left, _)) :: 
rest671)) => let val  result = MlyValue.args (fn _ => ( [] ))
 in ( LrTable.NT 4, ( result, Lpar1left, Rpar1right), rest671)
end
|  ( 48, ( ( _, ( _, _, Rpar1right)) :: ( _, ( MlyValue.params params1
, _, _)) :: ( _, ( _, Lpar1left, _)) :: rest671)) => let val  result =
 MlyValue.args (fn _ => let val  (params as params1) = params1 ()
 in ( params )
end)
 in ( LrTable.NT 4, ( result, Lpar1left, Rpar1right), rest671)
end
|  ( 49, ( ( _, ( MlyValue.typedVar typedVar1, typedVar1left, 
typedVar1right)) :: rest671)) => let val  result = MlyValue.params (fn
 _ => let val  (typedVar as typedVar1) = typedVar1 ()
 in ( (typedVar)::[] )
end)
 in ( LrTable.NT 13, ( result, typedVar1left, typedVar1right), rest671
)
end
|  ( 50, ( ( _, ( MlyValue.params params1, _, params1right)) :: _ :: (
 _, ( MlyValue.typedVar typedVar1, typedVar1left, _)) :: rest671)) =>
 let val  result = MlyValue.params (fn _ => let val  (typedVar as 
typedVar1) = typedVar1 ()
 val  (params as params1) = params1 ()
 in ( (typedVar)::(params) )
end)
 in ( LrTable.NT 13, ( result, typedVar1left, params1right), rest671)

end
|  ( 51, ( ( _, ( MlyValue.NAME NAME1, _, NAME1right)) :: ( _, ( 
MlyValue.TYPE TYPE1, TYPE1left, _)) :: rest671)) => let val  result = 
MlyValue.typedVar (fn _ => let val  (TYPE as TYPE1) = TYPE1 ()
 val  (NAME as NAME1) = NAME1 ()
 in ( (TYPE, NAME))
end)
 in ( LrTable.NT 12, ( result, TYPE1left, NAME1right), rest671)
end
|  ( 52, ( ( _, ( MlyValue.atomicType atomicType1, atomicType1left, 
atomicType1right)) :: rest671)) => let val  result = MlyValue.TYPE (fn
 _ => let val  (atomicType as atomicType1) = atomicType1 ()
 in ( atomicType )
end)
 in ( LrTable.NT 5, ( result, atomicType1left, atomicType1right), 
rest671)
end
|  ( 53, ( ( _, ( _, _, Rpar1right)) :: ( _, ( MlyValue.types types1,
 _, _)) :: ( _, ( _, Lpar1left, _)) :: rest671)) => let val  result = 
MlyValue.TYPE (fn _ => let val  (types as types1) = types1 ()
 in ( ListT types)
end)
 in ( LrTable.NT 5, ( result, Lpar1left, Rpar1right), rest671)
end
|  ( 54, ( ( _, ( _, _, Rbracket1right)) :: ( _, ( MlyValue.TYPE TYPE1
, _, _)) :: ( _, ( _, Lbracket1left, _)) :: rest671)) => let val  
result = MlyValue.TYPE (fn _ => let val  (TYPE as TYPE1) = TYPE1 ()
 in ( SeqT TYPE )
end)
 in ( LrTable.NT 5, ( result, Lbracket1left, Rbracket1right), rest671)

end
|  ( 55, ( ( _, ( MlyValue.TYPE TYPE2, _, TYPE2right)) :: _ :: ( _, ( 
MlyValue.TYPE TYPE1, TYPE1left, _)) :: rest671)) => let val  result = 
MlyValue.TYPE (fn _ => let val  TYPE1 = TYPE1 ()
 val  TYPE2 = TYPE2 ()
 in ( FunT (TYPE1, TYPE2) )
end)
 in ( LrTable.NT 5, ( result, TYPE1left, TYPE2right), rest671)
end
|  ( 56, ( ( _, ( _, NIL1left, NIL1right)) :: rest671)) => let val  
result = MlyValue.atomicType (fn _ => ( ListT [] ))
 in ( LrTable.NT 15, ( result, NIL1left, NIL1right), rest671)
end
|  ( 57, ( ( _, ( _, BOOL1left, BOOL1right)) :: rest671)) => let val  
result = MlyValue.atomicType (fn _ => ( BoolT ))
 in ( LrTable.NT 15, ( result, BOOL1left, BOOL1right), rest671)
end
|  ( 58, ( ( _, ( _, INT1left, INT1right)) :: rest671)) => let val  
result = MlyValue.atomicType (fn _ => ( IntT ))
 in ( LrTable.NT 15, ( result, INT1left, INT1right), rest671)
end
|  ( 59, ( ( _, ( _, _, Rpar1right)) :: ( _, ( MlyValue.TYPE TYPE1, _,
 _)) :: ( _, ( _, Lpar1left, _)) :: rest671)) => let val  result = 
MlyValue.atomicType (fn _ => let val  (TYPE as TYPE1) = TYPE1 ()
 in ( TYPE )
end)
 in ( LrTable.NT 15, ( result, Lpar1left, Rpar1right), rest671)
end
|  ( 60, ( ( _, ( MlyValue.TYPE TYPE2, _, TYPE2right)) :: _ :: ( _, ( 
MlyValue.TYPE TYPE1, TYPE1left, _)) :: rest671)) => let val  result = 
MlyValue.types (fn _ => let val  TYPE1 = TYPE1 ()
 val  TYPE2 = TYPE2 ()
 in ( (TYPE1)::(TYPE2)::[])
end)
 in ( LrTable.NT 14, ( result, TYPE1left, TYPE2right), rest671)
end
|  ( 61, ( ( _, ( MlyValue.types types1, _, types1right)) :: _ :: ( _,
 ( MlyValue.TYPE TYPE1, TYPE1left, _)) :: rest671)) => let val  result
 = MlyValue.types (fn _ => let val  (TYPE as TYPE1) = TYPE1 ()
 val  (types as types1) = types1 ()
 in ( (TYPE)::(types))
end)
 in ( LrTable.NT 14, ( result, TYPE1left, types1right), rest671)
end
| _ => raise (mlyAction i392)
end
val void = MlyValue.VOID
val extract = fn a => (fn MlyValue.PLC x => x
| _ => let exception ParseInternal
	in raise ParseInternal end) a ()
end
end
structure Tokens : PlcParser_TOKENS =
struct
type svalue = ParserData.svalue
type ('a,'b) token = ('a,'b) Token.token
fun NUM (i,p1,p2) = Token.TOKEN (ParserData.LrTable.T 0,(
ParserData.MlyValue.NUM (fn () => i),p1,p2))
fun NAME (i,p1,p2) = Token.TOKEN (ParserData.LrTable.T 1,(
ParserData.MlyValue.NAME (fn () => i),p1,p2))
fun TRUE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 2,(
ParserData.MlyValue.VOID,p1,p2))
fun FALSE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 3,(
ParserData.MlyValue.VOID,p1,p2))
fun OPnot (p1,p2) = Token.TOKEN (ParserData.LrTable.T 4,(
ParserData.MlyValue.VOID,p1,p2))
fun OPminus (p1,p2) = Token.TOKEN (ParserData.LrTable.T 5,(
ParserData.MlyValue.VOID,p1,p2))
fun HD (p1,p2) = Token.TOKEN (ParserData.LrTable.T 6,(
ParserData.MlyValue.VOID,p1,p2))
fun TL (p1,p2) = Token.TOKEN (ParserData.LrTable.T 7,(
ParserData.MlyValue.VOID,p1,p2))
fun ISE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 8,(
ParserData.MlyValue.VOID,p1,p2))
fun PRINT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 9,(
ParserData.MlyValue.VOID,p1,p2))
fun OPdisjun (p1,p2) = Token.TOKEN (ParserData.LrTable.T 10,(
ParserData.MlyValue.VOID,p1,p2))
fun OPplus (p1,p2) = Token.TOKEN (ParserData.LrTable.T 11,(
ParserData.MlyValue.VOID,p1,p2))
fun OPtimes (p1,p2) = Token.TOKEN (ParserData.LrTable.T 12,(
ParserData.MlyValue.VOID,p1,p2))
fun OPdiv (p1,p2) = Token.TOKEN (ParserData.LrTable.T 13,(
ParserData.MlyValue.VOID,p1,p2))
fun OPequal (p1,p2) = Token.TOKEN (ParserData.LrTable.T 14,(
ParserData.MlyValue.VOID,p1,p2))
fun OPVbar (p1,p2) = Token.TOKEN (ParserData.LrTable.T 15,(
ParserData.MlyValue.VOID,p1,p2))
fun OPdiff (p1,p2) = Token.TOKEN (ParserData.LrTable.T 16,(
ParserData.MlyValue.VOID,p1,p2))
fun OPless (p1,p2) = Token.TOKEN (ParserData.LrTable.T 17,(
ParserData.MlyValue.VOID,p1,p2))
fun OPlessEq (p1,p2) = Token.TOKEN (ParserData.LrTable.T 18,(
ParserData.MlyValue.VOID,p1,p2))
fun OP2cons (p1,p2) = Token.TOKEN (ParserData.LrTable.T 19,(
ParserData.MlyValue.VOID,p1,p2))
fun OPsemicolon (p1,p2) = Token.TOKEN (ParserData.LrTable.T 20,(
ParserData.MlyValue.VOID,p1,p2))
fun OParrow (p1,p2) = Token.TOKEN (ParserData.LrTable.T 21,(
ParserData.MlyValue.VOID,p1,p2))
fun OP2arrow (p1,p2) = Token.TOKEN (ParserData.LrTable.T 22,(
ParserData.MlyValue.VOID,p1,p2))
fun OPcons (p1,p2) = Token.TOKEN (ParserData.LrTable.T 23,(
ParserData.MlyValue.VOID,p1,p2))
fun OPunder (p1,p2) = Token.TOKEN (ParserData.LrTable.T 24,(
ParserData.MlyValue.VOID,p1,p2))
fun OPcolon (p1,p2) = Token.TOKEN (ParserData.LrTable.T 25,(
ParserData.MlyValue.VOID,p1,p2))
fun Lbrace (p1,p2) = Token.TOKEN (ParserData.LrTable.T 26,(
ParserData.MlyValue.VOID,p1,p2))
fun Rbrace (p1,p2) = Token.TOKEN (ParserData.LrTable.T 27,(
ParserData.MlyValue.VOID,p1,p2))
fun Lpar (p1,p2) = Token.TOKEN (ParserData.LrTable.T 28,(
ParserData.MlyValue.VOID,p1,p2))
fun Rpar (p1,p2) = Token.TOKEN (ParserData.LrTable.T 29,(
ParserData.MlyValue.VOID,p1,p2))
fun Lbracket (p1,p2) = Token.TOKEN (ParserData.LrTable.T 30,(
ParserData.MlyValue.VOID,p1,p2))
fun Rbracket (p1,p2) = Token.TOKEN (ParserData.LrTable.T 31,(
ParserData.MlyValue.VOID,p1,p2))
fun FUN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 32,(
ParserData.MlyValue.VOID,p1,p2))
fun REC (p1,p2) = Token.TOKEN (ParserData.LrTable.T 33,(
ParserData.MlyValue.VOID,p1,p2))
fun IF (p1,p2) = Token.TOKEN (ParserData.LrTable.T 34,(
ParserData.MlyValue.VOID,p1,p2))
fun THEN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 35,(
ParserData.MlyValue.VOID,p1,p2))
fun ELSE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 36,(
ParserData.MlyValue.VOID,p1,p2))
fun MATCH (p1,p2) = Token.TOKEN (ParserData.LrTable.T 37,(
ParserData.MlyValue.VOID,p1,p2))
fun WITH (p1,p2) = Token.TOKEN (ParserData.LrTable.T 38,(
ParserData.MlyValue.VOID,p1,p2))
fun VAR (p1,p2) = Token.TOKEN (ParserData.LrTable.T 39,(
ParserData.MlyValue.VOID,p1,p2))
fun FN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 40,(
ParserData.MlyValue.VOID,p1,p2))
fun END (p1,p2) = Token.TOKEN (ParserData.LrTable.T 41,(
ParserData.MlyValue.VOID,p1,p2))
fun NIL (p1,p2) = Token.TOKEN (ParserData.LrTable.T 42,(
ParserData.MlyValue.VOID,p1,p2))
fun BOOL (p1,p2) = Token.TOKEN (ParserData.LrTable.T 43,(
ParserData.MlyValue.VOID,p1,p2))
fun INT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 44,(
ParserData.MlyValue.VOID,p1,p2))
fun EOF (p1,p2) = Token.TOKEN (ParserData.LrTable.T 45,(
ParserData.MlyValue.VOID,p1,p2))
end
end
