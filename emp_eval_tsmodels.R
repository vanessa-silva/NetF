#############################################################
################### Empirical Evaluation ####################
#############################################################


### auxiliary variables to store results
dataset <- "tsmodels"
data_name <- "tsmodels"

total_comb <- 7 + 2 + 3

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

rownames(table_eval_mean) <- c("WNVG", "WHVG", "50-QG",                   ## 1 mapping type
                               "WNVG-WHVG", "WNVG-50QG", "WHVG-50QG",     ## combining 2 types of mappings
                               "NetF",                                    ## 3 mapping types 
                               "tsfeature", "catch22",                    ## other approaches
                               "NetF+tsfeature", "NetF+catch22",          ## combining 2 approaches
                               "NetF+tsfeature+catch22")                  ## 3 approaches
rownames(table_eval_mean_2) <- rownames(table_eval_mean)
rownames(table_eval_sd) <- rownames(table_eval_mean)
rownames(table_eval_sd_2) <- rownames(table_eval_mean)

## create a seed to the clustering task
set.seed(2020)


#######################################################
#### clustering analysis -- NetF

source("func_clustering.R")

## load features
load(url("https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Metrics/tsmodels/normetrics_wnvg.RData"))
load(url("https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Metrics/tsmodels/normetrics_whvg.RData"))
load(url("https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Metrics/tsmodels/normetrics_50qg_Mkv.RData"))

normetrics <- cbind(nm_wnvg, nm_whvg, nm_50qg)
colnames(normetrics) <- c("k_WNVG", "d_WNVG", "S_WNVG", "C_WNVG", "Q_WNVG",
                          "k_WHVG", "d_WHVG", "S_WHVG", "C_WHVG", "Q_WHVG",
                          "k_QG", "d_QG", "S_QG", "C_QG", "Q_QG")

## auxiliary variables
models <- c(rep("WN", 100), 
            rep("AR(1)-0.5", 100), rep("AR(1)0.5", 100),rep("AR(2)", 100),
            rep("ARIMA", 100), rep("ARFIMA", 100),
            rep("SETAR", 100), rep("HMM", 100), 
            rep("GARCH", 100), rep("EGARCH", 100), rep("INAR", 100))

normetrics <- cbind(normetrics, models)
colnames(normetrics) <- c("k_WNVG", "d_WNVG", "S_WNVG", "C_WNVG", "Q_WNVG",
                          "k_WHVG", "d_WHVG", "S_WHVG", "C_WHVG", "Q_WHVG",
                          "k_QG", "d_QG", "S_QG", "C_QG", "Q_QG",
                          "Model")

nvg <- 1:5
hvg <- 6:10
q50 <- 11:15
k_1 <- length(unique(normetrics$Model))
k_2 <- k_1

indx_t <- 1

title <- "NetF"


## experimental analysis of mapping methods combinations

### WNVG
mappings <- "WNVG"
idxs <- nvg
source("comp_clustering.R")
pcaplots$pca_plot

### WHVG
mappings <- "WHVG"
idxs <- hvg
source("comp_clustering.R")
pcaplots$pca_plot

### 50-QG
mappings <- "50-QG"
idxs <- q50
source("comp_clustering.R")
pcaplots$pca_plot

### WNVG - WHVG
mappings <- "WNVG - WHVG"
idxs <- c(nvg, hvg)
source("comp_clustering.R")
pcaplots$pca_plot

### WNVG - 50-QG
mappings <- "WNVG - 50-QG"
idxs <- c(nvg, q50)
source("comp_clustering.R")
pcaplots$pca_plot

### WHVG - 50-QG
mappings <- "WHVG - 50-QG"
idxs <- c(hvg, q50)
source("comp_clustering.R")
pcaplots$pca_plot

### WNVG - WHVG - 50-QG
mappings <- "WNVG - WHVG - 50-QG"
idxs <- c(nvg, hvg, q50)
source("comp_clustering.R")
pcaplots$pca_plot


#######################################################
#### clustering analysis -- tsfeatures

## load features
load(url("https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Metrics/tsmodels/normetrics_tsfeature.RData"))

## auxiliary variables
models <- c(rep("WN", 100), 
            rep("AR(1)-0.5", 100), rep("AR(1)0.5", 100),rep("AR(2)", 100),
            rep("ARIMA", 100), rep("ARFIMA", 100),
            rep("SETAR", 100), rep("HMM", 100), 
            rep("GARCH", 100), rep("EGARCH", 100), rep("INAR", 100))
nmetrics_Hynd <- cbind(nmetrics_Hynd, models)

k_1 <- length(unique(nmetrics_Hynd$models))
k_2 <- k_1

title <- "tsfeature"


## experimental analysis of tsfeature 
mappings <- "tsfeature"
normetrics <- nmetrics_Hynd
idxs <- 1:ncol(normetrics)-1
source("comp_clustering.R")
pcaplots$pca_plot


#######################################################
#### clustering analysis -- Rcatch22

## load features
load(url("https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Metrics/tsmodels/normetrics_catch22.RData"))

## auxiliary variables
models <- c(rep("WN", 100), 
            rep("AR(1)-0.5", 100), rep("AR(1)0.5", 100),rep("AR(2)", 100),
            rep("ARIMA", 100), rep("ARFIMA", 100),
            rep("SETAR", 100), rep("HMM", 100), 
            rep("GARCH", 100), rep("EGARCH", 100), rep("INAR", 100))
nmetrics_catch22 <- cbind(nmetrics_catch22, models)

k_1 <- length(unique(nmetrics_catch22$models))
k_2 <- k_1

title <- "Rcatch22"


## experimental analysis of chatch22
mappings <- "Rcatch22"
normetrics <- nmetrics_catch22
idxs <- 1:ncol(normetrics)-1
source("comp_clustering.R")
pcaplots$pca_plot


#######################################################
#### clustering analysis -- combination of 3

## load features
load(url("https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Metrics/tsmodels/normetrics_wnvg.RData"))
load(url("https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Metrics/tsmodels/normetrics_whvg.RData"))
load(url("https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Metrics/tsmodels/normetrics_50qg_Mkv.RData"))
load(url("https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Metrics/tsmodels/normetrics_tsfeature.RData"))
load(url("https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Metrics/tsmodels/normetrics_catch22.RData"))

## auxiliary variables
models <- c(rep("WN", 100), 
            rep("AR(1)-0.5", 100), rep("AR(1)0.5", 100),rep("AR(2)", 100),
            rep("ARIMA", 100), rep("ARFIMA", 100),
            rep("SETAR", 100), rep("HMM", 100), 
            rep("GARCH", 100), rep("EGARCH", 100), rep("INAR", 100))

## experimental analysis of NetF + tsfeatures
title <- "NetF+tsfeatures"
mappings <- "NetF+tsfeatures"
normetrics <- cbind(nm_wnvg, nm_whvg, nm_50qg, nmetrics_Hynd, models)
idxs <- 1:ncol(normetrics)-1
source("comp_clustering.R")
pcaplots$pca_plot

## experimental analysis of NetF + catch22
title <- "NetF+catch22"
mappings <- "NetF+catch22"
normetrics <- cbind(nm_wnvg, nm_whvg, nm_50qg, nmetrics_catch22, models)
idxs <- 1:ncol(normetrics)-1
source("comp_clustering.R")
pcaplots$pca_plot

## experimental analysis of NetF + tsfeatures + catch22
title <- "NetF+tsfeatures+catch22"
mappings <- "NetF+tsfeatures+catch22"
normetrics <- cbind(nm_wnvg, nm_whvg, nm_50qg, nmetrics_Hynd, nmetrics_catch22, models)
idxs <- 1:ncol(normetrics)-1
source("comp_clustering.R")
pcaplots$pca_plot

## experimental analysis of NetF + tsfeatures + catch22
title <- "tsfeatures+catch22"
mappings <- "tsfeatures+catch22"
normetrics <- cbind(nmetrics_Hynd, nmetrics_catch22, models)
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

