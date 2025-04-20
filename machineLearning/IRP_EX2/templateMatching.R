
templateMatching <- function(modelo, objPesquisa)
#Realiza o metodo do template matching procurando uma figura em outra 
#modelo: template que queremos encontrar na figura
#objPesquisa: figura no qual vamos procurar o modelo
#Retorno: A matriz distancia da métrica (ela é menor que a figura)
{
  dimObj = dim(objPesquisa)
  dimModelo = dim(modelo)
  
  #Limites de procura
  numLinhas = (dimObj[1] - dimModelo[1])
  numColunas = (dimObj[2] - dimModelo[2])
  
  
  matrizDista= matrix(0,numLinhas,numColunas)
  for(linha in 1:numLinhas){
    for(coluna in 1:numColunas){
      matrizDista[linha,coluna] = 
        metricaCheby(objPesquisa[linha:(linha+dimModelo[1] - 1),coluna:(coluna+dimModelo[2] - 1)],modelo)
    }
  }
  posicaoPlaca = which((matrizDista == min(matrizDista)),arr.ind = TRUE)
  posicaoPlaca = dimModelo/2 + posicaoPlaca
  resultado = list(matrizDista, posicaoPlaca)
  return(resultado)
}

#demais funções
identificaPlaca <- function(imagem, dimIdentificado ,posicao){
  #Linhas superior e inferior
  for(linha in (posicao[1] - dimIdentificado[1]/2):(posicao[1]+dimIdentificado[1]/2)){
    imagem[linha, (posicao[2]+dimIdentificado[2]/2):(posicao[2]+dimIdentificado[2]/2+2)] = 1
    imagem[linha, (posicao[2]-dimIdentificado[2]/2):(posicao[2]-dimIdentificado[2]/2+2)] = 1
  }
  #Linhas laterais
  for(coluna in (posicao[2] - dimIdentificado[2]/2):(posicao[2]+dimIdentificado[2]/2)){
    imagem[(posicao[1]+dimIdentificado[1]/2):(posicao[1]+dimIdentificado[1]/2+2), coluna] = 1
    imagem[(posicao[1]-dimIdentificado[1]/2):(posicao[1]-dimIdentificado[1]/2+2), coluna] = 1
  }
  return(imagem)
}