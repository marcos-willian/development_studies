rm(list = ls())
library(mlbench)
library("caTools")
source("treinaELM.R")
source("ELM.R")

acurracy <- function(respostas, teste){
  return(sum(as.numeric(respostas == teste))/length(respostas))
}


data("BreastCancer")

#Tratamento dos dados 
classes = ifelse( BreastCancer[complete.cases(BreastCancer), 11] == "benign", 1, -1)
dataSet = apply(BreastCancer[complete.cases(BreastCancer), 2:10], 2, as.numeric)
for (i in 1:ncol(dataSet)) {
  minC <- min(dataSet[, i])
  maxC <- max(dataSet[, i])
  for (j in 1:nrow(dataSet)) {
    dataSet[j, i] = (dataSet[j, i] - minC)/(maxC - minC)
  }
}


pvector = c(5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 300)
outTable = matrix(nrow =  length(pvector), ncol = 4)
indice = 0
for(p in pvector){ #LOOP num neuronios
  indice = indice + 1
  acuTrain = NULL
  acuTest = NULL
  for(i in 1:20){#Num execuções
    sampleTrain = sample.split(classes, SplitRatio = 7/10)
    #sepra amostras de treino
    y_train = classes[sampleTrain] 
    x_train = as.matrix(dataSet[sampleTrain, ])
    
    #separa amostra de teste
    y_test = classes[!sampleTrain]
    x_test = as.matrix(dataSet[!sampleTrain, ])
    
    modelo =  treinaELM(x_train, y_train, p, TRUE)
    
    y_train_modelo = ELM(x_train, modelo$Z, modelo$W, TRUE)
    y_test_modelo = ELM(x_test, modelo$Z, modelo$W, TRUE)
    
    acuTrain[i] = acurracy(y_train, y_train_modelo)
    acuTest[i] = acurracy(y_test, y_test_modelo)
  }
  outTable[indice, 1] = mean(acuTrain)
  outTable[indice, 2] = sd(acuTrain)
  outTable[indice, 3] = mean(acuTest)
  outTable[indice, 4] = sd(acuTest)
}

rownames(outTable) = as.character(pvector)
colnames(outTable) =  c("Acurácia Média - Treinamento",
                        "Desvio Padrão - Treinamento",
                        "Acurácia Média - Teste", 
                        "Desvio Padrão - Teste")

write.csv2(outTable, "IMG/saidaBreast.csv")

plot(pvector,outTable[,3], 
     type = 'b',
     pch = 19,
     xlab = "Número de neurônios",
     ylab = "Acurácia média")
