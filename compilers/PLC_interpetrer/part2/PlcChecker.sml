(* PlcChecker *)

exception EmptySeq
exception UnknownType
exception NotEqTypes
exception WrongRetType
exception DiffBrTypes
exception IfCondNotBool
exception NoMatchResults
exception MatchResTypeDiff
exception MatchCondTypesDiff
exception CallTypeMisM
exception NotFunc
exception ListOutOfRange
exception OpNonList


fun teval (expr:expr) (env:plcType env):plcType = 
    let
        fun IsFunT [] = false
          | IsFunT (Thd::Ttl:plcType list) = case Thd of 
                                                FunT(t1, t2) => true 
                                             |  _ => IsFunT(Ttl)
        
        fun eqT(exp1, exp2) = 
            let
                val t1 = (teval exp1 env)
                val t2 = (teval exp2 env)
            in
                if t1 = t2 then
                    case t1 of
                        FunT(t1, t2) => raise CallTypeMisM
                    |   SeqT(t)=> (case t of 
                                        FunT(t1, t2) => raise CallTypeMisM 
                                   |    _ => BoolT )
                    |   ListT(list)=> if IsFunT(list) then raise CallTypeMisM  else BoolT
                    |   _    => BoolT
                else
                    raise NotEqTypes
            end
        fun matchTypeIsCorrec(_, []) = raise NoMatchResults
          | matchTypeIsCorrec(cond, (match, _)::[]) = (case match of
                                                NONE => true
                                              | SOME e => (teval e env) = (teval cond env))
          | matchTypeIsCorrec(cond, (e1, r1)::(e2, r2)::t) =
                case e1 of
                    NONE => if (teval r1 env) = (teval r2 env) then 
                                matchTypeIsCorrec(cond, (e2, r2)::t)
                            else 
                                raise MatchResTypeDiff
                |   SOME exp1 => case e2 of
                                    NONE => if (teval exp1 env) = (teval cond env) then
                                                if (teval r1 env) = (teval r2 env) then 
                                                    matchTypeIsCorrec(cond, (e2, r2)::t)
                                                else 
                                                    raise MatchResTypeDiff
                                            else
                                                raise MatchCondTypesDiff
                                 |  SOME exp2 => 
                                        if (teval exp1 env) = (teval exp2 env) then
                                            if (teval exp2 env) = (teval cond env) then 
                                                if (teval r1 env) = (teval r2 env) then 
                                                    matchTypeIsCorrec(cond, (e2, r2)::t)
                                                else 
                                                    raise MatchResTypeDiff
                                            else
                                                raise MatchCondTypesDiff
                                        else
                                            raise MatchCondTypesDiff
        fun makeTypeList ([]) = []
          | makeTypeList (hd::tl) = (teval hd env)::makeTypeList(tl)

        fun typeIndex (i, []) = raise ListOutOfRange
          | typeIndex (1, (hd::tl)) =  hd
          | typeIndex (i, (_::tl)) = typeIndex(i - 1, tl)

        fun prim2Type (exp1, exp2, t1, t2) = if ((teval exp1 env) = (teval exp2 env)) then
                                                    if ((teval exp1 env)) = t1 then
                                                        t2
                                                    else
                                                        raise CallTypeMisM
                                            else
                                                    raise NotEqTypes
    in 
        case expr of
            ConI(n) => IntT 
        |   ConB(b) => BoolT 
        |   ESeq(t) => (case t of 
                            SeqT(_) => t 
                       |    _ => raise EmptySeq) (*Caso não seja SeqT(t), deve ser disparado EmptySeq*)
        |   Var(x) => lookup env x
        |   Let(var, init, prog) => teval prog (((var,(teval init env)))::env) 
        |   Letrec(funName, parT, par,  retT, body, prog) => 
            let 
                val envN = (par, parT)::env
                val envNew = (funName,FunT(parT, retT))::envN
                val t1 = teval body envNew
            in
                if (t1 = retT) then 
                    teval prog ((funName,FunT(parT, retT))::env)
                else
                    raise WrongRetType
            end 
        |   Prim1(opr, exp) => 
            (case opr of
                "!" => if (teval exp env) = BoolT then 
                            BoolT 
                       else 
                            raise CallTypeMisM
            |   "-" => if (teval exp env) = IntT then 
                            IntT 
                       else 
                            raise CallTypeMisM
            |   "hd"=> (case (teval exp env) of (*Duvida ainda  quando usar empty seq*)
                            SeqT(t) => t 
                       |    _   => raise CallTypeMisM)
            |   "tl"=> (case (teval exp env) of 
                            SeqT(t) => (teval exp env)
                       |    _   => raise CallTypeMisM)
            |   "ise"=> (case (teval exp env) of 
                            SeqT(t) => BoolT
                       |    _   => raise CallTypeMisM)
            |   "print"=> ListT []
            |   _   => raise UnknownType)
        |   Prim2(opr, exp1, exp2) =>
            (case opr of
                "&&"=> prim2Type(exp1, exp2, BoolT, BoolT)
            |   "+" => prim2Type(exp1, exp2, IntT, IntT)
            |   "-" => prim2Type(exp1, exp2, IntT, IntT)
            |   "*" => prim2Type(exp1, exp2, IntT, IntT)
            |   "/" => prim2Type(exp1, exp2, IntT, IntT)
            |   "<" => prim2Type(exp1, exp2, IntT, BoolT)
            |   "<=" => prim2Type(exp1, exp2, IntT, BoolT)
            |   "=" => eqT(exp1, exp2)
            |   "<>"=> eqT(exp1, exp2)
            |   "::"=> let
                            val t1 = (teval exp1 env) 
                            val t2 = (teval exp2 env)
                       in  
                            case t2 of 
                                SeqT(t)=> if t = t1 then t2 else raise CallTypeMisM
                            |   _   => raise CallTypeMisM
                       end
            |   ";" => (teval exp2 env)
            |   _   => raise UnknownType)
        |   If(bExp, tExp, eExp) => 
                if (teval bExp env) = BoolT then 
                    if (teval tExp env) = (teval eExp env) then 
                        (teval tExp env) 
                    else 
                        raise DiffBrTypes
                else 
                    raise IfCondNotBool 
        |   Match(matchCond, matchList) => 
                if matchTypeIsCorrec(matchCond, matchList) then 
                    (teval (#2(hd(matchList))) env) 
                else 
                    raise MatchCondTypesDiff 
        |   Call(funEXP, param) => (
                case (teval funEXP env) of
                    FunT(pT, rT) => if (teval param env) = pT then
                                        rT 
                                    else
                                        raise CallTypeMisM
                |   _   => raise NotFunc )

        |   List(exprList) => ListT(makeTypeList(exprList)) 
        |   Item(i, expList) => (
                case (teval expList env) of
                    ListT(list) => typeIndex(i, list)
                |   _ => raise OpNonList)
        |   Anon(typePar, namePar, exp) => FunT(typePar, (teval exp ((namePar,typePar)::env)))
    end;

