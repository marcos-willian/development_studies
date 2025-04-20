rm(list = ls())

set.seed(16)

acurracy <- function(respostas, teste){
  return(sum(as.numeric(respostas == teste))/length(respostas))
}

partition <- function(nfolds,  data){
  subsets = list()
  nSplit = ceiling(length(data$classes)/nfolds)
  for(i in 1:nfolds){
    if(length(data$classes) > nSplit){
      smpl = sample.split(data$classes, nSplit)
      subsets[[i]] = list(x = data$x[smpl,], classes = data$classes[smpl])
      data$x = data$x[!smpl,]
      data$classes = data$classes[!smpl]
    }else{
      subsets[[i]] = list(x = data$x, classes = data$classes)
    }
  }
  return(subsets)
}

#require(caret)
library(caTools) #Função sample.split
require(stats)
library(kernlab)
library(factoextra)
library(mlbench) #BreastCancer

data(BreastCancer) # carrega dados
dataBase = na.omit(BreastCancer) # elimina dados faltantes
dataBase$Label[dataBase$Class == "benign"] = -1 # muda labels
dataBase$Label[dataBase$Class == "malignant"] = 1 # muda labels
atributos = data.matrix(dataBase[,2:10])
classes = as.factor(data.matrix(dataBase[,12]))

pcaAtributos = prcomp(atributos,  center = TRUE)
pcaAtributos$egv = apply(pcaAtributos$x, 2, var) # Calcula os auto valores que é a variância dos dados
pcaExplica = pcaAtributos$egv/sum(pcaAtributos$egv)*100

plot(1:length(pcaAtributos$sdev),
     pcaAtributos$egv,
     pch = 19,
     main = "Variância das componetes.",
     ylab = "Variância",
     xlab = "Componetes")

fviz_eig(pcaAtributos, 
         addlabels = TRUE, 
         main = "Representatividade das componentes.", 
         ylab = "Porcentagem da explicação da variância total",
         xlab = "Componentes")


dataFolds = partition(10,  list(x = pcaAtributos$x[,1:5],
                                classes = classes)) #Reparte aleatoriamente 



# seqSig = seq(from = 0.9, to = 1.1, length.out = 10)
# seqC = seq(from = 2, to = 4, length.out = 10)
# acu = matrix(0,length(seqSig),length(seqC))
# k = 0
# for(sig in seqSig){
#   k = k+1
#   l = 0
#   for(c in seqC){
#     l = l+1
    acuraciaFold = NULL
    folds = seq(from = 1, to = 10, by = 1)
    for(i in folds){
      dataTest = dataFolds[[i]]
      dataTrain = list()
      dataTrain$classes = factor()
      for(j in folds[-i]){
        dataTrain$x = rbind(dataTrain$x, dataFolds[[j]]$x)
        dataTrain$classes = as.factor(rbind(as.matrix(dataTrain$classes), as.matrix(dataFolds[[j]]$classes)))
      }
      
      svmTreinamento = ksvm(dataTrain$x, 
                            dataTrain$classes, 
                            type = "C-bsvc",
                            kernel = "rbfdot",
                            kpar = list(sigma = 1),  #Para estimar o melhor valor para sigma use sig
                            C = 2.5) #Para estimar o melhor valor de C use c
      
      svmClassifica = predict(svmTreinamento, 
                             dataTest$x, 
                             type = "response", 
                             coupler = "minpair")
      
      acuraciaFold[i] = acurracy(dataTest$classes, svmClassifica)
    }
#     acu[k, l] = mean(acuraciaFold)
#   }
# }
# 
# rownames(acu) = as.character(seqSig)
# colnames(acu) = as.character(seqC)
# write.table(acu, "acu.csv", sep = ";")

acuraciaMean = mean(acuraciaFold)
acuraciaSD = sd(acuraciaFold)
acuraciaFold[i+1] = acuraciaMean
acuraciaFold[i+2] = acuraciaSD
names(acuraciaFold) = c(paste("Fold" ,
                                 as.character(seq(from = 1, to = 10, by = 1)), 
                                 sep = " "),
                           "Acuracia media", 
                           "Desvio Padrao")

write.table(acuraciaFold, "acuracia.csv", sep = ";")



