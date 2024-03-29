#############################################################
##################### GENERATE GRAPHS #######################
#############################################################

## load datasets
load(url("https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Data/production_Brazil.RData"))

#######################################################
#### Generate Graphs using the Time Series Mappings

## (W)NVG
wnvg_ProdBraz <- generate_Graphs_list(timeSeries, length(timeSeries), map_type = "NVG", weight_type = TRUE)

## (W)HVG
whvg_ProdBraz <- generate_Graphs_list(timeSeries, length(timeSeries), map_type = "HVG", weight_type = TRUE)

## QG Markov
qg50_ProdBraz <- generate_Graphs_list(timeSeries, length(timeSeries), q = 50, map_type = "QG", is_Markov = TRUE)


#############################################################
################ CALCULATE FEATURES - NetF ##################
#############################################################

#######################################################
#### calculate NetF - Network Features

## (W)NVG
load(url("https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Graphs/prodBrazil/wnvg_prodts.RData"))

m_wnvg_ProdBraz <- calc_metrics(wnvg_ProdBraz, length(wnvg_ProdBraz), map_type = "NVG", weight_type = TRUE)

## (W)HVG
load(url("https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Graphs/prodBrazil/whvg_prodts.RData"))

m_whvg_ProdBraz <- calc_metrics(whvg_ProdBraz, length(whvg_ProdBraz), map_type = "HVG", weight_type = TRUE)

## QG Markov
load(url("https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Graphs/prodBrazil/50qg_Mkv_prodts.RData"))

m_qg_ProdBraz <- calc_metrics(qg50_ProdBraz, length(qg50_ProdBraz), map_type = "QG")


#######################################################
#### normalize NetF

## load auxiliary function
source("min_max_norm.R")

## (W)NVG
load(url("https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Metrics/prodBrazil/metrics_wnvg_prodts.RData"))

summary(m_wnvg_ProdBraz)
nm_wnvg_ProdBraz <- norm_data(m_wnvg_ProdBraz)

## (W)HVG
load(url("https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Metrics/prodBrazil/metrics_whvg_prodts.RData"))

summary(m_whvg_ProdBraz)
nm_whvg_ProdBraz <- norm_data(m_whvg_ProdBraz)

## QG Mkv
load(url("https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Metrics/prodBrazil/metrics_50qg_Mkv_prodts.RData"))

summary(m_qg_ProdBraz)
nm_qg_ProdBraz <- norm_data(m_qg_ProdBraz)


#############################################################
########## CALCULATE FEATURES - Classical Features ##########
#############################################################

#######################################################
#### calculate features - 'tsfeature' package

metrics_Hynd <- tsfeatures(timeSeries)
summary(metrics_Hynd)

#######################################################
#### normalize tsfeature

load(url("https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Metrics/prodBrazil/metrics_tsfeature_prodts.RData"))

nmetrics_Hynd <- norm_data(metrics_Hynd)


#######################################################
#### calculate features - 'Rcatch22' package

aux <- catch22_all(timeSeries[[1]])
metrics_catch22 <- as.data.frame(t(aux$values))
colnames(metrics_catch22) <- aux$names
for(i in 2:length(timeSeries)) {
  aux <- catch22_all(timeSeries[[i]])
  metrics_catch22 <- rbind(metrics_catch22, c(t(aux$values)))
}
summary(metrics_catch22)

#######################################################
#### normalize catch22

load(url("https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Metrics/prodBrazil/metrics_catch22_prodts.RData"))

nmetrics_catch22 <- norm_data(metrics_catch22)

