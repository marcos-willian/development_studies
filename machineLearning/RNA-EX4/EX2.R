rm(list = ls())
source("treinaPerceptron.R")
source("perceptron.R")
library("caTools")

acurracy <- function(respostas, teste){
  return(sum(as.numeric(respostas == teste))/length(respostas))
}


sd = 0.4
numAmostras = 200
gaussiana1 =  matrix(rnorm(numAmostras*2), ncol = 2)*sd + t(matrix(c(2,2), ncol = numAmostras, nrow = 2))
gaussiana2 =  matrix(rnorm(numAmostras*2), ncol = 2)*sd + t(matrix(c(4,4), ncol = numAmostras, nrow = 2))

amostras = rbind(gaussiana1, gaussiana2)

classe = cbind(matrix(0, ncol = 200), matrix(1, ncol = 200))

sampleTrain = sample.split(classe, 0.7) #separa classes balanceadas

y_train = classe[sampleTrain] #tem a mesma porcentagem de uma classe e de outra
x_train = amostras[sampleTrain,]

y_test = classe[!sampleTrain]
x_test = amostras[!sampleTrain,]

retList =  treinaPerceptron(x_train, y_train, 0.1, 0.01, 100, 1)
w = retList$w

y_estimado = c()
for(i in 1:dim(x_test)[1]){
  y_estimado[i] = perceptron(x_test[i,], w, 1)
}


print(acurracy(y_test, y_estimado))

write.table(table(y_test, y_estimado), "IMG/confusao.csv", sep = ";", dec = ",")

png("IMG/2-erro.png")
plot(retList$erro, xlab = "Epoca", ylab = "Erro", main = "Erro de treinamento", type = 'b', pch = 19)
dev.off()
