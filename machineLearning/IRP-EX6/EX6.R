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


seqTau = seq(from = 0.4, to = 0.5, length.out = 10)
numTaus = length(seqTau)
seqSig = seq(from = 0.1, to = 0.3, length.out = 10)
numSig = length(seqSig)
acu = matrix(0,numSig,numTaus)
err = matrix(0,numSig,numTaus)
k = 0

for(sig in seqSig){
  k = k+1
  l = 0
  for(taus in seqTau){
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
      lssvmTreinamento = lssvm(as.matrix(porcentagemTreino[, 1:9]), 
                            porcentagemTreino$Type, 
                            type = "classification",
                            kernel = "rbfdot",
                            kpar = list(sigma = sig),  
                            tau = taus)
      
      #Teste do modelo
      #Classifica amostras
      classesTeste = predict(lssvmTreinamento, 
                             as.matrix(porcentagemTeste[, 1:9]), 
                             type = "response", 
                             coupler = "minpair")
      
      vetorAcuracia[i] = sum(as.numeric(porcentagemTeste$Type == classesTeste))/length(porcentagemTeste$Type)
      vetorErro[i] = error(lssvmTreinamento)
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
rownames(acu) = as.character(seqSig)
colnames(acu) = as.character(seqTau)
rownames(err) = as.character(seqSig)
colnames(err) = as.character(seqTau)
write.table(acu, "acu80fino.csv", sep = ";", dec = ",")
write.table(err, "err80fino.csv", sep = ";", dec = ",")
print(listaRetorno)

  