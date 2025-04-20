rm(list = ls())
source("treinaPerceptron.R")
source("perceptron.R")
library("caTools") # Funçã sample.split
library(mlbench) #Banco BreastCancer
set.seed(0)

acurracy <- function(respostas, teste){
  return(sum(as.numeric(respostas == teste))/length(respostas))
}

data("BreastCancer")
dataSet = BreastCancer[complete.cases(BreastCancer), 2:10]
classes = BreastCancer[complete.cases(BreastCancer), 11]
#Cria classes
classe = ifelse(classes == "benign", 0, 1)
dataSet = apply(dataSet, 2, as.numeric)

acuracias = NULL
maxAcuracia = 0
maxAcuW = NULL
maxAcuErro = NULL

#Começa o loop
for(i in 1:100){
  #Amostra 70 de cada classe para compor o treino
  sampleTrain = sample.split(classe[classe == 0], SplitRatio = 7/10)
  sampleTrain = append(sampleTrain, sample.split(classe[classe == 1], SplitRatio = 7/10))
  
  #sepra amostras de treino
  y_train = classe[sampleTrain] 
  x_train = as.matrix(dataSet[sampleTrain, ])
  
  #separa amostra de teste
  y_test = classe[!sampleTrain]
  x_test = as.matrix(dataSet[!sampleTrain, ])
  
  retList =  treinaPerceptron(x_train, y_train, 0.1, 0.001, 100, 1)
  w = retList$w
  
  y_estimado = c()
  for(j in 1:dim(x_test)[1]){
    y_estimado[j] = perceptron(x_test[j,], w, 1)
  }
  
  acuracias[i] = acurracy(y_test, y_estimado)
  if(acuracias[i] > maxAcuracia){
    maxAcuracia = acuracias[i]
    maxAcuW = w
    maxAcuErro = retList$erro
    write.table(table(y_test, y_estimado), "IMG/4-confusao.csv", sep = ";", dec = ",")
  }
}

print(maxAcuracia)
print(maxAcuW)
print(mean(acuracias))
print(var(acuracias))

png("IMG/4-erro.png")
plot(maxAcuErro, xlab = "Epoca", ylab = "Erro", main = "Erro de treinamento", type = 'b', pch = 19)
dev.off()

