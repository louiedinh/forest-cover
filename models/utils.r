library(caret)
library(cvTools)

cross_validate <- function(data, fitting_fn) {
  # Split the data into folds
  
  n <- nrow(data)
  splits <- 5
  folds <- cvFolds(n, K=splits)
  res <- 1:splits
  
  for(curr in 1:splits) {
    # Hold out some data
    take_idx <- folds$which == curr
    train_idx <- folds$subsets[take_idx]
    test_idx <- folds$subsets[!take_idx]
    cv_test <- data[test_idx,]
    cv_train <- data[train_idx,]
    
    # Train it
    #fit <- fitting_fn(cv_train)
    # Get some predictions
    #predictions <- predict(fit, cv_test)
    # Calculate the score
    predictions <- rep(cv_test$Cover_Type[1], nrow(cv_test))
    cm <- confusionMatrix(predictions, cv_test$Cover_Type)
    score <- cm$overall["Accuracy"]
    res[curr] <- score
  }
  
  mean(res)
}

cv_res <- cross_validate(train, FALSE)
print("CV Accuracies:")
print(cv_res)
print("Average Accuracy:")
print(mean(cv_res))