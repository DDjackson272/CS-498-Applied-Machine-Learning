library(caret)
library(e1071)
data <- read.table("pima-indians-diabetes.csv",sep = ',')
colnames(data) <- c("feat_a","feat_b","feat_c","feat_d","feat_e","feat_f","feat_g","feat_h","res")

start <- 1
end <- round(nrow(data)/10)
total_acc <- 0
for (i in 1:10){
  eva_data = data[start:end,]
  ind <- createDataPartition(eva_data$res, times=1, p=0.8, list=F)
  train_data = eva_data[ind,]
  test_data = eva_data[-ind,]
  model <- naiveBayes(res~., data=train_data)
  pred <- predict(model, newdata=test_data)
  nb_table <- table(actual=test_data$res, predict=pred)
  ratio <- sum(diag(nb_table))/sum(nb_table)
  
  print(nb_table)
  print(ratio)
  
  total_acc <- total_acc + ratio
  
  start <- start + round(nrow(data)/10)
  end <- end + round(nrow(data)/10)
  if(end > nrow(data))
    end <- nrow(data)
}

print(total_acc/10)

