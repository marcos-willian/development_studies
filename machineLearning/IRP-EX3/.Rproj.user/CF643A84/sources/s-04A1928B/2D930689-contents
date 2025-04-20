KNN <- function(grupo, classes, amostras, K)
  #Grupos: amostras com classificadas  
  #classe: classe dos grupos
  #Amostras: amostras a serem classificadas
  #K: numero de visinhos observados 
  #Retorno: retorna a classe das amostras
{
  distancias = c()
  classeVisinhos = c()
  classificacaoAmostra = c()
  for(iAmostra in 1:dim(amostras)[1]){
    for(iGrupo in  1:dim(grupo)[1]){
      distancias[iGrupo] = distanciaCheby(grupo[iGrupo,], amostras[iAmostra,])
    }
    for(iClass in 1:K){
      visinhoProx = which(distancias == min(distancias, na.rm = TRUE), arr.ind = TRUE)
      distancias[visinhoProx] = NA
      classeVisinhos[iClass] = classes[visinhoProx]
    }
    classificacaoAmostra[iAmostra] = getmode(classeVisinhos)
  }
  return(classificacaoAmostra)
}



distanciaCheby <- function(x_i,x_j)
  #Calcula a distância pela métrica de Chebyshev
{
  return(max(abs(x_i - x_j)))
}

# Create the function.(Fonte: supor RStudio)
getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}
