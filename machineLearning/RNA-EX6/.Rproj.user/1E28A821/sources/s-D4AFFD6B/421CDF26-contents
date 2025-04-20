rm(list = ls())
library("caTools")
source("treinaELM.R")
source("ELM.R")

acurracy <- function(respostas, teste){
  return(sum(as.numeric(respostas == teste))/length(respostas))
}
set.seed(10)


heart = read.table("heart.dat", sep = " ", dec = ".")

#Tratamento dos dados 
classes = ifelse( heart[complete.cases(heart), 14] == "1", 1, -1)
dataSet = heart[complete.cases(heart), 1:13]

for (i in 1:ncol(dataSet)) {
  minC <- min(dataSet[, i])
  maxC <- max(dataSet[, i])
  for (j in 1:nrow(dataSet)) {
    dataSet[j, i] = (dataSet[j, i] - minC)/(maxC - minC)
  }
}


pvector = seq(5, to = 100, by = 5)
pvector = append(pvector, 300)
outTable = matrix(nrow =  length(pvector), ncol = 4)
indice = 0
for(p in pvector){ #LOOP num neuronios
  indice = indice + 1
  acuTrain = NULL
  acuTest = NULL
  for(i in 1:100){#Num execuções
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
colnames(outTable) =  c("Acurácia Média Treinamento",
                        "Desvio Padrão Treinamento",
                        "Acurácia Média Teste", 
                        "Desvio Padrão Teste")

write.csv2(outTable, "IMG/saidaHeart.csv")

plot(pvector,outTable[,3], 
     type = 'b',
     pch = 19,
     xlab = "Número de neurônios",
     ylab = "Acurácia média")
