rm(list = ls())
source("treinaPerceptron.R")
source("perceptron.R")
library('plot3D')
sd = 0.4
numAmostras = 200
gaussiana1 =  matrix(rnorm(numAmostras*2), ncol = 2)*sd + t(matrix(c(2,2), ncol = numAmostras, nrow = 2))
gaussiana2 =  matrix(rnorm(numAmostras*2), ncol = 2)*sd + t(matrix(c(4,4), ncol = numAmostras, nrow = 2))

amostras = rbind(gaussiana1, gaussiana2)

classe = cbind(matrix(0, ncol = 200), matrix(1, ncol = 200))
cores = c('red', 'blue')

png("IMG/1_amostras_in.png")
plot(amostras, col = cores[classe+1], xlim = c(0,6), ylim = c(0,6), xlab = 'x_1', ylab = 'x_2', main = 'Amostras de entrada')
dev.off()

#treina perceptron
retList = treinaPerceptron(amostras, classe, 0.1, 0.01, 100, 1)
w =  retList[[1]]

seq_x1 = seq(0, 6, 0.01)
seq_x2 = seq_x1
M = matrix(nrow = length(seq_x1), ncol = length(seq_x2))

i = 0
for(x1 in seq_x1){
  i = i + 1
  j = 0
  for(x2 in seq_x2){
    j = j + 1
    x = c(x1,x2)
    M[i, j] =  perceptron(x, w, 1)
  }
}

png("IMG/1-contour.png")
plot(amostras, col = cores[classe+1], xlim = c(0,6), ylim = c(0,6), xlab = 'x_1', ylab = 'x_2', main = 'Superfície de separação')
par(new = T)
contour(seq_x1, seq_x2, M, xlim = c(0,6), ylim = c(0,6), xlab = '', ylab = '', labels = '', nlevels = 1, lwd = 2)
dev.off()

png("IMG/1-3d.png")
persp3D(seq_x1, 
        seq_x2, 
        M, 
        counter = T, 
        theta = 55, 
        phi = 30,
        r = 40,
        d = 0.1, 
        expand = 0.5, 
        ltheta = 90, 
        lphi = 180, 
        shade = 0.4,
        ticktype = 'detailed', 
        nticks = 5)
dev.off()

