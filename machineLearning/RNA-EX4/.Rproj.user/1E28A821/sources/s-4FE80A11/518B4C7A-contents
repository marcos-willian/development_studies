treinaPerceptron <- function(matrixEntrada, vetorResposta, passoTreino, tolerancia, maxEpocas, par)
  # Rotina de treinamento do perceptron simples. 
  #Gera o vetor de pesos especifico para a aplica??o
  # matrixEntrada: matriz Nxm das amostras de entrada 
  #onde m ? dimens?o dos artributos e N o n?mero de amostras
  # vetorResposta: vetor coluna com resultados esperados para cada uma das N amostras
  # passoTreino: Passo de treinamento, ? a constante de proporcionalidade para a 
  #equa??o de treinamento.
  # tolerancia: discrepancia aceita do resultado e da resposta do perceptron
  # maxEpocas: n?mero m?ximo de intera??es de treinamento
{
  dimensaoEntrada <- dim(matrixEntrada)
  N <- dimensaoEntrada[1] #Numero de amostras
  m <- dimensaoEntrada[2] #Numero de atributos
  
  #Adicionando o termo de polariza??o
  if(par == 1){
    matrixEntradaAumentada <- cbind(-1,matrixEntrada)
    vetorPesos <-as.matrix(runif(m+1) - 0.5)
  }else{
    matrixEntradaAumentada <- matrixEntrada
    vetorPesos <-as.matrix(runif(m) - 0.5)
  }
  
  #inicia setup
  nEpocas <- 0
  erroEpoca <- tolerancia + 1
  vetorErros <- matrix(nrow = 1, ncol = N)
  
  #treina perceptron
  while((nEpocas < maxEpocas) && (erroEpoca > tolerancia)){
    erroEpocaAcumulado <- 0
    sequenciaAleatoria <- sample(N)
    for(i in 1:N){
      instanciaRandomica <- sequenciaAleatoria[i]
      #Calcula resposta do perceptron
      respostaPerceptron = as.numeric(perceptron(matrixEntradaAumentada[instanciaRandomica,], vetorPesos, 0))
      #Calcula erro de ajuste do vetor peso
      erro = vetorResposta[instanciaRandomica] - respostaPerceptron
      deltaPesos = passoTreino*erro*matrixEntradaAumentada[instanciaRandomica ,]
      vetorPesos = vetorPesos + deltaPesos
      #acumula erro da epoca com o modulo do erro
      erroEpocaAcumulado <- erroEpocaAcumulado + erro*erro
    }
    nEpocas <- nEpocas + 1
    vetorErros[nEpocas] <- erroEpocaAcumulado/N
    erroEpoca <- vetorErros[nEpocas]
  }
  retlist <- list(w = vetorPesos, erro = vetorErros[1:nEpocas])
  return(retlist)
}