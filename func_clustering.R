#############################################################
############# CLUSTERING - AUXILIARY FUNCTIONS ##############
#############################################################

n_reps <- 10


##############################################################
## AUXILIARY FUNCTIONS - PCA
##############################################################

## compute PCA function
comp_pca <- function(data) {
  
  ##calculate PCA
  pca <- prcomp(data, center = TRUE, scale. = FALSE)
  
  #decide number of components
  cum_prop <- summary(pca)$importance[3, ]
  # if(which(cum_prop >= 0.85)[1] == 1)
  #   ncp <- which(cum_prop >= 0.85)[2]
  # else
  #   ncp <- which(cum_prop >= 0.85)[1]
  ncp <- ncol(data)
  
  res <- list("pca" = pca, "impor_components" = cum_prop, "n_components" = ncp)
  return(res)
}

## draw PCA plots
plots_pca <- function(pca, true_classes, ncp) {
  ## draw two-component plot: Biplot of individuals of variables 
  biplot <- fviz_pca_biplot(pca, 
                            palette = c("darkorange4", "darkorange2", 
                                        "blueviolet", "violet", "red", 
                                        "darkblue", "cyan", 
                                        "forestgreen", "yellow2", 
                                        "green", "black",
                                        "aquamarine", "aquamarine4",
                                        "darkslategrey", "deeppink",
                                        "antiquewhite3", "brown1",
                                        "darkgoldenrod1"),
                            geom.ind = "point", 
                            fill.ind = true_classes, 
                            col.ind = "black",
                            pointshape = 21, pointsize = 2,
                            addEllipses = TRUE, 
                            alpha.var ="contrib", col.var = "contrib",
                            gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
                            repel = TRUE,
                            legend.title = list(fill = "Models", 
                                                color = "Contrib", 
                                                alpha = "Contrib")
  )
  
  ## draw contribution of variables
  var <- get_pca_var(pca)
  corrplot <- corrplot(var$contrib[, 1:as.integer(ncp)], is.corr = FALSE, tl.srt = 45)    
  
  ## draw total contribution of PC's
  barplot <- fviz_contrib(pca, choice = "var", axes = 1:as.numeric(ncp), top = 10)
  
  res <- list("pca_plot" = biplot,
              "corrplot" = corrplot,
              "bar_plot" = barplot)
  
  return(res)
}


##############################################################
## AUXILIARY FUNCTIONS - CLUSTERING
##############################################################

## compute KMeans function
comp_clusters <- function(data, data_redim, k, true_classes) {
  
  ## compute k-means
  k.means.fit <- kmeans(data_redim, k, nstart = 50, iter.max = 1000)
  
  ## confusion matrix
  conf_matrix <- table(true_classes, k.means.fit$cluster)
  
  ## compute silhouette metric  
  sill <- silhouette(k.means.fit$cluster, dist(data_redim))
  
  ## get adjusted Rand index
  ari <- ARI(k.means.fit$cluster, true_classes)
  
  ## get normalized mutual information 
  nmi_sqrt <- NMI(k.means.fit$cluster, true_classes, variant = "sqrt")
  
  res <- list("cluster_fit" = k.means.fit,
              "confusion_mtx" = conf_matrix,
              "silhouette" = sill,
              "ari" = ari,
              "nmi.sqrt" = nmi_sqrt)
  
  return(res)
}

## draw jitterplot of the clusters
plots_clusters <- function(data, true_classes, cluster_fit) {
  jitterplot <- ggplot(data, 
                       aes(x = true_classes, 
                           y = cluster_fit$cluster, 
                           fill = true_classes)) +
    geom_boxplot(fill = "white") +
    geom_jitter(aes(color = true_classes), alpha = 0.4) +
    scale_x_discrete(name = "Model") +
    scale_y_continuous(name = "Cluster") +
    ggtitle("Cluster Analysis") +
    scale_color_manual(values = c("darkorange4", "darkorange2", 
                                  "blueviolet", "violet", "red", 
                                  "darkblue", "cyan", 
                                  "forestgreen", "yellow2", 
                                  "green", "black",
                                  "aquamarine", "aquamarine4",
                                  "darkslategrey", "deeppink",
                                  "antiquewhite3", "brown1",
                                  "darkgoldenrod1")) +
    theme_minimal() +
    theme(axis.text.x = element_text(size = 9, angle = 45), 
          plot.title = element_text(hjust = 0.5), 
          legend.position="none")
  
  return(jitterplot)
}


##############################################################
## AUXILIARY FUNCTIONS - FIND Best k (number of clusters)
##############################################################

## aux function - distribution
boxplot_dd <- function(dd) {
  df <- data.frame("Freq" = dd[, 1], "k" = 2)
  
  for(i in 2:ncol(dd)) {
    df <- rbind(df, data.frame("Freq" = dd[, i], "k" = i+1))
  }
  
  df$k <- as.factor(df$k)
  
  return(df)
}

## determinate best number of clusters function
clust_det <- function(pca_data, data, title) {
  true_classes <- as.factor(data[, ncol(data)]) 
  
  ari <- (nrow(pca_data) - 1)*sum(apply(pca_data, 2, var))
  nmi_sqrt <- (nrow(pca_data) - 1)*sum(apply(pca_data, 2, var))
  sil <- (nrow(pca_data) - 1)*sum(apply(pca_data, 2, var))
  
  ari[1] <- 0
  nmi_sqrt[1] <- 0
  sil[1] <- 0
  
  max_k <- (length(unique(true_classes))+10)
  for (i in 2:max_k) {
    aux_ari <- c()
    aux_nmi_sqrt <- c()
    aux_sil <- c()
    for(j in 1:n_reps) {
      k.means.fit <- kmeans(pca_data, centers = i, nstart = 50, iter.max = 1000)
      
      aux_ari[j] <- ARI(k.means.fit$cluster, true_classes)
      aux_nmi_sqrt[j] <- NMI(k.means.fit$cluster, true_classes)
      aux_sil[j] <- mean(silhouette(k.means.fit$cluster, dist(pca_data))[,3])
    }
    ari[i] <- mean(aux_ari)
    nmi_sqrt[i] <- mean(aux_nmi_sqrt)
    sil[i] <- mean(aux_sil)
    
    if(i == 2 ) {
      e_metrics_ari <- data.frame(aux_ari)
      e_metrics_nmi_sqrt <- data.frame(aux_nmi_sqrt)
      e_metrics_sil <- data.frame(aux_sil)
    }
    else {
      e_metrics_ari <- cbind(e_metrics_ari, aux_ari)
      e_metrics_nmi_sqrt <- cbind(e_metrics_nmi_sqrt, aux_nmi_sqrt)
      e_metrics_sil <- cbind(e_metrics_sil, aux_sil)
    }
  }
  
  par(mfrow = c(3, 1)) 
  plot(2:max_k, ari[2:max_k], type="b", 
       xlab="Number of Clusters", ylab="Adj Rand Index")
  plot(2:max_k, nmi_sqrt[2:max_k], type="b", 
       xlab="Number of Clusters", ylab="Nor Mutual Information sqrt")
  plot(2:max_k, sil[2:max_k], type="b", 
       xlab="Number of Clusters", ylab="Average Silhouette")
  par(mfrow = c(1, 1)) 
  
  g_ari <- ggplot(aes(y = Freq, x = k), data = boxplot_dd(e_metrics_ari)) + 
    geom_boxplot() + 
    scale_y_continuous(name = "Adj. Rand Index") +
    scale_x_discrete(name = "Number of Clusters (k)") +
    ggtitle(title) +
    theme_minimal() +
    theme(axis.text.x = element_text(size = 14, face="bold"), 
          axis.text.y = element_text(size = 14, face="bold"), 
          axis.title.x = element_text(size = 16, face="bold"), 
          axis.title.y = element_text(size = 16, face="bold"), 
          legend.position="none",
          plot.title = element_text(size = 16, face = "bold.italic"),
          panel.background = element_rect(fill = "white",
                                          colour = "grey80",
                                          size = .5, linetype = "solid"))
  g_nmi_sqrt <- ggplot(aes(y = Freq, x = k), data = boxplot_dd(e_metrics_nmi_sqrt)) + 
    geom_boxplot() +
    scale_y_continuous(name = "Norm. Mutual Information") +
    scale_x_discrete(name = "Number of Clusters (k)") +
    ggtitle(title) +
    theme_minimal() +
    theme(axis.text.x = element_text(size = 14, face="bold"), 
          axis.text.y = element_text(size = 14, face="bold"), 
          axis.title.x = element_text(size = 16, face="bold"), 
          axis.title.y = element_text(size = 16, face="bold"), 
          legend.position="none",
          plot.title = element_text(size = 16, face = "bold.italic"),
          panel.background = element_rect(fill = "white",
                                          colour = "grey80",
                                          size = .5, linetype = "solid"))
  g_sil <- ggplot(aes(y = Freq, x = k), data = boxplot_dd(e_metrics_sil)) + 
    geom_boxplot() + 
    scale_y_continuous(name = "Average Silhouette") +
    scale_x_discrete(name = "Number of Clusters (k)") +
    ggtitle(title) +
    theme_minimal() +
    theme(axis.text.x = element_text(size = 14, face="bold"), 
          axis.text.y = element_text(size = 14, face="bold"), 
          axis.title.x = element_text(size = 16, face="bold"), 
          axis.title.y = element_text(size = 16, face="bold"), 
          legend.position="none",
          plot.title = element_text(size = 16, face = "bold.italic"),
          panel.background = element_rect(fill = "white",
                                          colour = "grey80",
                                          size = .5, linetype = "solid"))
  
  res <- list("silhouette" = sil,
              "ari" = ari,
              "nmi.sqrt" = nmi_sqrt,
              "plot.ari" = g_ari,
              "plot.nmi" = g_nmi_sqrt,
              "plot.sil" = g_sil)
  
  return(res)
}
