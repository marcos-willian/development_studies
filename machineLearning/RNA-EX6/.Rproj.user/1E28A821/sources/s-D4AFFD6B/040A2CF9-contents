library('corpcor')
treinaELM <- function(xin, yin, p, par)
#Realza o treinamento de uma ELM
# xin = matrix de entradas
# yin = vetor de entradas (0 ou 1 para cada classe)
# p = número de neuronios da camada intermediária
# par = deve adicionar o termo de polarização a entrada
# Retorno: Vetor de pesos da ultima camada (W) e matriz de pesos da camada intermediária (Z)
{
  n = dim(xin)[2]
  
  if(par == TRUE){
    xin = cbind(1, xin)
    Z =  replicate(p, runif((n + 1), min = -0.5, max = 0.5))
  }else{
    Z =  replicate(p, runif((n), min = -0.5, max = 0.5))
  }
  
  H = tanh(xin %*% Z)
  
  W = (pseudoinverse(H)) %*% yin
  
  return(list(W = W, Z = Z))
}