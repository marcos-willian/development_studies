rm(list = ls())
library('RSNNS')
library("caTools")

MSE <- function(yTest, yhat){
  sum = 0
  N = dim(yTest)[1]
  for(i in 1:N){
    err = t(as.matrix(yTest[i,] - yhat[i,]))
    sum = sum + ((err) %*% t(err))
  }
  return(sum/N)
}

escalona <- function(dataSet){
  for (i in 1:ncol(dataSet)) {
    minC <- min(dataSet[, i])
    maxC <- max(dataSet[, i])
    for (j in 1:nrow(dataSet)) {
      dataSet[j, i] = (dataSet[j, i] - minC)/(maxC - minC)
    }
  }
  return(dataSet)
}

heart = read.table("heart.dat", sep = " ", dec = ".")
classe = ifelse( heart[complete.cases(heart), 14] == "1", 0, 1)
dataSet = escalona(heart[complete.cases(heart), 1:13])

# housing = read.table("housing.data",  dec = ".", fill = TRUE)
# classe = escalona(as.matrix(housing[complete.cases(housing), 14]))
# dataSet = escalona(housing[complete.cases(housing), 1:13])

indice = 0
outTable = matrix(nrow = 4, ncol = 4)
for(numN in c(5, 10, 20, 40)){
  indice = indice + 1
  errTest = NULL
  errTrain = NULL
  for(i in 1:5){
    #Amostra 70 de cada classe para compor o treino
    sampleTrain = sample.split(classe, SplitRatio = 7/10)
    
    #sepra amostras de treino
    y_train = classe[sampleTrain] 
    x_train = as.matrix(dataSet[sampleTrain, ])
    
    #separa amostra de teste
    y_test = classe[!sampleTrain]
    x_test = as.matrix(dataSet[!sampleTrain, ])
    
    
    rede = mlp(x_train,
               y_train,
               size = numN,
               maxit = 2000,
               initFunc =  "Randomize_Weigths",
               learnFunc = "Rprop",
               initFuncParams =  c(-0.3, 0.3),
               hiddenActFunc =  'Act_Logistic',
               shufflePatterns = T,
               linOut = T)
    errTrain[i] = rede$IterativeFitError[length(rede$IterativeFitError)]
    yhat =  predict(rede, x_train)
    
    errTest[i] = MSE(as.matrix(y_test), yhat)
  }
  
  outTable[indice, 1] = mean(errTrain)
  outTable[indice, 2] = sd(errTrain)
  outTable[indice, 3] = mean(errTest)
  outTable[indice, 4] = sd(errTest)

}


colnames(outTable) =  c("MSE Médio - Treinamento",
                        "Desvio Padrão - Treinamento",
                        "MSE Médio - Teste", 
                        "Desvio Padrão - Teste")
row.names(outTable) = as.character(c(5, 10, 20, 40))

write.csv2(outTable, "saidaHeartLin.csv")
