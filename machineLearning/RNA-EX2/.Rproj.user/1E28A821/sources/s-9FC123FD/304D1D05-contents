rm(list = ls())
library('corpcor')

funcGeradora <- function(xin){
  return(0.5*xin^2 + 3*xin + 10)
}

xgrid = seq(from = -15, to = 10, by = 0.1)
NumAmos = 100 
X = runif(n = NumAmos, min = -15, max = 10)
Y = funcGeradora(X) + rnorm(length((X)), mean = 0, sd = 4)

for(p in 1:8){
  H = c(1);
  Hgrid = c(1);
  for(i in 1:p){
    H = cbind(X^i, H);
    Hgrid = cbind(xgrid^i, Hgrid);
  }
  w = pseudoinverse(H) %*% Y;
  
  png(paste("IMG/100-",p,".png",sep = ""))
  plot(X, Y, pch = 19, col = "black", new = T, main = paste("(100 amostras) Aproximação com grau ", p))
  lines(xgrid, funcGeradora(xgrid), col = "blue", lwd = 2)
  lines(xgrid, Hgrid %*% w, col = "red", lwd = 2)
  legend(x = "top",
         y = "center",
         legend = c("Amostras", "Função geradora", "Modelo"),
         col = c("black", "blue", "red"),
         pch = c(19, NA, NA),
         lty = c(NA, 1, 1),
         lwd = 3, 
         bty = "n")
  dev.off()
}

