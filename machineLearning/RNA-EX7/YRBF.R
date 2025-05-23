YRBF = function(xin, modRBF){
  pdfnvar<-function(x, m, K, n){
    if(n == 1){
      r = sqrt(as.numeric(K))
      px = (1/(sqrt(2*pi*r*r)))*exp(-0.5 * ((x - m)/(r))^2)
    }
    else{
      px = ((1/(sqrt((2*pi)^n * (det(K)))))*exp(-0.5*(t(x-m) %*% (solve(K)) %*% (x-m))))
    }
    return(px)
  }
  
  xin = as.matrix(xin)
  
  N = dim(xin)[1] #Numero de amostras
  n = dim(xin)[2] #Dimensão do problema
  
  m =  as.matrix(modRBF[[1]])
  covlist =  modRBF[[2]]
  p = length(covlist)
  W =  modRBF[[3]]
  
  xin =  as.matrix(xin)
  
  H =  matrix(nrow =  N, ncol = p)
  #calcula matrix H
  for( j in 1:N ){
    for( i in 1:p ){
      mi = m[i,]
      #covi =  covlist[i]
      covi = matrix(unlist(covlist[i]), ncol = n, byrow = T) + 0.001 * diag(n)
      H[j, i] = pdfnvar(xin[j, ],  mi, covi, n)
    }
  }
  Haug = cbind(1, H)
  Yhat =  Haug %*% W
  return(Yhat)
}