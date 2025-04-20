rm(list = ls())
library("kernlab")
library("mlbench")
library("plot3D")
library(caTools) #Função sample.split
data(Glass)




#Prepara variàveis
levels = levels(Glass$Type)

vetorAcuracia<- c()
vetorErro<- c() 


acu = matrix(0,11,10)
err = matrix(0,11,10)
k = 0

for(sig in seq(from = 0, to = 1, by = 0.1)){
  k = k+1
  l = 0
  for(c in seq(from = 1, to = 10, length.out = 10)){
   l = l+1 
#Começa as interações
    set.seed(0)
    for( i in 1:10){
      #Separar dados de teste e dados de treino
      porcentagemTreino = c()
      porcentagemTeste = c()
      for(j in 1:length(levels)){
        #Seleciona aleatoriamente 80% das amostras e respostas treino de cada tipo
        #Os 30% restantes são para teste do modelo
        dadosClasseN = Glass[Glass$Type == levels[j],]
        sampleTreino = sample.split(dadosClasseN$Type, 0.8)
        porcentagemTreino = rbind(porcentagemTreino, dadosClasseN[sampleTreino,])
        porcentagemTeste = rbind(porcentagemTeste, dadosClasseN[!sampleTreino,])
      }
      
      #Treinamento modelo
      svmTreinamento = ksvm(as.matrix(porcentagemTreino[, 1:9]), 
                            porcentagemTreino$Type, 
                            type = "C-bsvc",
                            kernel = "rbfdot",
                            kpar = list(sigma = sig),  
                            C =c)
      
      #Teste do modelo
      #Classifica amostras
      classesTeste = predict(svmTreinamento, 
                             as.matrix(porcentagemTeste[, 1:9]), 
                             type = "response", 
                             coupler = "minpair")
      
      vetorAcuracia[i] = sum(as.numeric(porcentagemTeste$Type == classesTeste))/length(porcentagemTeste$Type)
      vetorErro[i] = error(svmTreinamento)
    }
    listaRetorno <- list()
    listaRetorno$AcuraciaMedia <-  mean(vetorAcuracia)
    listaRetorno$DesvioPadraoAcuracia <- sd(vetorAcuracia)
    listaRetorno$ErroMedio <- mean(vetorErro)
    acu[k, l] = listaRetorno$AcuraciaMedia
    err[k, l] = listaRetorno$ErroMedio <- mean(vetorErro)
  }
}
#Recolhe os valores
rownames(acu) = as.character(seq(from = 0, to = 1, by = 0.1))
colnames(acu) = as.character(seq(from = 1, to = 10, length.out = 10))
rownames(err) = as.character(seq(from = 0, to = 1, by = 0.1))
colnames(err) = as.character(seq(from = 1, to = 10, length.out = 10))
write.table(acu, "acu80.csv", sep = ";", dec = ",")
write.table(err, "err80.csv", sep = ";", dec = ",")
print(listaRetorno)

  