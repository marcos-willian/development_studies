

fun run (expr: expr) :string = 
    let
      val t = teval expr []
      
      val v = eval expr []
    in
      val2string(v) ^" : "^ type2string(t)
    end
    handle SymbolNotFound msg => "Symbol '"^msg^"' not found."
         | EmptySeq => "Plc Checker: empty sequence type."
         | UnknownType => "Plc Checker: Type expr unknown."
         | NotEqTypes => "Plc Checker: Types in comparison are different."
         | WrongRetType => "Plc Checker: Wrong return type in function."
         | DiffBrTypes => "Plc Checker: 'if' branch types differ."
         | IfCondNotBool => "Plc Checker: 'if' condition not Boolean"
         | NoMatchResults => "Plc Checker: no Match results."
         | MatchResTypeDiff => "Plc Checker: 'match' result types differ."
         | MatchCondTypesDiff => "Plc Checker: 'match' condition types differ matching expressions's type."
         | CallTypeMisM => "Plc Checker: Type mismatch in function call."
         | NotFunc => "Plc Checker: Not a function call."
         | ListOutOfRange => "Plc Checker: List index out of range."
         | OpNonList => "Plc Checker: Selection with operator # applied to non-list."
         | Impossible => "Plc Interp: is not a Plc comand."
         | HDEmptySeq => "Plc Interp: 'hd' empty sequence argument."
         | TLEmptySeq => "Plc Interp: 'tl' empty sequence argument."
         | ValueNotFoundInMatch => "Plc Interp: value not found in match."
         | NotAFunc => "Plc Interp: Not a function call."
         | DefaultMatchException => "Plc Interp: Default match must be the last.";
