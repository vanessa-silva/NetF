#############################################################
##################### GENERATE GRAPHS #######################
#############################################################

## load datasets
load("Data/ts_models.RData")
rm(gera_garch, gera_TimeSeries, geraINAR_Po, simnlts)

#######################################################
#### Generate Graphs using the Time Series Mappings

## (W)NVG
wnvg_AR1._0.5 <- generate_Graphs(AR1._0.5_ts, inst_numb, length = T, map_type = "NVG", weight_type = TRUE)
wnvg_AR1.0.5 <- generate_Graphs(AR1.0.5_ts, inst_numb, length = T, map_type = "NVG", weight_type = TRUE)
wnvg_AR2 <- generate_Graphs(AR2_ts, inst_numb, length = T, map_type = "NVG", weight_type = TRUE)
wnvg_ARIMA <- generate_Graphs(ARIMA_ts, inst_numb, length = T, map_type = "NVG", weight_type = TRUE)
wnvg_ARFIMA <- generate_Graphs(ARFIMA_ts, inst_numb, length = T, map_type = "NVG", weight_type = TRUE)
wnvg_EGARCH <- generate_Graphs(EGARCH_ts, inst_numb, length = T, map_type = "NVG", weight_type = TRUE)
wnvg_GARCH <- generate_Graphs(GARCH_ts, inst_numb, length = T, map_type = "NVG", weight_type = TRUE)
wnvg_HMM <- generate_Graphs(HMM_ts, inst_numb, length = T, map_type = "NVG", weight_type = TRUE)
wnvg_INAR <- generate_Graphs(INAR_ts, inst_numb, length = T, map_type = "NVG", weight_type = TRUE)
wnvg_SETAR <- generate_Graphs(SETAR_ts, inst_numb, length = T, map_type = "NVG", weight_type = TRUE)
wnvg_WN <- generate_Graphs(WN_ts, inst_numb, length = T, map_type = "NVG", weight_type = TRUE)

## (W)HVG
whvg_AR1._0.5 <- generate_Graphs(AR1._0.5_ts, inst_numb, length = T, map_type = "HVG", weight_type = TRUE)
whvg_AR1.0.5 <- generate_Graphs(AR1.0.5_ts, inst_numb, length = T, map_type = "HVG", weight_type = TRUE)
whvg_AR2 <- generate_Graphs(AR2_ts, inst_numb, length = T, map_type = "HVG", weight_type = TRUE)
whvg_ARIMA <- generate_Graphs(ARIMA_ts, inst_numb, length = T, map_type = "HVG", weight_type = TRUE)
whvg_ARFIMA <- generate_Graphs(ARFIMA_ts, inst_numb, length = T, map_type = "HVG", weight_type = TRUE)
whvg_EGARCH <- generate_Graphs(EGARCH_ts, inst_numb, length = T, map_type = "HVG", weight_type = TRUE)
whvg_GARCH <- generate_Graphs(GARCH_ts, inst_numb, length = T, map_type = "HVG", weight_type = TRUE)
whvg_HMM <- generate_Graphs(HMM_ts, inst_numb, length = T, map_type = "HVG", weight_type = TRUE)
whvg_INAR <- generate_Graphs(INAR_ts, inst_numb, length = T, map_type = "HVG", weight_type = TRUE)
whvg_SETAR <- generate_Graphs(SETAR_ts, inst_numb, length = T, map_type = "HVG", weight_type = TRUE)
whvg_WN <- generate_Graphs(WN_ts, inst_numb, length = T, map_type = "HVG", weight_type = TRUE)

## QG Markov
qg_AR1._0.5 <- generate_Graphs(AR1._0.5_ts, inst_numb, length = T, q = 50, map_type = "QG", is_Markov = TRUE)
qg_AR1.0.5 <- generate_Graphs(AR1.0.5_ts, inst_numb, length = T, q = 50, map_type = "QG", is_Markov = TRUE)
qg_AR2 <- generate_Graphs(AR2_ts, inst_numb, length = T, q = 50, map_type = "QG", is_Markov = TRUE)
qg_ARIMA <- generate_Graphs(ARIMA_ts, inst_numb, length = T, q = 50, map_type = "QG", is_Markov = TRUE)
qg_ARFIMA <- generate_Graphs(ARFIMA_ts, inst_numb, length = T, q = 50, map_type = "QG", is_Markov = TRUE)
qg_EGARCH <- generate_Graphs(EGARCH_ts, inst_numb, length = T, q = 50, map_type = "QG", is_Markov = TRUE)
qg_GARCH <- generate_Graphs(GARCH_ts, inst_numb, length = T, q = 50, map_type = "QG", is_Markov = TRUE)
qg_HMM <- generate_Graphs(HMM_ts, inst_numb, length = T, q = 50, map_type = "QG", is_Markov = TRUE)
qg_INAR <- generate_Graphs(INAR_ts, inst_numb, length = T, q = 50, map_type = "QG", is_Markov = TRUE)
qg_SETAR <- generate_Graphs(SETAR_ts, inst_numb, length = T, q = 50, map_type = "QG", is_Markov = TRUE)
qg_WN <- generate_Graphs(WN_ts, inst_numb, length = T, q = 50, map_type = "QG", is_Markov = TRUE)



#############################################################
################ CALCULATE FEATURES - NetF ##################
#############################################################

#######################################################
#### calculate NetF - Network Features

## (W)NVG
load("Graphs/tsmodels/wnvg.RData")
rm(indexMax, NVG, HVG, QG, generate_Graphs)

m_wnvg_AR1._0.5 <- calc_metrics(wnvg_AR1._0.5, inst_numb, map_type = "NVG", weight_type = TRUE)
m_wnvg_AR1.0.5 <- calc_metrics(wnvg_AR1.0.5, inst_numb, map_type = "NVG", weight_type = TRUE)
m_wnvg_AR2 <- calc_metrics(wnvg_AR2, inst_numb, map_type = "NVG", weight_type = TRUE)
m_wnvg_ARIMA <- calc_metrics(wnvg_ARIMA, inst_numb, map_type = "NVG", weight_type = TRUE)
m_wnvg_ARFIMA <- calc_metrics(wnvg_ARFIMA, inst_numb, map_type = "NVG", weight_type = TRUE)
m_wnvg_EGARCH <- calc_metrics(wnvg_EGARCH, inst_numb, map_type = "NVG", weight_type = TRUE)
m_wnvg_GARCH <- calc_metrics(wnvg_GARCH, inst_numb, map_type = "NVG", weight_type = TRUE)
m_wnvg_HMM <- calc_metrics(wnvg_HMM, inst_numb, map_type = "NVG", weight_type = TRUE)
m_wnvg_INAR <- calc_metrics(wnvg_INAR, inst_numb, map_type = "NVG", weight_type = TRUE)
m_wnvg_SETAR <- calc_metrics(wnvg_SETAR, inst_numb, map_type = "NVG", weight_type = TRUE)
m_wnvg_WN <- calc_metrics(wnvg_WN, inst_numb, map_type = "NVG", weight_type = TRUE)

## (W)HVG
load("Graphs/tsmodels/whvg.RData")
rm(indexMax, NVG, HVG, QG, generate_Graphs)

m_whvg_AR1._0.5 <- calc_metrics(whvg_AR1._0.5, inst_numb, map_type = "HVG", weight_type = TRUE)
m_whvg_AR1.0.5 <- calc_metrics(whvg_AR1.0.5, inst_numb, map_type = "HVG", weight_type = TRUE)
m_whvg_AR2 <- calc_metrics(whvg_AR2, inst_numb, map_type = "HVG", weight_type = TRUE)
m_whvg_ARIMA <- calc_metrics(whvg_ARIMA, inst_numb, map_type = "HVG", weight_type = TRUE)
m_whvg_ARFIMA <- calc_metrics(whvg_ARFIMA, inst_numb, map_type = "HVG", weight_type = TRUE)
m_whvg_EGARCH <- calc_metrics(whvg_EGARCH, inst_numb, map_type = "HVG", weight_type = TRUE)
m_whvg_GARCH <- calc_metrics(whvg_GARCH, inst_numb, map_type = "HVG", weight_type = TRUE)
m_whvg_HMM <- calc_metrics(whvg_HMM, inst_numb, map_type = "HVG", weight_type = TRUE)
m_whvg_INAR <- calc_metrics(whvg_INAR, inst_numb, map_type = "HVG", weight_type = TRUE)
m_whvg_SETAR <- calc_metrics(whvg_SETAR, inst_numb, map_type = "HVG", weight_type = TRUE)
m_whvg_WN <- calc_metrics(whvg_WN, inst_numb, map_type = "HVG", weight_type = TRUE)

## QG Markov
load("Graphs/tsmodels/50qg_Mkv.RData")
rm(indexMax, NVG, HVG, QG, generate_Graphs)

m_qg_AR1._0.5 <- calc_metrics(qg_AR1._0.5, inst_numb, map_type = "QG")
m_qg_AR1.0.5 <- calc_metrics(qg_AR1.0.5, inst_numb, map_type = "QG")
m_qg_AR2 <- calc_metrics(qg_AR2, inst_numb, map_type = "QG")
m_qg_ARIMA <- calc_metrics(qg_ARIMA, inst_numb, map_type = "QG")
m_qg_ARFIMA <- calc_metrics(qg_ARFIMA, inst_numb, map_type = "QG")
m_qg_EGARCH <- calc_metrics(qg_EGARCH, inst_numb, map_type = "QG")
m_qg_GARCH <- calc_metrics(qg_GARCH, inst_numb, map_type = "QG")
m_qg_HMM <- calc_metrics(qg_HMM, inst_numb, map_type = "QG")
m_qg_INAR <- calc_metrics(qg_INAR, inst_numb, map_type = "QG")
m_qg_SETAR <- calc_metrics(qg_SETAR, inst_numb, map_type = "QG")
m_qg_WN <- calc_metrics(qg_WN, inst_numb, map_type = "QG")


#######################################################
#### normalize NetF

## load auxiliary function
source("min_max_norm.R")

## (W)NVG
load("Metrics/tsmodels/metrics_wnvg.RData")
rm(calc_metrics)

m_wnvg <- rbind(m_wnvg_WN, 
                m_wnvg_AR1._0.5, m_wnvg_AR1.0.5, m_wnvg_AR2,
                m_wnvg_ARIMA, m_wnvg_ARFIMA,
                m_wnvg_SETAR,
                m_wnvg_HMM,
                m_wnvg_GARCH, m_wnvg_EGARCH,
                m_wnvg_INAR)
summary(m_wnvg)
nm_wnvg <- norm_data(m_wnvg)

## (W)HVG
load("Metrics/tsmodels/metrics_whvg.RData")
rm(calc_metrics)

m_whvg <- rbind(m_whvg_WN, 
                m_whvg_AR1._0.5, m_whvg_AR1.0.5, m_whvg_AR2,
                m_whvg_ARIMA, m_whvg_ARFIMA,
                m_whvg_SETAR,
                m_whvg_HMM,
                m_whvg_GARCH, m_whvg_EGARCH,
                m_whvg_INAR)
summary(m_whvg)
nm_whvg <- norm_data(m_whvg)

## QG Mkv
load("Metrics/tsmodels/metrics_50qg_Mkv.RData")
rm(calc_metrics)

m_50qg <- rbind(m_qg_WN, 
                m_qg_AR1._0.5, m_qg_AR1.0.5, m_qg_AR2,
                m_qg_ARIMA, m_qg_ARFIMA,
                m_qg_SETAR,
                m_qg_HMM,
                m_qg_GARCH, m_qg_EGARCH,
                m_qg_INAR)
summary(m_50qg)
nm_50qg <- norm_data(m_50qg)
#############################################################
########## CALCULATE FEATURES - Classical Features ##########
#############################################################

#######################################################
#### calculate features - 'tsfeature' package

tsmodels <- cbind(WN_ts, 
                  AR1._0.5_ts, AR1.0.5_ts, AR2_ts,
                  ARIMA_ts, ARFIMA_ts,
                  SETAR_ts, HMM_ts,
                  GARCH_ts, EGARCH_ts,
                  INAR_ts)

metrics_Hynd <- tsfeatures(tsmodels)
summary(metrics_Hynd)

#######################################################
#### normalize tsfeature

load("Metrics/tsmodels/metrics_tsfeature.RData")

nmetrics_Hynd <- norm_data(metrics_Hynd)


#######################################################
#### calculate features - 'Rcatch22' package

tsmodels <- cbind(WN_ts, 
                  AR1._0.5_ts, AR1.0.5_ts, AR2_ts,
                  ARIMA_ts, ARFIMA_ts,
                  SETAR_ts, HMM_ts,
                  GARCH_ts, EGARCH_ts,
                  INAR_ts)

aux <- catch22_all(tsmodels[, 1])
metrics_catch22 <- as.data.frame(t(aux$values))
colnames(metrics_catch22) <- aux$names
for(i in 2:ncol(tsmodels)) {
  aux <- catch22_all(tsmodels[, i])
  metrics_catch22 <- rbind(metrics_catch22, c(t(aux$values)))
}
summary(metrics_catch22)

#######################################################
#### normalize catch22

load("Metrics/tsmodels/metrics_catch22.RData")

nmetrics_catch22 <- norm_data(metrics_catch22)