rm(list = ls())

mostraImagem <- function( x ){
  rotate <- function(x) t(apply(x, 2, rev))
  img <- matrix( x, nrow=64 )
  cor <- rev( gray(50:1/50) )
  image( rotate( img ), col=cor )
}

acurracy <- function(respostas, teste){
  return(sum(as.numeric(respostas == teste))/length(respostas))
}

library(caTools) #Função sample.split
require(RnavGraphImageData)
require(caret)
require(naivebayes)

# Carregando a Base de dados
dataFaces = list()
data( faces )
dataFaces$faces = t( faces )
colnames(dataFaces$faces) = paste("v" ,
                                  as.character(seq(from = 1, to = ncol(dataFaces$faces), by = 1)), 
                                  sep = ".")
rownames(dataFaces$faces) = NULL

#Gerando os rótulos
y <- NULL
for(i in 1:nrow(dataFaces$faces) ){
  y <- c( y, ((i-1) %/% 10) + 1 )
}
dataFaces$classes = as.factor(y)

#Realiza redução da dimensionalidade
dataFaces$pcaFaces = predict( preProcess(dataFaces$faces, 
                                         method = c("BoxCox", "center", "scale", "pca")),
                              dataFaces$faces)

acuracia = list(total = NULL)
for(i in 1:41){
  acuracia[i+1] = NULL

}
maxAcuracy = 0
nComponentes = 63
set.seed(0)
#Separa dados de treinamento e teste
for(i in 1:10){
  splitTrainData = NULL
  for(k in 1:40){
    splitTrainData = c(splitTrainData, 
                       sample.split(dataFaces$classes[dataFaces$classes == dataFaces$classes[k*1]], 1/2))
  }
  trainData = list(
    pcaFaces = dataFaces$pcaFaces[splitTrainData, ],
    classes = dataFaces$classes[splitTrainData]
  )
  testData = list(
    pcaFaces = dataFaces$pcaFaces[!splitTrainData, ],
    classes = dataFaces$classes[!splitTrainData]
  )
  
  #Treina modelo
  bayesTrain = naive_bayes(trainData$pcaFaces[, 1:nComponentes], trainData$classes)
  
  #Testa modelo
  bayesClass = predict(bayesTrain, newdata = testData$pcaFaces[, 1:nComponentes], type = "class")
  
  
  acuracia$total = c(acuracia$total, acurracy(testData$classes, bayesClass))
  
  for(k in 1:40){
    acuracia[[k+1]] = c(acuracia[[k+1]], 
                        acurracy(testData$classes[((k-1)*5 + 1):(k*5)], bayesClass[((k-1)*5 + 1):(k*5)]))
  }
  
  if(acuracia$total[i] > maxAcuracy){
    maxAcuracy = acuracia$total[i]
    matrixConfusao = confusionMatrix(data = bayesClass, reference = testData$classes)
  }
}

acuraciaMedia = matrix(0, ncol = 3, nrow = 41)
acuraciaMedia[1, ] = c("Total", mean(acuracia$total), sd(acuracia$total))

for(k in 1:40){
  acuraciaMedia[k+1, ] = c(k, mean(acuracia[[k+1]]), sd(acuracia[[k+1]]))
}

colnames(acuraciaMedia) = c("Classe", "Acurácia média", "Desvio Padrão")
write.table(acuraciaMedia, "acuracia.csv", sep = ";", dec = ",", row.names = FALSE)
write.table(matrixConfusao$table, "confusao.csv", sep = ";", dec = ",")



