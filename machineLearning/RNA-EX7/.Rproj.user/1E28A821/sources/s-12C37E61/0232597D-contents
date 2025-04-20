library('corpcor')
treinaRBF <-function(xin, yin, p){
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
  yin = as.matrix(yin)
  
  N = dim(xin)[1] #Numero de amostras
  n = dim(xin)[2] #Dimensão do problema
  
  xClust = kmeans(xin, p)
  
  m = as.matrix(xClust$centers)
  covlist = list()
  for( i in 1:p){
    ici =  which(xClust$cluster == i)
    xci = xin[ici, ]
    if( n == 1){
      covi =  var(xci)
    }else{
      covi = cov(xci)
    }
    covlist[[i]] =  covi
  }
  
  H =  matrix(nrow =  N, ncol = p)
  #calcula matrix H
  for( j in 1:N ){
    for( i in 1:p ){
      mi = m[i,]
     # covi =  matrix(covlist[i])
      covi = matrix(unlist(covlist[i]), ncol = n, byrow = T) + 0.001 * diag(n)
      H[j, i] = pdfnvar(xin[j, ],  mi, covi, n)
    }
  }
  
  Haug = cbind(1, H)
  W =  (pseudoinverse(Haug)) %*% yin
  return(list(centers = m, covariances = covlist, pesos = W, pdfs = H))
}