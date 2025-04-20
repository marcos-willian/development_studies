YMLP <-function(xin, modelo){
  
  xin = as.matrix(xin)
  
  N = dim(xin)[1] #Numero de amostras
  n = dim(xin)[2] #Dimensão do problema
  
  if(modelo$pol){
    xin =  cbind(xin, 1)
  }
  
  yhat = matrix(0, ncol = modelo$nOut, nrow = N)
  for(i in 1:N){

    uIN = t(xin[i,])%*%modelo$Z
    H = tanh(uIN)
    if(modelo$pol){
      H = cbind(H,1)
    }
    
    uOUT = H %*% modelo$W
    if(modelo$sig){
      yhat[i,] = tanh(uOUT)
    }else{
      yhat[i,] = uOUT
    }
  }
  
  return(yhat)
}
