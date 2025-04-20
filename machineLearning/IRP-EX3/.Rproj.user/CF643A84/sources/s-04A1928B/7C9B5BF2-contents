rm(list = ls())
source("KNN.R")
library(class)

#funções
criaGaussianaClassificada <- function(centro, numero, desvio, classe){
  retList = list()
  retList$gaussiana = matrix(rnorm(numAmostrasGaussiana*2), ncol=2)*sd + t(matrix(centro, nrow = 2, ncol = numAmostrasGaussiana))
  retList$classe = matrix(classe, ncol = 1, nrow = numAmostrasGaussiana) #Classifica
  return(retList)
}

numAmostrasGaussiana = 100
for(sd in c(0.3, 0.5, 0.7)){
  gaussiana1 = criaGaussianaClassificada(c(2,2), numAmostrasGaussiana, sd, 1)#verde
  
  gaussiana2 = criaGaussianaClassificada(c(4,2), numAmostrasGaussiana, sd, 2)#azul
  
  gaussiana3 = criaGaussianaClassificada(c(2,4), numAmostrasGaussiana, sd, 3)#vermelho
  
  gaussiana4 = criaGaussianaClassificada(c(4,4), numAmostrasGaussiana, sd, 4)#magenta
  
  #Vector com todas as gaussianas e classes
  gaussianas = rbind(gaussiana1$gaussiana, gaussiana2$gaussiana, gaussiana3$gaussiana, gaussiana4$gaussiana)
  classes = rbind(gaussiana1$classe, gaussiana2$classe, gaussiana3$classe, gaussiana4$classe)
  
  #Cria amostras para classificação
  numAmostras = 20
  sdAmostra = 3
  amostras = matrix((runif(numAmostras*2) - 0.5), ncol = 2)*sdAmostra +
                t(matrix(c(3, 3), nrow = 2, ncol = numAmostras))
  
  cores = c("green", "blue", "red", "#8B008B", "black")
  
    #Plotagem sem classificação
    png(paste("IMG/_",as.character(sd)," SEM.png", sep = ""))
    plot(gaussianas, col = cores[classes], xlim = c(0,6), ylim = c(0,6), xlab ="X1", ylab = "X2", 
         main = "Pontos sem classificação", sub = paste("Desvio padrão: ", as.character(sd)))
    points(amostras, col = cores[5], pch = 19)
    dev.off()
  for(K in c(2, 4, 8)){
    classeAmostra = KNN(gaussianas, classes, amostras, K)
    
    png(paste("IMG/_",as.character(sd)," ", as.character(K)," COM.png",sep = ""))
    plot(gaussianas, col = cores[classes], xlim = c(0,6), ylim = c(0,6), xlab ="X1", ylab = "X2",
         main = "Pontos com classificação", sub = paste("K: ",as.character(K),"    Desvio padrão: ", as.character(sd)))
    points(amostras, col = cores[classeAmostra], pch = 19)
    dev.off()
  }
}


