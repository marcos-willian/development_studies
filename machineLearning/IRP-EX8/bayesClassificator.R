

desidadeMultivariada <- function(x, ClassInfo){
  return( 
    as.numeric((1/(sqrt(((2*pi)^ClassInfo$dim)*det(ClassInfo$MCov))))
    *
      exp((-0.5)*(t((x - ClassInfo$MVec))%*%solve(ClassInfo$MCov)%*%(x - ClassInfo$MVec)))
  ))
}


bayesC <- function(dado, classes){
  level = levels(classes)
  classe1 = classes == level[1]
  classe2 = classes == level[2]
  
  retList = list()
  retList$classe1$MVec = as.matrix(apply(dado[classe1,], MARGIN = 2, FUN = mean))
  retList$classe1$MCov = cov(dado[classe1,])
  retList$classe1$level = level[1]
  retList$classe1$priori = length(classes[classe1])/length(classes)
  retList$classe1$dim = length(dado[1,])
  
  retList$classe2$MVec = as.matrix(apply(dado[classe2,], MARGIN = 2, FUN = mean))
  retList$classe2$MCov = cov(dado[classe2,])
  retList$classe2$level = level[2]
  retList$classe2$priori = length(classes[classe2])/length(classes)
  retList$classe2$dim = length(dado[1,])
  
  retList$classificar <- function(List,dados){
    retClass = c()
    for(i in 1:length(dados[,1])){
      desidade1 = desidadeMultivariada(dados[i,], List$classe1)
      desidade2 = desidadeMultivariada(dados[i,], List$classe2)
      K = ( (desidade1*List$classe1$priori) / (desidade2*List$classe2$priori) )
      if(K >= 1){
        retClass[i] = List$classe1$level
      }else{
        retClass[i] = List$classe2$level
      }
    }
    return(retClass)
  }
  
  return(retList)
}