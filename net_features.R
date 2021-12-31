#############################################################
##################### NETWORK FEATURES ######################
#############################################################


#######################################################
#### Auxiliary function to compute network features

## Main function to calculate networks metrics .
#  Mapping default is unweighted NVG.
calc_metrics <- function(graph, inst_numb, map_type = "NVG", weight_type = FALSE) {
  # Average Degree
  k <- c()
  # Average Path Length
  d <- c()
  # Number of Communities
  S <- c()
  # Clustering Coefficient
  C <- c()
  # Modularity
  Q <- c()
  
  ## QG
  if(map_type == "QG") {
    for(i in 1:inst_numb) {
      print(i)
      k[i] <- mean(strength(graph[[i]], vids = V(graph[[i]]), mode = "total", loops = TRUE))
      d[i] <- mean_distance(graph[[i]], directed = TRUE)
      clust <- cluster_walktrap(graph[[i]], weights = E(graph[[i]])$weight, merges = TRUE, modularity = TRUE, membership = TRUE)
      S[i] <- max(clust$membership)
      g <- as.undirected(graph[[i]], mode = "collapse")
      C[i] <- transitivity(g, type = "global", weights = NULL, isolates = "zero")
      Q[i] <- modularity(clust) 
    }
  }
  
  ## VG
  else {
    for(i in 1:inst_numb) {
      print(i)
      if(weight_type)
        k[i] <- mean(strength(graph[[i]], vids = V(graph[[i]]), mode = "total", loops = FALSE))
      else
        k[i] <- mean(degree(graph[[i]], v = V(graph[[i]]), mode = "total", loops = FALSE))
      d[i] <- mean_distance(graph[[i]], directed = FALSE)
      if(weight_type)
        clust <- cluster_walktrap(graph[[i]], weights = E(graph[[i]])$weight, merges = TRUE, modularity = TRUE, membership = TRUE)
      else
        clust <- cluster_walktrap(graph[[i]], weights = NULL, merges = TRUE, modularity = TRUE, membership = TRUE)
      S[i] <- max(clust$membership)
      C[i] <- transitivity(graph[[i]], type = "global", weights = NULL, isolates = "zero")
      Q[i] <- modularity(clust)
    }
  }
  
  metrics <- data.frame(k, d, S, C, Q)
  return(metrics)
}
