rm(list =  ls())

#Vamos usar o adline com uma entrada constante
treinaAdaline <- function(x, y, passo, tolerancia, maxEpocas, constInput){
  # constInput é se usa ou não uma entrada constante
  N = dim(x)[1]
  n = dim(x)[2]
  
  if(constInput){
    w = as.matrix(runif(n + 1) -0.5)
    x = cbind(1, x)
  }  else{
    w = as.matrix(runif(n) -0.5)
  }
  
  epocaAtual = 0
  erroEpoca = 1000
  erroPorEpoca = c()
  while(epocaAtual < maxEpocas && erroEpoca > tolerancia){
    erroAcumulado2 = 0
    xRand = sample(N)
    for(i in xRand){
      yModelo = x[i,] %*% w
      
      erro = (y[i] - yModelo)
      w = w + as.matrix(c(passo*erro)*(x[i,]))
      
      erroAcumulado2 = erroAcumulado2 + erro^2
    }
    epocaAtual = epocaAtual + 1
    erroEpoca = erroAcumulado2/N
    erroPorEpoca[epocaAtual] = erroEpoca
  }
  retlist = list(w = w, erro = erroPorEpoca)
  return(retlist)
}

t = as.matrix(read.table('t'))
x = as.matrix(read.table('x'))
y = as.matrix(read.table('y'))

png('IMG/EntradasEX2.png')
par(mfrow = c(2,2))
plot(t,
     x[,1], 
     pch = 19,
     type = 'b',
     col = "black", 
     main = "Amostras x1",
     ylab = "")
plot(t,
     x[,2], 
     pch = 19,
     type = 'b',
     col = "green", 
     main = "Amostras x2",
     ylab = "")
plot(t,
     x[,3], 
     pch = 19,
     type = 'b',
     col = "blue", 
     main = "Amostras x3",
     ylab = "")
plot(t,
     y, 
     pch = 19,
     type = 'b',
     col = "red", 
     main = "Saída",
     ylab = "")
par(mfrow = c(1,1))
dev.off()

resposta =  treinaAdaline(x, y, passo = 0.01, tolerancia = 0.001, maxEpocas = 100, constInput = T)

png('IMG/ErroEX2.png')
plot(resposta$erro,
     pch = 19,
     type = 'b',
     col = "black", 
     new = T, 
     main = "Erro de treinamento",
     ylab = "Erro",
     xlab = "Epoca")
dev.off()

yTeste = cbind(1, x) %*% resposta$w

png('IMG/ModeloEX2.png')
plot(t,
     yTeste, 
     type = 'b',
     col = "blue", 
     new = T, 
     main = "Avaliação do modelo",
     ylab = "",
     xlab = "t")
points(t,
       y,
       pch = 19,
       type = 'b',
       col = "red")
legend(x = "topright",
       legend = c("Saida original", "Resposta do Modelo"),
       col = c( "red", "blue"),
       lty = 1,
       lwd = 3, 
       bty = "n")
dev.off()
