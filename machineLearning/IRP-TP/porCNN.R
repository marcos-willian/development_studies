rm(list = ls())
library(keras)
library(caret)

# Carrega a base de dados
dataTrain <- read.csv(file = "trainReduzido.csv", header = TRUE, sep = ",")
y <- dataTrain[,2]
x <- dataTrain[,3:786]

# Normaliza matriz de entrada
x <- x / 255
x <- data.matrix(x)

# PCA
trans <- prcomp(x)
PCA <- predict(trans, x)
x <- PCA[,(1:100)]

# Cross validation
flds <- createFolds(y, k = 15, list = TRUE, returnTrain = TRUE)
accuracy_vec <- matrix(nrow = 15, ncol = 1)

# Testa para todos os folds
for (k in 1:15)
{
  # Selecionar amostras de teste e treinamento
  x_train <- x[flds[[k]], ]
  y_train <- y[flds[[k]]]
  x_test <- x[-flds[[k]], ]
  y_test <- y[-flds[[k]]]
  
  # Transforma labels em one hot encoding
  y_train <- to_categorical(y_train, 10)
  y_test <- to_categorical(y_test, 10)
  
  # Constrói o modelo
  model <- keras_model_sequential() 
  model %>% 
    layer_dense(units = 256, activation = 'relu', input_shape = c(100)) %>% 
    layer_dropout(rate = 0.4) %>% 
    layer_dense(units = 128, activation = 'relu') %>%
    layer_dropout(rate = 0.3) %>%
    layer_dense(units = 10, activation = 'softmax')
  
  model %>% compile(
    loss = 'categorical_crossentropy',
    optimizer = optimizer_rmsprop(),
    metrics = c('accuracy')
  )
  
  history <- model %>% fit(
    x_train, y_train, 
    epochs = 30, batch_size = 128,
    verbose = 2, validation_split = 0.2
  )
  
  # Avalia o modelo para o conjunto de treinamento
  model %>% evaluate(x_train, y_train)
  
  # Avalia o modelo para o conjunto de teste
  accuracy_vec[k] <- (model %>% evaluate(x_test, y_test))[[2]]
}  

# Validação
dataValidation <- read.csv(file = "validacao.csv", header = TRUE, sep = ",")
x <- dataValidation[,2:785]

# Vê imagem
xin <- x[2367, ]
  
im <- matrix(nrow = 28, ncol = 28)
j <- 1
for(i in 28:1){
  im[,i] <- as.numeric(xin[(j:(j+27))])
  j <- j+28
}  

image(x = 1:28, 
      y = 1:28, 
      z = im, 
      col=gray((0:255)/255))


# Normaliza matriz de entrada
x <- x / 255
x <- data.matrix(x)

# PCA
PCA <- predict(trans, x)
x <- PCA[,(1:100)]
yhat <- model %>% predict(x) %>% k_argmax()

# Saida
df <- data.frame(ImageId = c(1:dim(yhat)), Label = as.matrix(yhat))
write.csv(df,"output.csv", row.names = FALSE)
