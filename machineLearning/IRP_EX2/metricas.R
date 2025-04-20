metricaManhattan <- function(x_i,x_j)
#calcual a distância baseada na metrica de manhattan
{
  return(sum(abs(x_i - x_j)))
}

metricaEuclidiana <- function(x_i,x_j)
#Calcula a distância pela métrica euclidiana
{
  return((sum(abs(x_i - x_j)^2))^(1/2))
}

metricaMinsk <- function(x_i,x_j)
#Calcula a distância pela métrica de minskowski com p = 5
{
  return((sum(abs(x_i - x_j)^5))^(1/5))
}

metricaCheby <- function(x_i,x_j)
  #Calcula a distância pela métrica de Chebyshev
{
  return(max(abs(x_i - x_j)))
}
