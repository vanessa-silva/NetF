#############################################################
################## Experimental Evaluation ##################
#############################################################

source_dir <- "https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/"

## get names of all datasets 
data_names <- read.table(url(paste0(source_dir, "Data/realts/data_names.txt")))


### auxiliary variables to store results
dataset <- "realts"
missingValues_id <- c(3, 4, 5, 26, 27, 28, 72, 105, 122)

## global table of results
total_datasets <- nrow(data_names) - length(missingValues_id)

table_tt_mean <- data.frame("tsf.ARI" = array(0, total_datasets),
                            "tsf.NMI" = array(0, total_datasets),
                            "tsf.AS" = array(0, total_datasets),
                            "cat.ARI" = array(0, total_datasets),
                            "cat.NMI" = array(0, total_datasets),
                            "cat.AS" = array(0, total_datasets),
                            "Net.ARI" = array(0, total_datasets),
                            "Net.NMI" = array(0, total_datasets),
                            "Net.AS" = array(0, total_datasets),
                            "k" = array(0, total_datasets))
table_tt_mean_2 <- data.frame("tsf.ARI" = array(0, total_datasets),
                              "tsf.NMI" = array(0, total_datasets),
                              "tsf.AS" = array(0, total_datasets),
                              "cat.ARI" = array(0, total_datasets),
                              "cat.NMI" = array(0, total_datasets),
                              "cat.AS" = array(0, total_datasets),
                              "Net.ARI" = array(0, total_datasets),
                              "Net.NMI" = array(0, total_datasets),
                              "Net.AS" = array(0, total_datasets),
                              "k" = array(0, total_datasets))

table_tt_sd <- data.frame("tsf.ARI" = array(0, total_datasets),
                          "tsf.NMI" = array(0, total_datasets),
                          "tsf.AS" = array(0, total_datasets),
                          "cat.ARI" = array(0, total_datasets),
                          "cat.NMI" = array(0, total_datasets),
                          "cat.AS" = array(0, total_datasets),
                          "Net.ARI" = array(0, total_datasets),
                          "Net.NMI" = array(0, total_datasets),
                          "Net.AS" = array(0, total_datasets),
                          "k" = array(0, total_datasets))
table_tt_sd_2 <- data.frame("tsf.ARI" = array(0, total_datasets),
                            "tsf.NMI" = array(0, total_datasets),
                            "tsf.AS" = array(0, total_datasets),
                            "cat.ARI" = array(0, total_datasets),
                            "cat.NMI" = array(0, total_datasets),
                            "cat.AS" = array(0, total_datasets),
                            "Net.ARI" = array(0, total_datasets),
                            "Net.NMI" = array(0, total_datasets),
                            "Net.AS" = array(0, total_datasets),
                            "k" = array(0, total_datasets))

tt_names <- c()
idx_dataset <- 1

## create a seed to the clustering task
set.seed(2020)


#######################################################
#### clustering analysis -- NetF

source("func_clustering.R")

for(i in 1:nrow(data_names)) {
  missingValues_id <- c(3, 4, 5, 26, 27, 28, 72, 105, 122)
  
  if(i %in% missingValues_id)
    next
  
  data_name <- data_names[i,]
  tt_names[idx_dataset] <- data_name
  
  ## auxiliary tables of results
  total_comb <- 3
  
  table_eval_mean <- data.frame("ARI" = array(0, total_comb),
                                "NMI" = array(0, total_comb),
                                "AS" = array(0, total_comb),
                                "k" = array(0, total_comb))
  table_eval_mean_2 <- data.frame("ARI" = array(0, total_comb),
                                  "NMI" = array(0, total_comb),
                                  "AS" = array(0, total_comb),
                                  "k" = array(0, total_comb))
  
  table_eval_sd <- data.frame("ARI" = array(0, total_comb),
                              "NMI" = array(0, total_comb),
                              "AS" = array(0, total_comb),
                              "k" = array(0, total_comb))
  table_eval_sd_2 <- data.frame("ARI" = array(0, total_comb),
                                "NMI" = array(0, total_comb),
                                "AS" = array(0, total_comb),
                                "k" = array(0, total_comb))
  
  rownames(table_eval_mean) <- c("NetF", "tsfeature", "catch22")
  rownames(table_eval_mean_2) <- rownames(table_eval_mean)
  rownames(table_eval_sd) <- rownames(table_eval_mean)
  rownames(table_eval_sd_2) <- rownames(table_eval_mean)
  
  
  #######################################################
  #### clustering analysis -- NetF
  
  ## load features
  load(url(paste0(source_dir, "Metrics/realts/", data_name, "_normetrics_wnvg_realts.RData")))
  load(url(paste0(source_dir, "Metrics/realts/", data_name, "_normetrics_whvg_realts.RData")))
  load(url(paste0(source_dir, "Metrics/realts/", data_name, "_normetrics_50qg_Mkv_realts.RData")))
  
  ## auxiliary variables
  normetrics <- cbind(nm_data_df_WNVG[, -ncol(nm_data_df_WNVG)], 
                      nm_data_df_WHVG[, -ncol(nm_data_df_WHVG)], 
                      nm_data_df_QG)
  colnames(normetrics) <- c("k_WNVG", "d_WNVG", "S_WNVG", "C_WNVG", "Q_WNVG",
                            "k_WHVG", "d_WHVG", "S_WHVG", "C_WHVG", "Q_WHVG",
                            "k_50-QG", "d_50-QG", "S_50-QG", "C_50-QG", "Q_50-QG",
                            "Class")
  nvg <- 1:5
  hvg <- 6:10
  q50 <- 11:15
  k_1 <- length(unique(normetrics$Class))
  k_2 <- k_1
  
  indx_t <- 1
  
  title <- "NetF"
  
  ## experimental analysis of network features
  ### WNVG - WHVG - 50-QG
  mappings <- "NetF"
  idxs <- c(nvg, hvg, q50)
  source("comp_clustering.R")
  
  
  #######################################################
  #### clustering analysis -- tsfeatures
  
  ## load features
  load(url(paste0(source_dir, "Metrics/realts/", data_name, "_normetrics_tsfeature_realts.RData")))
  
  ## auxiliary variables
  nmetrics_Hynd <- cbind(nmetrics_Hynd, classes)
  
  k_1 <- length(unique(nmetrics_Hynd$classes))
  k_2 <- k_1
  
  title <- "tsfeature"
  
  ## experimental analysis of tsfeature 
  mappings <- "tsfeature"
  normetrics <- nmetrics_Hynd
  idxs <- 1:ncol(normetrics)-1
  source("comp_clustering.R")
  
  
  #######################################################
  #### clustering analysis -- Rcatch22
  
  ## load features
  load(url(paste0(source_dir, "Metrics/realts/", data_name, "_normetrics_catch22_realts.RData")))
  
  ## auxiliary variables
  nmetrics_catch22 <- cbind(nmetrics_catch22, classes)
  
  k_1 <- length(unique(nmetrics_catch22$classes))
  k_2 <- k_1
  
  title <- "Rcatch22"
  
  ## experimental analysis of chatch22
  mappings <- "Rcatch22"
  normetrics <- nmetrics_catch22
  idxs <- 1:ncol(normetrics)-1
  source("comp_clustering.R")
  
  
  ###################
  ## joint clustering results
  
  table_tt_mean[idx_dataset, ] <- c(table_eval_mean[2, -4], 
                                    table_eval_mean[3, -4], 
                                    table_eval_mean[1, ])
  table_tt_mean_2[idx_dataset, ] <- c(table_eval_mean_2[2, -4], 
                                      table_eval_mean_2[3, -4], 
                                      table_eval_mean_2[1, ])
  
  table_tt_sd[idx_dataset, ] <- c(table_eval_sd[2, -4], 
                                  table_eval_sd[3, -4], 
                                  table_eval_sd[1, ])
  table_tt_sd_2[idx_dataset, ] <- c(table_eval_sd_2[2, -4], 
                                    table_eval_sd_2[3, -4], 
                                    table_eval_sd_2[1, ])
  
  
  ## auxiliary variables
  idx_dataset <- idx_dataset + 1
}



#######################################################
#### View results

## for ground truth
table_tt_mean
table_tt_sd

## for best k
table_tt_mean_2
table_tt_sd_2
