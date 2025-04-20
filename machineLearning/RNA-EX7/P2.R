rm(list = ls())
library("mlbench")
source("treinaRBF.R")
source("YRBF.R")

xtrain = runif(100, -15, 15)
ytrain = sin(xtrain)/xtrain + rnorm(100, 0, 0.05)



sinc = seq(from = -15, to = 15, by = 0.1)
png("IMG/AmostrasdetreinoP2.png")
plot(sinc, 
     sin(sinc)/sinc,
     xlab = "x",
     ylab = "y",
     col = "red",
     type  = 'l',
     main = "Amostras geradas para treinamento")
points(xtrain, ytrain)
dev.off()

numTeste = 50

xTest =  runif(numTeste, -15, 15) # Cria amostras de teste
yTest = sin(xTest)/xTest + rnorm(numTeste, 0, 0.05)

maxPerformace = 1000
yMaxPerformace = NULL
performaces = NULL
pMax = NULL
for(p in 1:20){
  modRBF =  treinaRBF(xtrain, ytrain, p)
  y = YRBF(xTest, modRBF)
  performace = (sum((yTest - y)^2))/numTeste
  performaces[p] = performace
  if(performace < maxPerformace){
    pMax = p
    maxPerformace = performace
    yMaxPerformace = y
  }
}

write.table(performaces, file = "perf.xls", sep = "\t", dec = ",", col.names = F)
png("IMG/resultadosP2.png")
plot(xTest, yTest, main = "Amostras de teste", xlab = "x", ylab = "y", col = "blue")
points(xTest, yMaxPerformace, pch = 19, col = "red")
legend(x = 'topright',
       legend = c("Dados de teste", "Resposta do modelo"),
       col = c("blue", 'red'),
       pch = c(1, 19))
dev.off()
