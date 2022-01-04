#############################################################
##################### GENERATE GRAPHS #######################
#############################################################

## load datasets
load(url("https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Data/real_ts.RData"))

#######################################################
#### Generate Graphs using the Time Series Mappings

## (W)NVG
wnvg_realts <- generate_Graphs_list(pairs_ts, length(pairs_ts), map_type = "NVG", weight_type = TRUE)

## (W)HVG
whvg_realts <- generate_Graphs_list(pairs_ts, length(pairs_ts), map_type = "HVG", weight_type = TRUE)

## QG Markov
qg50_realts <- generate_Graphs_list(pairs_ts, length(pairs_ts), q = 50, map_type = "QG", is_Markov = TRUE)


#############################################################
################ CALCULATE FEATURES - NetF ##################
#############################################################

#######################################################
#### calculate NetF - Network Features

## (W)NVG
load(url("https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Graphs/realts/pairs_wnvg_realts.RData"))

m_wnvg_realts <- calc_metrics(wnvg_realts, length(wnvg_realts), map_type = "NVG", weight_type = TRUE)

## (W)HVG
load(url("https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Graphs/realts/pairs_whvg_realts.RData"))

m_whvg_realts <- calc_metrics(whvg_realts, length(whvg_realts), map_type = "HVG", weight_type = TRUE)

## QG Markov
load(url("https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Graphs/realts/pairs_50qg_Mkv_realts.RData"))

m_qg_realts <- calc_metrics(qg50_realts, length(qg50_realts), map_type = "QG")


#######################################################
#### normalize NetF

## load auxiliary function
source("../min_max_norm.R")

## (W)NVG
load(url("https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Metrics/realts/pairs_metrics_wnvg_realts.RData"))

summary(m_wnvg_realts)
nm_wnvg_realts <- norm_data(m_wnvg_realts)

## (W)HVG
load(url("https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Metrics/realts/pairs_metrics_whvg_realts.RData"))

summary(m_whvg_realts)
nm_whvg_realts <- norm_data(m_whvg_realts)

## QG Mkv
load(url("https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Metrics/realts/pairs_metrics_50qg_Mkv_realts.RData"))

summary(m_qg_realts)
nm_qg_realts <- norm_data(m_qg_realts)


#############################################################
########## CALCULATE FEATURES - Classical Features ##########
#############################################################

#######################################################
#### calculate features - 'tsfeature' package

metrics_Hynd <- tsfeatures(pairs_ts)
summary(metrics_Hynd)

#######################################################
#### normalize tsfeature

load(url("https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Metrics/realts/pairs_metrics_tsfeature_realts.RData"))

nmetrics_Hynd <- norm_data(metrics_Hynd)


#######################################################
#### calculate features - 'Rcatch22' package

aux <- catch22_all(pairs_ts[[1]])
metrics_catch22 <- as.data.frame(t(aux$values))
colnames(metrics_catch22) <- aux$names
for(i in 2:length(pairs_ts)) {
  aux <- catch22_all(pairs_ts[[i]])
  metrics_catch22 <- rbind(metrics_catch22, c(t(aux$values)))
}
summary(metrics_catch22)

#######################################################
#### normalize catch22

load(url("https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Metrics/realts/pairs_metrics_catch22_realts.RData"))

nmetrics_catch22 <- norm_data(metrics_catch22)
