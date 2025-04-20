#rm(list =  ls())
library("kernlab")
library("mlbench")
library("plot3D")
  
#Variaveis gerais
cores = c("red", "blue", "green")

#Criando 700 amostras de treinamento
espiralTreinamento<-mlbench.spirals(700,1,0.05)

#Criando 200 amostras para teste 
espiralTeste<-mlbench.spirals(200,1,0.06)


#Os dados de treinamento gerados plotados
plot(espiralTreinamento$x, col = cores[espiralTreinamento$classes],
     xlab = "X", ylab = "Y", main = "Dados de treinamento")



#Treinamento modelo
svmTreinamento = ksvm(espiralTreinamento$x, 
                      espiralTreinamento$classes, 
                      type = "C-bsvc",
                      kernel = "rbfdot",
                      kpar = list(sigma = 0.9),#Tanto o sigma e o C foram escolhidos para que minimizem o erro de treinamento  
                      C = 11)#e também maximizem a acuracia para um dado conjunto de treinamento e teste 
                      #Também foi criterio parametros que gerem vetores suporte mais próximos do que se espera olhando a superficie de separação 
#Plota os vetores de suporte
plot(espiralTreinamento$x, col = cores[espiralTreinamento$classes], 
     xlab = "X", ylab = "Y", main = "Vetores de suporte (verde)")
points(espiralTreinamento$x[svmTreinamento@SVindex,], col = "green")


#Plota superficie de decisão
n = 10000
xGrid = seq(from = -1, to = 1, length = n)
grid = expand.grid(X1 = xGrid, X2 = xGrid)
decisionSurface = matrix(as.numeric(predict(svmTreinamento, grid, type = "response")), n, n)
plot(espiralTreinamento$x, col = cores[espiralTreinamento$classes],
     xlab = "X", ylab = "Y", main = "Contorno de separação das classes")
contour(xGrid, xGrid, decisionSurface, add = TRUE, drawlabels = FALSE)

#Plota superficie de separação
# persp3D(xGrid, xGrid, decisionSurface,
#         counter=T,
#         theta = 55,
#         phi = 30,
#         r = 40,
#         d = 0.1,
#         expand = 0.5,
#         ltheta = 90,
#         lphi = 180,
#         shade = 0.4,
#         ticktype = "detailed",
#         nticks=3,
#         main = "Superfície de separação")

#Teste do modelo
#Plotando os dados de teste
plot(espiralTeste$x, xlab = "X", ylab = "Y", main = "Dados de teste")
#Classifica amostras
classesTeste = predict(svmTreinamento, espiralTeste$x, type = "response", coupler = "minpair")
#Plota o resultado da classificação
plot(espiralTeste$x,
     col = cores[classesTeste],
     xlab = "X",
     ylab = "Y",
     main = "Dados de teste classificados")
contour(xGrid, xGrid, decisionSurface, add = TRUE, drawlabels = FALSE)
acuracia = 1 - (t(as.numeric(espiralTeste$classes) - as.numeric(classesTeste)) %*% (as.numeric(espiralTeste$classes) - as.numeric(classesTeste)))/length(espiralTeste$classes)

