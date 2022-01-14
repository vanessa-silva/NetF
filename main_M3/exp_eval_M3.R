#############################################################
################## Experimental Evaluation ##################
#############################################################


### auxiliary variables to store results
dataset <- "M3"
data_name <- "m3_type"

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

## create a seed to the clustering task
set.seed(2020)


#######################################################
#### clustering analysis -- NetF

source("func_clustering.R")

## load features
load(url("https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Metrics/M3/normetrics_wnvg_m3.RData"))
load(url("https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Metrics/M3/normetrics_whvg_m3.RData"))
load(url("https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Metrics/M3/normetrics_50qg_Mkv_m3.RData"))

## auxiliary variables
normetrics <- cbind(nm_wnvg_m3, nm_whvg_m3,
                    nm_50qg_m3,
                    m3_type)
colnames(normetrics) <- c("k_WNVG", "d_WNVG", "S_WNVG", "C_WNVG", "Q_WNVG",
                          "k_WHVG", "d_WHVG", "S_WHVG", "C_WHVG", "Q_WHVG",
                          "k_50-QG", "d_50-QG", "S_50-QG", "C_50-QG", "Q_50-QG",
                          "Class")

nvg <- 1:5
hvg <- 6:10
q50 <- 11:15
k_1 <- length(unique(normetrics[, ncol(normetrics)]))
k_2 <- k_1

indx_t <- 1

i <- 1

title <- "NetF"

## experimental analysis of network features
### WNVG - WHVG - 50-QG
mappings <- "NetF"
idxs <- c(nvg, hvg, q50)
source("comp_clustering.R")
pcaplots$pca_plot


#######################################################
#### clustering analysis -- tsfeatures

## load features
load(url("https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Metrics/M3/normetrics_tsfeature_m3.RData"))

## auxiliary variables
nmetrics_Hynd <- cbind(nmetrics_Hynd, m3_type)

k_1 <- length(unique(nmetrics_Hynd$m3_type))
k_2 <- k_1

title <- "tsfeature"

## experimental analysis of Hyndman features from 'tsfeature' package
mappings <- "tsfeature"
normetrics <- nmetrics_Hynd
idxs <- 1:ncol(normetrics)-1
source("comp_clustering.R")
pcaplots$pca_plot


#######################################################
#### clustering analysis -- Rcatch22

## load features
load(url("https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Metrics/M3/normetrics_catch22_m3.RData"))

## auxiliary variables
nmetrics_catch22 <- cbind(nmetrics_catch22, m3_type)

k_1 <- length(unique(nmetrics_catch22$m3_type))
k_2 <- k_1

title <- "Rcatch22"

## experimental analysis of catch22 features from 'Rcatch22' package
mappings <- "Rcatch22"
normetrics <- nmetrics_catch22
idxs <- 1:ncol(normetrics)-1
source("comp_clustering.R")
pcaplots$pca_plot


#######################################################
#### View results

## for ground truth
table_eval_mean
table_eval_sd

## for best k
table_eval_mean_2
table_eval_sd_2
