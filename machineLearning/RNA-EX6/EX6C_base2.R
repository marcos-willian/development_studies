rm(list = ls())
source("treinaPerceptron.R")
source("perceptron.R")
library("caTools") # Funçã sample.split
library(mlbench) #Banco BreastCancer
set.seed(0)

acurracy <- function(respostas, teste){
  return(sum(as.numeric(respostas == teste))/length(respostas))
}

heart = read.table("heart.dat", sep = " ", dec = ".")

#Tratamento dos dados 
classe = ifelse( heart[complete.cases(heart), 14] == "1", 0, 1)
dataSet = heart[complete.cases(heart), 1:13]



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
  
  retList =  treinaPerceptron(x_train, y_train, 0.01, 0.001, 100, 1)
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

outTable = matrix(nrow = 1, ncol = 4)
outTable[1, 1] = mean(acuTrain)
outTable[1, 2] = sd(acuTrain)
outTable[1, 3] = mean(acuTest)
outTable[1, 4] = sd(acuTest)

colnames(outTable) =  c("Acurácia Média - Treinamento",
                        "Desvio Padrão - Treinamento",
                        "Acurácia Média - Teste", 
                        "Desvio Padrão - Teste")

write.csv2(outTable, "IMG/saidaPERCHeart.csv")
