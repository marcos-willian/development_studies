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



acuTrain = NULL
acuTest = NULL
#Começa o loop
for(i in 1:50){
  #Amostra 70 de cada classe para compor o treino
  sampleTrain = sample.split(classe, SplitRatio = 7/10)
  
  #sepra amostras de treino
  y_train = classe[sampleTrain] 
  x_train = as.matrix(dataSet[sampleTrain, ])
  
  #separa amostra de teste
  y_test = classe[!sampleTrain]
  x_test = as.matrix(dataSet[!sampleTrain, ])
  
  retList =  treinaPerceptron(x_train, y_train, 0.1, 0.001, 100, 1)
  w = retList$w
  
  y_train_modelo = c()
  for(j in 1:dim(x_train)[1]){
    y_train_modelo [j] = perceptron(x_train[j,], w, 1)
  }
  
  y_test_modelo = c()
  for(j in 1:dim(x_test)[1]){
    y_test_modelo[j] = perceptron(x_test[j,], w, 1)
  }
  
  acuTrain[i] = acurracy(y_train, y_train_modelo)
  acuTest[i] = acurracy(y_test, y_test_modelo)
  
}


mean(acuTrain)
sd(acuTrain)
mean(acuTest)
sd(acuTest)

