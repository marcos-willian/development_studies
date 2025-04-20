
rm(list = ls())

source("bayesClassificator.R")
library(caTools) #Função sample.split

#Carrega dados
heart <- read.csv( "heart.dat", sep = " ", header = FALSE)
heart = heart[complete.cases(heart),]


#Prepara dados
heartDados = heart[, -14]
heartClasses = as.factor(heart[ , 14])


heartTreino = list()
heartTeste = list()
porcentagemTreino = 0.9 #essa porcentagem será variada para 70 e 20%

set.seed(16)
#seleciona aleatóriamente as porcentagens de cada classe
classe1 = as.factor(heart[ , 14]) == levels(as.factor(heart[ , 14]))[1]
classe2 = as.factor(heart[ , 14]) == levels(as.factor(heart[ , 14]))[2]
sampleTreinoC1 = sample.split(heart[classe1, 14], porcentagemTreino)
sampleTreinoC2 = sample.split(heart[classe2, 14], porcentagemTreino)

#Treino
heartTreino$dados = as.matrix(rbind(heart[classe1, -14][sampleTreinoC1,], heart[classe2, -14][sampleTreinoC2,]))
heartTreino$classe = as.factor(rbind(as.matrix(heart[classe1, 14][sampleTreinoC1]), as.matrix(heart[classe2, 14][sampleTreinoC2])))

#Teste
heartTeste$dados = as.matrix(rbind(heart[classe1, -14][!sampleTreinoC1,], heart[classe2, -14][!sampleTreinoC2,]))
heartTeste$classe = as.factor(rbind(as.matrix(heart[classe1, 14][!sampleTreinoC1]), as.matrix(heart[classe2, 14][!sampleTreinoC2])))

#Realiza o treinamento
bayesTreino = bayesC(heartTreino$dados, heartTreino$classe)


classesTeste = as.factor(bayesTreino$classificar(bayesTreino, heartTeste$dados))
acuracia = sum(as.numeric(heartTeste$classe == classesTeste))/length(heartTeste$classe)

print(acuracia)

