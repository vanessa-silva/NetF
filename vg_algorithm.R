#############################################################
################### TIME SERIES MAPPINGS ####################
###################   VISIBILITY GRAPHS  ####################
#############################################################


#######################################################
#### Natural Visibility Graph Algorithm

## Auxiliary function to get index of the 
#  maximum value of a time series window.
indexMax <- function(ts, left, right) {
  idx <- left
  val = ts[left]
  
  for(i in (left+1):right) {
    if(ts[i] > val) {
      val = ts[i]
      idx = i
    }
  }
  
  return(idx)
}

## (Weighted) Natural Visibility Graph
#  by default NVG is unweighted.
#  Implementation based on "divide & conquer" algorithm.
NVG  <- function(ts, length, weight_type = FALSE) { 
  g <- data.frame()
  
  ## auxiliar variables
  i <- -1
  y_i <- -10^10
  y_a <- -10^10
  max_slope <- -10^10
  slope <- -10^10
  indx <- c(1, length+1)
  queue_ <- list()                        ## auxiliary queue
  queue_[[1]] <- indx
  left <- indx[1]
  right <- indx[2]
  
  while(length(queue_) != 0) {
    indx <- queue_[[1]]
    queue_[[1]] <- NULL                   ## pop the queue
    left <- indx[1]
    right <- indx[2]
    
    if((left+1) < right) {
      i = indexMax(ts, left, right-1)
      y_i = ts[i]
      
      max_slope = -10^10
      if((i-left) > 0) {
        for(d in 1:(i-left)) {
          y_a = ts[i-d]
          slope = (y_a - y_i)/d
          
          if(slope > max_slope) {         ## add edge to the left
            w = 1/sqrt(d^2+(y_a-y_i)^2)
            
            if(!weight_type)
              g <- rbind(g, c(i, i-d))
            else
              g <- rbind(g, c(i, i-d, w))
            
            max_slope = slope
          }
        }
      }
      
      max_slope = -10^10
      if((right-i-1) > 0) {
        for(d in 1:(right-i-1)) {
          y_a = ts[i+d]
          slope = (y_a - y_i)/d
          
          if(slope > max_slope) {         ## add edge to the right
            w = 1/sqrt(d^2+(y_a-y_i)^2)
            
            if(!weight_type)
              g <- rbind(g, c(i, i+d))
            else
              g <- rbind(g, c(i, i+d, w))
            
            max_slope = slope
          }
        }
      }
      
      indx[1] = left
      indx[2] = i
      queue_[[length(queue_)+1]] <- indx  ## push the queue
      
      indx[1] = i+1
      indx[2] = right
      queue_[[length(queue_)+1]] <- indx  ## push the queue
    }
  }
  
  if(!weight_type)
    names(g)[1:2] <- c("from", "to")
  else
    names(g)[1:3] <- c("from", "to", "weight")
  
  return(graph_from_data_frame(g, directed = FALSE))
}


#######################################################
#### Horizontal Visibiliy Graph Algorithm

## (Weighted) Horizontal Visibility Graph
#  by default HVG is unweighted.
HVG  <- function(ts, length, weight_type = FALSE) {
  g <- data.frame()
  
  for(i in 1:(length-2)) {
    alpha <- 1
    
    # contiguous time points always have visibility
    w <- 1/sqrt(1^2+(ts[i]-ts[i+1])^2)
    g <- rbind(g, c(i, i+1, w))
    
    # other points in the series
    for(j in 2:(length-i)) {
      criterio <- ts[i+alpha]
      p <- ts[i+j]
      
      if(criterio >= ts[i])
        break
      
      else if(criterio < p) {
        w <- 1/sqrt(j^2+(ts[i]-ts[i+j])^2)
        g <- rbind(g, c(i, i+j, w))
        
        alpha <- j
      }
    }
  }
  
  #contiguous time points always have visibility
  w <- 1/sqrt(1^2+(ts[length-1]-ts[length])^2)
  g <- rbind(g, c(length-1, length, w))
  
  if(!weight_type)
    names(g)[1:2] <- c("from", "to")
  else
    names(g)[1:3] <- c("from", "to", "weight")
  
  return(graph_from_data_frame(g, directed = FALSE))
}