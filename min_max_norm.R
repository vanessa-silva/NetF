#############################################################
#################### AUXILIARY FUNCTIONS ####################
#############################################################

## Min-Max normalization
normalize <- function(x) {
  if (max(x) == min(x)) {
    return(x) 
  }
  
  return ((x - min(x)) / (max(x) - min(x)))
}

norm_data <- function(dat) {
  a <- dat
  
  for(i in 1:ncol(dat))
    a[, i] <- normalize(dat[, i])
  
  return(a)
}