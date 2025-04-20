rm(list = ls())
library("mlbench")
source("treinaELM.R")
source("ELM.R")

cores = c("blue", "red")
x = seq(-5, 5, length.out = 200)
grid = expand.grid(x, x)
xgrid = cbind(grid$Var1, grid$Var2)

base1 = mlbench.2dnormals(200)
base1$classes = ifelse(base1$classes == 1, 1, -1)

base2 = mlbench.xor(100)
base2$classes = ifelse(base2$classes == 1, 1, -1)

base3 = mlbench.circle(100)
base3$classes = ifelse(base3$classes == 1, 1, -1)

base4 = mlbench.spirals(100,sd = 0.05)
base4$classes = ifelse(base4$classes == 1, 1, -1)

#Problema para base 1
png("IMG/b1-amostras.png")
plot(base1$x, 
     col = cores[ifelse(base1$classes == 1, 1, 2)],
     xlab = "x1",
     ylab = "x2",
     main = "Amostras base 1")
dev.off()

for(p in c(5, 10, 30)){
set.seed(0) #Para efeitos de comparação
modeloELM =  treinaELM(base1$x, base1$classes, p, T)
Y = ELM(xgrid, modeloELM$Z, modeloELM$W, T)

png(paste("IMG/b1-sep-p=", p, ".png",sep = ""))
plot(base1$x, 
     col = cores[ifelse(base1$classes == 1, 1, 2)],
     xlab = "x1",
     ylab = "x2",
     xlim = c(-5, 5),
     ylim = c(-5, 5),
     main = paste("Superficie de separação base 1 - p = ", p, sep = ""))
contour(x, x, 
        matrix(Y, nrow = length(x), ncol = length(x)), 
        add = T, 
        drawlabels = FALSE, 
        nlevels = 1,
        xlim = c(-5, 5),
        ylim = c(-5, 5),
        lwd = 2)
dev.off()
}

#Problema para base 2
png("IMG/b2-amostras.png")
plot(base2$x, 
     col = cores[ifelse(base2$classes == 1, 1, 2)],
     xlab = "x1",
     ylab = "x2",
     main = "Amostras base 2")
dev.off()

for(p in c(5, 10, 30)){
set.seed(0)
modeloELM =  treinaELM(base2$x, base2$classes, p, T)
Y = ELM(xgrid, modeloELM$Z, modeloELM$W, T)

png(paste("IMG/b2-sep-p=", p, ".png",sep = ""))
plot(base2$x, 
     col = cores[ifelse(base2$classes == 1, 1, 2) ],
     xlab = "x1",
     ylab = "x2",
     xlim = c(-1.5, 1.5),
     ylim = c(-1.5, 1.5),
     main = paste("Superficie de separação base 2 - p = ", p, sep = ""))
contour(x, x, 
        matrix(Y, nrow = length(x), ncol = length(x)), 
        add = T, 
        drawlabels = FALSE, 
        nlevels = 1,
        xlim = c(-1.5, 1.5),
        ylim = c(-1.5, 1.5),
        lwd = 2)
dev.off()
}


#Problema para base 3
png("IMG/b3-amostras.png")
plot(base3$x, 
     col = cores[ifelse(base3$classes == 1, 1, 2)],
     xlab = "x1",
     ylab = "x2",
     main = "Amostras base 3")
dev.off()

for(p in c(5, 10, 30)){
  set.seed(0)
  modeloELM =  treinaELM(base3$x, base3$classes, p, T)
  Y = ELM(xgrid, modeloELM$Z, modeloELM$W, T)
  
  png(paste("IMG/b3-sep-p=", p, ".png",sep = ""))
  plot(base3$x, 
       col = cores[ifelse(base3$classes == 1, 1, 2) ],
       xlab = "x1",
       ylab = "x2",
       xlim = c(-1.5, 1.5),
       ylim = c(-1.5, 1.5),
       main = paste("Superficie de separação base 3 - p = ", p, sep = ""))
  contour(x, x, 
          matrix(Y, nrow = length(x), ncol = length(x)), 
          add = T, 
          drawlabels = FALSE, 
          nlevels = 1,
          xlim = c(-1.5, 1.5),
          ylim = c(-1.5, 1.5),
          lwd = 2)
  dev.off()
}

#Problema para base 4
png("IMG/b4-amostras.png")
plot(base4$x, 
     col = cores[ifelse(base4$classes == 1, 1, 2)],
     xlab = "x1",
     ylab = "x2",
     main = "Amostras base 4")
dev.off()

for(p in c(5, 10, 30)){
  set.seed(0)
  modeloELM =  treinaELM(base4$x, base4$classes, p, T)
  Y = ELM(xgrid, modeloELM$Z, modeloELM$W, T)
  
  png(paste("IMG/b4-sep-p=", p, ".png",sep = ""))
  plot(base4$x, 
       col = cores[ifelse(base4$classes == 1, 1, 2) ],
       xlab = "x1",
       ylab = "x2",
       xlim = c(-1.5, 1.5),
       ylim = c(-1.5, 1.5),
       main = paste("Superficie de separação base 4 - p = ", p, sep = ""))
  contour(x, x, 
          matrix(Y, nrow = length(x), ncol = length(x)), 
          add = T, 
          drawlabels = FALSE, 
          nlevels = 1,
          xlim = c(-1.5, 1.5),
          ylim = c(-1.5, 1.5),
          lwd = 2)
  dev.off()
}

