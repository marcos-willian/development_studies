perceptron <- function(vetorEntrada, vetorPesos, par)
# Calcula a resposta de um Perceptron  Simples
# vetorEntrada: Vetor de valores de entrada aumentado  
# vetorPesos: Vetor de pesos aumentado como coluna de uma matriz
# Retorno: retorna a resposta do perceptron com uma coluna de uma matriz.(1 ou 0)
{
  if(par == 1){
    vetorEntrada <- append(-1,vetorEntrada)
  }
  produtoPonto <- vetorEntrada %*% vetorPesos #Soma das vari?veis
  respostaPerceptron <- as.numeric(produtoPonto>=0) #Resposta do limiar
  return(as.matrix(respostaPerceptron))
}