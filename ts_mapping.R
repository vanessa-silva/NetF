#############################################################
################### TIME SERIES MAPPINGS ####################
#############################################################

#######################################################
#### load time series mapping algorithms

source("vg_algorithm.R")
source("qg_algorithm.R")


#######################################################
#### Auxiliary functions to call respective mapping 
#### algorithm

## Main function to generate all visibility and quantile 
#  graphs. 
#  Function to time series set stored in matrix format.
#  Mapping default is unweighted NVG.
generate_Graphs <- function(timeseries, inst_numb, length, q = 0, map_type = "NVG", weight_type = FALSE, is_Markov = FALSE) {
  graph <- list()
  total_g <- 1
  
  ## (W)NVG
  if(map_type == "NVG") {
    for(i in 1:inst_numb) {
      #print(i)
      graph[[i]] <- NVG(timeseries[, i], length, weight_type)
      total_g <- total_g + 1
    }
  }
  
  ## (W)HVG
  else if(map_type == "HVG") {
    for(i in 1:inst_numb) {
      #print(i)
      graph[[i]] <- HVG(timeseries[, i], length, weight_type)
      total_g <- total_g + 1
    }
  }
  
  ## QG
  else if (map_type == "QG") {
    for(i in 1:inst_numb) {
      #print(i)
      graph[[i]] <- QG(timeseries[, i], length, q, is_Markov)
      total_g <- total_g + 1
    }
  }
  
  else {
    cat("ERROR: no mapping method")
    return()
  }
  
  return(graph)
}



## Main function to generate all visibility and quantile  
#  graphs. 
#  Function to time series set stored in list format.
#  Mapping default is unweighted NVG.
generate_Graphs_list <- function(timeseries, inst_numb, q = 0, map_type = "NVG", weight_type = FALSE, is_Markov = FALSE) {
  graph <- list()
  total_g <- 1
  
  ## (W)NVG
  if(map_type == "NVG") {
    for(i in 1:inst_numb) {
      print(i)
      length <- length(timeseries[[i]])
      graph[[i]] <- NVG(timeseries[[i]], length, weight_type)
      total_g <- total_g + 1
    }
  }
  
  ## (W)HVG
  else if(map_type == "HVG") {
    for(i in 1:inst_numb) {
      print(i)
      length <- length(timeseries[[i]])
      graph[[i]] <- HVG(timeseries[[i]], length, weight_type)
      total_g <- total_g + 1
    }
  }
  
  ## QG
  else if (map_type == "QG") {
    for(i in 1:inst_numb) {
      print(i)
      length <- length(timeseries[[i]])
      graph[[i]] <- QG(timeseries[[i]], length, q, is_Markov)
      total_g <- total_g + 1
    }
  }
  
  else {
    cat("ERROR: no mapping method")
    return()
  }
  
  return(graph)
}
