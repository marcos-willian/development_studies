rm(list = ls())

mostraImagem <- function( x ){
  rotate <- function(x) t(apply(x, 1, rev))
  img <- matrix( x, ncol=28 )
  cor <- rev( gray(255:1/255) )
  image(rotate(img) , col=cor)
}

acurracy <- function(respostas, teste){
  return(sum(as.numeric(respostas == teste))/length(respostas))
}

partition <- function(nfolds,  data){
  subsets = list()
  nSplit = ceiling(length(data[[2]])/nfolds)
  for(i in 1:nfolds){
    if(length(data[[2]]) > nSplit){
      smpl = sample.split(data[[2]], nSplit)
      subsets[[i]] = list(x = data[[1]][smpl,], classes = data[[2]][smpl])
      data[[1]] = data[[1]][!smpl,]
      data[[2]] = data[[2]][!smpl]
    }else{
      subsets[[i]] = list(x = data[[1]], classes = data[[2]])
    }
  }
  return(subsets)
}


library(caTools) #Função sample.split
library(naivebayes)
require(stats)
set.seed(0)

# Carregando a Base de dados
dataSet = list()
bancoDados = read.csv("trainReduzido.csv")
dataSet$x = as.matrix(bancoDados[,-(1:2)]) #Retira os dados daas imagens
dataSet$class = as.factor(bancoDados[,2])

pcaComponentes = prcomp(dataSet$x,  center = TRUE)
pcaComponentes$egv = apply(pcaComponentes$x, 2, var) # Calcula os auto valores que é a variância dos dados
pcaExplica = pcaComponentes$egv/sum(pcaComponentes$egv)*100


nfolds = 15
nComponentes = 100
dataFolds = partition(nfolds, list(pcaComponentes$x[,1:nComponentes], dataSet$class))

acuraciaFold = NULL
folds = seq(from = 1, to = nfolds, by = 1)
for(i in folds){
  dataTest = dataFolds[[i]]
  dataTrain = list()
  dataTrain$classes = factor()
  for(j in folds[-i]){
    dataTrain$x = rbind(dataTrain$x, dataFolds[[j]]$x)
    dataTrain$classes = as.factor(rbind(as.matrix(dataTrain$classes), as.matrix(dataFolds[[j]]$classes)))
  }
  
  kdeTreinamento = naive_bayes(dataTrain$x, dataTrain$classes, usekernel = TRUE)
  
  kdeClasse = predict(kdeTreinamento, newdata = dataTest$x, type = "class")
  
  acuraciaFold[i] = acurracy(dataTest$classes, kdeClasse)
}

acuraciaMean = mean(acuraciaFold)
acuraciaSD = sd(acuraciaFold)
acuraciaFold[i+1] = acuraciaMean
acuraciaFold[i+2] = acuraciaSD
names(acuraciaFold) = c(paste("Fold" ,
                              as.character(seq(from = 1, to = nfolds, by = 1)), 
                              sep = " "),
                        "Acuracia media", 
                        "Desvio Padrao")

write.table(acuraciaFold, "acuracia.csv", sep = ";")
  



