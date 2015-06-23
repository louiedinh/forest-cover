clean <- function(data, is_test=FALSE) {
  if(!is_test){
    data$Cover_Type <- as.factor(data$Cover_Type)
  }
  
  data
}