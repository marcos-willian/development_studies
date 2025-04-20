
rm(list = ls())

source("kdeClassificator.R")
library(caTools) #Função sample.split
library("mlbench")

partition <- function(nfolds, nSplit, data){
  subsets = list()
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


#Variaveis gerais
cores = c("red", "blue", "green")

#Criando 1000 amostras de treinamento
espiral<-mlbench.spirals(1000,1,0.09)
set.seed(1)

#preparação dos dados
cl1 = espiral$classes == levels(espiral$classes)[1]
cl2 = espiral$classes == levels(espiral$classes)[2]
classe1 = list(x = espiral$x[cl1,], classes = espiral$classes[cl1])
classe2 = list(x = espiral$x[cl2,], classes = espiral$classes[cl2])

nfolds = 10
nSplit = sum(as.numeric(cl1))/nfolds
subC1 = partition(nfolds, nSplit, classe1)
subC2 = partition(nfolds, nSplit, classe2)
subset = list()
for(i in 1:nfolds){
  subset[[i]] = list(
    x = rbind(subC1[[i]]$x, subC2[[i]]$x),
    classes = as.factor(rbind(as.matrix(subC1[[i]]$classes), as.matrix(subC2[[i]]$classes)))
  )
}

#realiza crossvalidation
acuracia = c()
folds = seq(from = 1, to = nfolds, by = 1)
for(i in folds){
  dataTest = subset[[i]]
  dataTrain = list()
  dataTrain$classes = factor()
  for(j in folds[-i]){
    dataTrain$x = rbind(dataTrain$x, subset[[j]]$x)
    dataTrain$classes = as.factor(rbind(as.matrix(dataTrain$classes), as.matrix(subset[[j]]$classes)))
  }
  
  kdeTrain = kdeC(dataTrain$x, dataTrain$classes)
  
  res = kdeTrain$classificar(kdeTrain, dataTest$x)
  
  acuracia[i] = sum(as.numeric(dataTest$classes == res$class))/length(dataTest$classes)
}
meanAcuracia = mean(acuracia)
desvAcuracia = sd(acuracia)
print(meanAcuracia)
print(desvAcuracia)

#Plots para a última repartição
#Os dados de treinamento
plot(dataTrain$x, col = cores[dataTrain$classes],
     xlab = "X", ylab = "Y", main = "Dados de treinamento")

#Plota superficie de decisão
n = 200
xGrid = seq(from = -1, to = 1, length = n)
grid = expand.grid(X1 = xGrid, X2 = xGrid)
grid = cbind(grid$X1,grid$X2)
decisionSurface = matrix(as.numeric(kdeTrain$classificar(kdeTrain, grid)$class), nrow = n, ncol = n)
plot(dataTrain$x, col = cores[dataTrain$classes],
     xlab = "X", ylab = "Y", main = "Superfície de densidade de probabilidade")
contour(xGrid, xGrid, decisionSurface, add = TRUE, drawlabels = FALSE)

#Plot os dados de teste
plot(dataTest$x, xlab = "X", ylab = "Y", main = "Dados de teste", pch = 19, col = "black")
contour(xGrid, xGrid, decisionSurface, add = TRUE, drawlabels = FALSE)

#Plot dados classificados
plot(dataTest$x, xlab = "X", ylab = "Y", main = "Dados de teste classificados", pch = 19, col = cores[res$class])
contour(xGrid, xGrid, decisionSurface, add = TRUE, drawlabels = FALSE)

#Plot dados de teste no espaço de verossimilhancas
plot(res$vero,
     xlim = c(0, 1),
     ylim = c(0, 1),
     xlab = "X", 
     ylab = "Y", 
     main = "Dados de teste no espaço de verossimilhanças", 
     pch = 19, 
     col = cores[res$class]
     )
x = seq(from = 0, to = 1, length.out = 100)
lines(x,x)


