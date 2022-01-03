#############################################################
########### MAIN PROCEDURE FOR CLUSTERING ANALYSIS ##########
#############################################################


## auxiliary variables
n_reps <- 10
data <- normetrics[, c(idxs, ncol(normetrics))]


## look for NA values
na <- c()
for(nn in 1:(ncol(data)-1)){
  if(sd(data[, nn]) == 0)
    na <- c(na, nn)
}
if(length(na) != 0)
  data <- data[, -na]         ## remove columns (features) with NA values


## PCA analysis
pca_res <- comp_pca(data[, -ncol(data)])
pca <- pca_res$pca
pcaplots <- plots_pca(pca, as.factor(data[, ncol(data)]), pca_res$n_components)


## clustering analysis

### for ground truth
clusters_1 <- comp_clusters(data, data.frame(pca$x[, 1:pca_res$n_components]), 
                            k_1, as.factor(data[, ncol(data)]))
clustersplots_1 <- plots_clusters(data[, -ncol(data)], 
                                  as.factor(data[, ncol(data)]),
                                  clusters_1$cluster_fit)

aux_ari <- c()
aux_nmi_sqrt <- c()
aux_sil <- c()
for(j in 1:n_reps) {
  clusters <- comp_clusters(data, data.frame(pca$x[, 1:pca_res$n_components]), 
                            k_1, as.factor(data[, ncol(data)]))
  aux_ari[j] <- clusters$ari
  aux_nmi_sqrt[j] <- clusters$nmi.sqrt
  aux_sil[j] <- mean(clusters$silhouette[, 3])
}
table_eval_mean[indx_t, ] <- c(round(mean(aux_ari), 2),
                               round(mean(aux_nmi_sqrt), 2),
                               round(mean(aux_sil), 2),
                               k_1)
table_eval_sd[indx_t, ] <- c(round(sd(aux_ari), 2),
                             round(sd(aux_nmi_sqrt), 2),
                             round(sd(aux_sil), 2),
                             k_1)

### for best number of clusters found
best_k <- clust_det(data.frame(pca$x[, 1:pca_res$n_components]), data, title)
k_2 <- which(best_k$silhouette == max(best_k$silhouette))[1]

clusters_2 <- comp_clusters(data, data.frame(pca$x[, 1:pca_res$n_components]), 
                            k_2, as.factor(data[, ncol(data)]))
clustersplots_2 <- plots_clusters(data[, -ncol(data)],
                                  as.factor(data[, ncol(data)]),
                                  clusters_2$cluster_fit)

aux_ari_2 <- c()
aux_nmi_sqrt_2 <- c()
aux_sil_2 <- c()
for(j in 1:n_reps) {
  clusters <- comp_clusters(data, data.frame(pca$x[, 1:pca_res$n_components]), 
                            k_2, as.factor(data[, ncol(data)]))
  aux_ari_2[j] <- clusters$ari
  aux_nmi_sqrt_2[j] <- clusters$nmi.sqrt
  aux_sil_2[j] <- mean(clusters$silhouette[, 3])
}
table_eval_mean_2[indx_t, ] <- c(round(mean(aux_ari_2), 2),
                                 round(mean(aux_nmi_sqrt_2), 2),
                                 round(mean(aux_sil_2), 2),
                                 k_2)
table_eval_sd_2[indx_t, ] <- c(round(sd(aux_ari_2), 2),
                               round(sd(aux_nmi_sqrt_2), 2),
                               round(sd(aux_sil_2), 2),
                               k_2)


indx_t <- indx_t + 1