
vero <- function(entrada, classe){
  return( 
    (1/(2*pi*classe$Dx1*classe$Dx2*sqrt(1-classe$p^2)))*
    exp( (-1*(1/(2*(1-classe$p^2)))) * ( ((entrada[1]-classe$Ux1)/classe$Dx1)^2
                                        -2*classe$p * ((entrada[1]-classe$Ux1)/classe$Dx1) * ((entrada[2]-classe$Ux2)/classe$Dx2)
                                        + ((entrada[2]-classe$Ux2)/classe$Dx2)^2 ) 
        )
  )
}


bayesC <- function(dado, classes){
  level = levels(classes)
  classe1 = classes == level[1]
  classe2 = classes == level[2]
  prioriC2 = length(classes[classe2])/length(classes)
  
  retList = list()
  retList$classe1$Ux1 = mean(dado[classe1,1])
  retList$classe1$Ux2 = mean(dado[classe1,2])
  retList$classe1$Dx1 = sd(dado[classe1,1])
  retList$classe1$Dx2 = sd(dado[classe1,2])
  retList$classe1$cov = cov(dado[classe1,1], dado[classe1,2])
  retList$classe1$p = retList$classe1$cov/(sqrt((retList$classe1$Dx1^2)*(retList$classe1$Dx2^2)))
  retList$classe1$level = level[1]
  retList$classe1$priori = length(classes[classe1])/length(classes)
  
  retList$classe2$Ux1 = mean(dado[classe2,1])
  retList$classe2$Ux2 = mean(dado[classe2,2])
  retList$classe2$Dx1 = sd(dado[classe2,1])
  retList$classe2$Dx2 = sd(dado[classe2,2])
  retList$classe2$cov = cov(dado[classe2,1], dado[classe2,2])
  retList$classe2$p = retList$classe2$cov/(sqrt((retList$classe2$Dx1^2)*(retList$classe2$Dx2^2)))
  retList$classe2$level = level[2]
  retList$classe2$priori = length(classes[classe2])/length(classes)
  
  retList$classificar <- function(dados){
    retCla = c()
    for(i in 1:length(dados[,1])){
      veroC1 = vero(dados[i,], retList$classe1)
      veroC2 = vero(dados[i,], retList$classe2)
      K = ( (veroC1*retList$classe1$priori) / (veroC2*retList$classe2$priori) )
      if(K >= 1){
        retCla[i] = retList$classe1$level
      }else{
        retCla[i] = retList$classe2$level
      }
    }
    return(retCla)
  }
  
  return(retList)
}

