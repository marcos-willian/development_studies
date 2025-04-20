ELM <- function(xin, Z, W, par)
  #Calcula a saída de uma rede ELM dado as matrizes de peso
  #xin = matriz de entrada
  #Z =  matriz de pesos da camada intermediária
  #W = vetor de pesos da ultima camada
  #par =  deve ou não acrescentar o termo de polarização
  #Retorno: Vetor com a resposta gerada (0 ou 1)
{
  n  = dim(xin)[2]
  
  if(par == TRUE){
    xin =  cbind(1, xin)
  }
  
  H = tanh(xin %*% Z)
  Y =  sign((H %*% W))
  return(Y)
}