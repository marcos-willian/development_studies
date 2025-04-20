

desidadeKernel <- function(x, ClassInfo){
  temp = (1/(ClassInfo$N*(sqrt(2*pi)*ClassInfo$h)^ClassInfo$n))
  temp2 = 0
  for(j in 1:dim(ClassInfo$amostras)[1]){
    temp3 = 0
    for(k in 1:ClassInfo$n){
      temp3 = temp3 + ((x[k] - ClassInfo$amostras[j,k]))^2
    }
    temp2 = temp2 + exp(-1*temp3/(2*(ClassInfo$h^2)))
  }
  return( temp * temp2  )
}


kdeC <- function(dado, classes){
  level = levels(classes)
  classe1 = classes == level[1]
  classe2 = classes == level[2]
  
  retList = list()
  retList$classe1$N = length(classes[classe1])
  retList$classe1$n = dim(dado)[2]
  retList$classe1$h = 1.06 * sd(dado) * (retList$classe1$N^(-1/5))
  retList$classe1$priori = length(classes[classe1])/length(classes)
  retList$classe1$amostras = dado[classe1,]
  retList$classe1$level = level[1]
  
  retList$classe2$N = length(classes[classe2])
  retList$classe2$n = dim(dado)[2]
  retList$classe2$h = 1.06 * sd(dado) * (retList$classe2$N^(-1/5))
  retList$classe2$priori = length(classes[classe2])/length(classes)
  retList$classe2$amostras = dado[classe2,]
  retList$classe2$level = level[2]
  
  retList$classificar <- function(List, dados){
    retClass = list()
    retClass$class = c()
    densidade1 = c()
    densidade2 = c()
    for(i in 1:dim(dados)[1]){
      densidade1[i] = desidadeKernel(dados[i,], List$classe1)
      densidade2[i] = desidadeKernel(dados[i,], List$classe2)
      K = ( (densidade1[i]*List$classe1$priori) / (densidade2[i]*List$classe2$priori) )
      if(K >= 1){
        retClass$class[i] = List$classe1$level
      }else{
        retClass$class[i] = List$classe2$level
      }
    }
    retClass$vero = cbind(densidade1,densidade2)
    retClass$class = as.factor(retClass$class)
    return(retClass)
  }
  
  return(retList)
}