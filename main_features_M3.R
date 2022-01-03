#############################################################
##################### GENERATE GRAPHS #######################
#############################################################

## load datasets
load(url("https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Data/M3_data.RData"))

#######################################################
#### Generate Graphs using the Time Series Mappings

## (W)NVG
wnvg_m3 <- generate_Graphs_list(m3_data, length(m3_data), map_type = "NVG", weight_type = TRUE)

## (W)HVG
whvg_m3 <- generate_Graphs_list(m3_data, length(m3_data), map_type = "HVG", weight_type = TRUE)

## QG Markov
qg50_m3 <- generate_Graphs_list(m3_data, length(m3_data), q = 50, map_type = "QG", is_Markov = TRUE)


#############################################################
################ CALCULATE FEATURES - NetF ##################
#############################################################

#######################################################
#### calculate NetF - Network Features

## (W)NVG
load(url("https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Graphs/M3/wnvg_m3.RData"))

m_wnvg_m3 <- calc_metrics(wnvg_m3, length(wnvg_m3), map_type = "NVG", weight_type = TRUE)

## (W)HVG
load(url("https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Graphs/M3/whvg_m3.RData"))

m_whvg_m3 <- calc_metrics(whvg_m3, length(whvg_m3), map_type = "HVG", weight_type = TRUE)

## QG Markov
load(url("https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Graphs/M3/50qg_Mkv_m3.RData"))

m_50qg_m3 <- calc_metrics(qg50_m3, length(qg50_m3), map_type = "QG")


#######################################################
#### normalize NetF

## load auxiliary function
source("min_max_norm.R")

## (W)NVG
load(url("https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Metrics/M3/metrics_wnvg_m3.RData"))

summary(m_wnvg_m3)
nm_wnvg_m3 <- norm_data(m_wnvg_m3)

## (W)HVG
load(url("https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Metrics/M3/metrics_whvg_m3.RData"))

summary(m_whvg_m3)
nm_whvg_m3 <- norm_data(m_whvg_m3)

## QG Mkv
load(url("https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Metrics/M3/metrics_50qg_Mkv_m3.RData"))

summary(m_50qg_m3)
nm_50qg_m3 <- norm_data(m_50qg_m3)


#############################################################
########## CALCULATE FEATURES - Classical Features ##########
#############################################################

#######################################################
#### calculate features - 'tsfeature' package

metrics_Hynd <- tsfeatures(m3_data)
summary(metrics_Hynd)
metrics_Hynd <- metrics_Hynd[, 1:16]

#######################################################
#### normalize tsfeature

load(url("https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Metrics/M3/metrics_tsfeature_m3.RData"))

nmetrics_Hynd <- norm_data(metrics_Hynd)


#######################################################
#### calculate features - 'Rcatch22' package

aux <- catch22_all(m3_data[[1]])
metrics_catch22 <- as.data.frame(t(aux$values))
colnames(metrics_catch22) <- aux$names
for(i in 2:length(m3_data)) {
  aux <- catch22_all(m3_data[[i]])
  metrics_catch22 <- rbind(metrics_catch22, c(t(aux$values)))
}
summary(metrics_catch22)

#######################################################
#### normalize catch22

load(url("https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Metrics/M3/metrics_catch22_m3.RData"))

nmetrics_catch22 <- norm_data(metrics_catch22)
