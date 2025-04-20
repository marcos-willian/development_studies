(* PlcInterp *)


exception Impossible
exception HDEmptySeq
exception TLEmptySeq
exception ValueNotFoundInMatch
exception NotAFunc
exception DefaultMatchException

fun eval (expr:expr) (env:plcVal env) : plcVal =
    let
        fun resMatch(cond, ((match, res)::[])) =  
            (case match of 
                NONE => eval res env
            |   SOME exp => if (eval exp env) = cond then 
                                eval res env
                            else 
                                raise ValueNotFoundInMatch)
        | resMatch(cond, (SOME(exp), res)::t) = 
            if (eval exp env) = cond then 
                eval res env
            else 
                resMatch(cond, t)
        | resMatch(cond, (NONE, res)::_) = raise DefaultMatchException

        fun makeValList ([]) = []
          | makeValList (hd::tl) = (eval hd env)::makeValList(tl)

        fun valueIndex (1, (hd::tl)) =  hd
          | valueIndex (i, (_::tl)) = valueIndex(i - 1, tl)
    in                
        case expr of
            ConI(n) => IntV(n)
        |   ConB(b) => BoolV(b)
        |   ESeq(t) => SeqV []
        |   Var(x) => lookup env x
        |   Let(var, initExp, prog) => 
            let
                val init = eval initExp env
            in
                case init of 
                    Clos(_, parN, body, env) =>
                    let
                        val nClos = Clos(var, parN, body, env)
                    in
                        eval prog ((var, nClos)::env)
                    end
                |   _ => eval prog ((var,init)::env)
            end
        |   Letrec(funName,parT,par,retT,body,prog) => 
            let 
                val closure = Clos(funName, par, body, env)
            in
                eval prog ((funName,closure)::env)
            end 
        |   Prim1(opr,exp) =>
            let
                val v = eval exp env
            in
                case (opr, v) of
                ("!", BoolV(b)) => BoolV(not b)
            |   ("-", IntV(i))  => IntV(~i)
            |   ("hd", SeqV([]))=> raise HDEmptySeq
            |   ("hd", SeqV(s)) => hd s
            |   ("tl", SeqV([])) => raise TLEmptySeq
            |   ("tl", SeqV(s))  => SeqV(tl s)
            |   ("ise", SeqV([]))=> BoolV(true)
            |   ("ise", SeqV(s))=> BoolV(false) 
            |   ("print", _) => 
                    (print((val2string v)^"\n"); ListV([]))
            |   _   => raise Impossible
            end
        |   Prim2(opr, exp1, exp2) =>
            let
                val v1 = eval exp1 env
                val v2 = eval exp2 env
            in 
                case (opr, v1, v2) of
                ("&&", BoolV(b1), BoolV(b2)) => BoolV(b1 andalso b2)
            |   ("+", IntV(i1), IntV(i2)) => IntV(i1 + i2)
            |   ("-", IntV(i1), IntV(i2)) => IntV(i1 - i2)
            |   ("*", IntV(i1), IntV(i2)) => IntV(i1 * i2)
            |   ("/", _, IntV(0)) => raise Impossible
            |   ("/", IntV(i1), IntV(i2)) => IntV(i1 div i2)
            |   ("<", IntV(i1), IntV(i2)) => BoolV(i1 < i2)
            |   ("<=", IntV(i1), IntV(i2)) => BoolV(i1 <= i2)
            |   ("=", e1, e2) => BoolV(e1 = e2)
            |   ("<>", e1, e2) => BoolV(e1 <> e2)
            |   ("::", e1, SeqV(s1)) => SeqV(e1::s1)
            |   (";", _, _) => v2
            |   _   => raise Impossible
            end
        |   If(bExp, tExp, eExp) => 
            let
                val condV = eval bExp env
            in 
                case condV of 
                    BoolV(true) => eval tExp env
                |   BoolV(false) => eval eExp env
                |   _ => raise Impossible
            end
        |   Match(matchCond, matchList) => 
            let
                val cond =  eval matchCond env
            in
                resMatch(cond, matchList)
            end
        |   Call(funExp, param) => 
            let
                val closure = eval funExp env
                val parValue = eval param env
            in
                case closure of 
                (Clos(fName, parN, body, envDc)) =>
                    (eval body ((parN, parValue)::(fName, closure)::envDc)) 
                |   _ => raise NotAFunc
            end
        |   List(exprList) => ListV(makeValList(exprList)) 
        |   Item(i, expList) => (
                case (eval expList env) of
                    ListV(list) => valueIndex(i, list)
                |   _ => raise Impossible)
        |   Anon(typePar, namePar, exp) => Clos("", namePar, exp, env)
    end;
