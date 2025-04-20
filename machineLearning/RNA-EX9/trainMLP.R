trainMLP <-function(xin, yin, numN, maxIt, tol, pol = FALSE, sig = FALSE, passo = 0.01){
  #xin = dados de entrada 
  #yin =  dados de saída esperados
  #numN =  número de neurônios na camada escondida
  #maxIt =  número máximo de iterações
  #tol =  tolerância do treinamento
  #pol = Se true é acrescentado o número de polarização
  #sig = Se true a função de saída é sigmoidal
  #passo = passo de treinamento
  sech2 <- function(x){
    return(((2/(exp(x)+exp(-x)))*(2/(exp(x)+exp(-x)))))
  }
  
  xin = as.matrix(xin)
  yin = as.matrix(yin)
  
  N = dim(xin)[1] #Numero de amostras
  n = dim(xin)[2] #Dimensão do problema
  nOut = dim(yin)[2]
  
  if(pol){
    xin =  cbind(xin, 1)
    Z = matrix(runif(numN*(n+1))-0.5,
               ncol = numN,
               nrow = (n + 1),
               byrow = T)
    
    W = matrix(runif(nOut*(numN + 1))-0.5,
               ncol = nOut,
               nrow = (numN + 1),
               byrow = T)
    n = n + 1
  }else{
    Z = matrix(runif(numN*n)-0.5,
               ncol = numN,
               nrow = n,
               byrow = T)
    
    W = matrix(runif(nOut*numN)-0.5,
               ncol = nOut,
               nrow = numN,
               byrow = T)
    
  }
  
  
  numIt = 0
  errIt = tol + 1
  errTrain = matrix(nrow = maxIt, ncol = 1)
  
  while((numIt < maxIt) && (errIt > tol)){
    errAux = 0
    iRand = sample(N)
    for(i in 1:N){
      xRand = xin[iRand[i],]
      yRand = yin[iRand[i],]
      
      uIN = t(xRand)%*%Z
      H = tanh(uIN)
      if(pol){
        H = cbind(H,1)
      }
      
      uOUT = H %*% W
      if(sig){
        yhat = tanh(uOUT)
      }else{
        yhat = uOUT
      }
      
      err = yRand - yhat
      if(sig){
        dOut = err*(sech2(uOUT)) #Produto de elementos 
      }else{
        dOut = err
      }
      if(pol){
        errH = dOut %*% t(W[-n,])
      }else{
        errH = dOut %*% t(W)
      }
      dH = errH*sech2(uIN)
      
      W = W + passo*(t(H) %*% dOut)
      Z = Z + passo*(xRand %*% dH)

      errAux = errAux + (err %*% t(err))
    }
    numIt = 1 + numIt
    errIt = errAux/N
    errTrain[numIt] = errIt
  }
  return(list(Z = Z, 
              W = W, 
              errTrain = errTrain, 
              numIt = numIt,
              nOut = nOut,
              pol = pol,
              sig = sig))
  
}

