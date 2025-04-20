rm(list = ls())

source("bayesClassificator.R")
library("naivebayes")
library(caTools) #Função sample.split

#funções
criaGaussianaClassificada <- function(centro, numAmostras, desvio, class){
  retList = list()
  retList$gaussiana = matrix(rnorm(numAmostras*2), ncol=2)*desvio + t(matrix(centro, nrow = 2, ncol = numAmostras))
  retList$classe = matrix(class, ncol = 1, nrow = numAmostras) #Classifica
  return(retList)
}
cores = c("blue", "red", "green", "black" )
sd = 0.39
gaussiana1 = criaGaussianaClassificada(c(2,2), 200, sd, 1)
gaussiana2 = criaGaussianaClassificada(c(4,4), 200, sd, 1)
gaussiana3 = criaGaussianaClassificada(c(2,4), 200, sd, -1)
gaussiana4 = criaGaussianaClassificada(c(4,2), 200, sd, -1)



gaussianaTreino = list()
gaussianaTeste = list()
porcentagemTreino = 0.9
#Seleciona aleatoriamente 90% das amostras e respostas treino de cada tipo
#Os 10% restantes são para teste do modelo

sampleTreino1 = sample.split(gaussiana1$classe, porcentagemTreino)
sampleTreino2 = sample.split(gaussiana2$classe, porcentagemTreino)
sampleTreino3 = sample.split(gaussiana3$classe, porcentagemTreino)
sampleTreino4 = sample.split(gaussiana4$classe, porcentagemTreino)

#Treino
gaussianaTreino$gaussiana = rbind(
                                  gaussiana1$gaussiana[sampleTreino1,], 
                                  gaussiana2$gaussiana[sampleTreino2,],
                                  gaussiana3$gaussiana[sampleTreino3,], 
                                  gaussiana4$gaussiana[sampleTreino4,])
gaussianaTreino$classe = as.factor(cbind(
                                          gaussiana1$classe[sampleTreino1,], 
                                          gaussiana2$classe[sampleTreino2,],
                                          gaussiana3$classe[sampleTreino3,], 
                                          gaussiana4$classe[sampleTreino4,]))

#Teste
gaussianaTeste$gaussiana = rbind(
                                  gaussiana1$gaussiana[!sampleTreino1,], 
                                  gaussiana2$gaussiana[!sampleTreino2,],
                                  gaussiana3$gaussiana[!sampleTreino3,], 
                                  gaussiana4$gaussiana[!sampleTreino4,])
gaussianaTeste$classe = as.factor(cbind(
                                          gaussiana1$classe[!sampleTreino1,], 
                                          gaussiana2$classe[!sampleTreino2,],
                                          gaussiana3$classe[!sampleTreino3,], 
                                          gaussiana4$classe[!sampleTreino4,]))

png("IMG/P2_treinamento.png")
plot(gaussianaTreino$gaussiana, col = cores[gaussianaTreino$classe],
     xlab = "X", ylab = "Y", main = "Dados de treinamento", xlim = c(0,6), ylim = c(0,6))
dev.off()


bayesTreino = bayesC(gaussianaTreino$gaussiana, gaussianaTreino$classe)


#superficie de separação
n = 1000
xGrid = seq(from = 0, to = 6, length = n)
grid = expand.grid(X1 = xGrid, X2 = xGrid)
grid = cbind(grid$X1,grid$X2)
decisionSurface = matrix(as.numeric(bayesTreino$classificar(grid)), nrow = n, ncol = n)
png("IMG/P2_contorno.png")
plot(gaussianaTreino$gaussiana, col = cores[gaussianaTreino$classe],
     xlab = "X", ylab = "Y", main = "Contorno de separação das classes", xlim = c(0,6), ylim = c(0,6))
contour(xGrid, xGrid, z = decisionSurface, add = TRUE, drawlabels = FALSE)
dev.off()

classesTeste = as.factor(bayesTreino$classificar(gaussianaTeste$gaussiana))
acuracia = sum(as.numeric(gaussianaTeste$classe == classesTeste))/length(gaussianaTeste$classe)

#Plota dados treinamento não classificado
png("IMG/P2_nao_C.png")
plot(gaussianaTeste$gaussiana, pch = 19, col = cores[4],
     xlab = "X", ylab = "Y", main = "Dados de teste não classificados", xlim = c(0,6), ylim = c(0,6))
contour(xGrid, xGrid, z = decisionSurface, add = TRUE, drawlabels = FALSE)
dev.off()

#Plota classificação
png("IMG/P2_classi.png")
plot(gaussianaTeste$gaussiana, col = cores[classesTeste],
     xlab = "X", ylab = "Y", main = "Dados de teste classificados", xlim = c(0,6), ylim = c(0,6), pch = 19)
contour(xGrid, xGrid, z = decisionSurface, add = TRUE, drawlabels = FALSE)
dev.off()

png("IMG/P2_respostas.png")
plot(gaussianaTeste$gaussiana, col = cores[gaussianaTeste$classe],
     xlab = "X", ylab = "Y", main = "Dados de teste com a respota original", xlim = c(0,6), ylim = c(0,6), pch = 19)
contour(xGrid, xGrid, z = decisionSurface, add = TRUE, drawlabels = FALSE)
dev.off()

