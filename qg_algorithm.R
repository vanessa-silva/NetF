#############################################################
################### TIME SERIES MAPPINGS ####################
###################   QUANTILE GRAPHS  ####################
#############################################################


#######################################################
#### Quantile Graph Algorithm

## Quantile Graph (with/without Markov property)
#  by default QG is without Markov property.
#  Implementation based on sample quantile method, which uses 
#  a scheme of linear interpolation of the empirical 
#  distribution function .
QG  <- function(ts, length, q, is_Markov = FALSE) {
  gx <- array(0, dim = c(q, q))
  quantis <- c()
  
  for(i in 1:q)
    quantis <- c(quantis, i/q)
  Quantis_l <- quantile(ts, quantis, type = 4)
  
  for(i in 1:(length-1)) {
    from_node <- which(Quantis_l >= ts[i])[1]
    to_node <- which(Quantis_l >= ts[i+1])[1]
    gx[from_node, to_node] <- gx[from_node, to_node] + 1 
  }
  
  if(is_Markov) {
    for(i in 1:q) {
      total <- sum(gx[i,])
      for(j in 1:q) {
        if (gx[i, j] != 0)
          gx[i, j] <- gx[i, j]/total
      }
    }
  }
  
  return(graph_from_adjacency_matrix(gx, 
                                     mode = "directed", 
                                     weighted = TRUE))
}