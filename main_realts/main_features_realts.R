#############################################################
##################### GENERATE GRAPHS #######################
#############################################################

source_dir <- "https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/"

## get names of all datasets 
data_names <- read.table(url(paste0(source_dir, "Data/realts/data_names.txt")))


#######################################################
#### Generate Graphs using the Time Series Mappings

## (W)NVG
for(idx_name in 1:nrow(data_names)) {
  missingValues_id <- c(3, 4, 5, 26, 27, 28, 72, 105, 122)
  
  if(idx_name %in% missingValues_id)
    next
  
  data_name <- data_names[idx_name, ]
  
  ## load data set
  load(url(paste0(source_dir, "Data/realts/", data_name, ".RData")))
  
  ## generate graph
  wnvg_realts <- generate_Graphs_list(realts, length(realts), map_type = "NVG", weight_type = TRUE) 
}

## (W)HVG
for(idx_name in 1:nrow(data_names)) {
  missingValues_id <- c(3, 4, 5, 26, 27, 28, 72, 105, 122)
  
  if(idx_name %in% missingValues_id)
    next
  
  data_name <- data_names[idx_name, ]
  
  ## load data set
  load(url(paste0(source_dir, "Data/realts/", data_name, ".RData")))
  
  ## generate graph
  whvg_realts <- generate_Graphs_list(realts, length(realts), map_type = "HVG", weight_type = TRUE)
}

## QG Markov
for(idx_name in 1:nrow(data_names)) {
  missingValues_id <- c(3, 4, 5, 26, 27, 28, 72, 105, 122)
  
  if(idx_name %in% missingValues_id)
    next
  
  data_name <- data_names[idx_name, ]
  
  ## load data set
  load(url(paste0(source_dir, "Data/realts/", data_name, ".RData")))
  
  ## generate graph
  qg50_realts <- generate_Graphs_list(realts, length(realts), q = 50, map_type = "QG", is_Markov = TRUE)
}


#############################################################
################ CALCULATE FEATURES - NetF ##################
#############################################################

#######################################################
#### calculate NetF - Network Features

## (W)NVG
for(idx_name in 1:nrow(data_names)) {
  missingValues_id <- c(3, 4, 5, 26, 27, 28, 72, 105, 122)
  
  if(idx_name %in% missingValues_id)
    next
  
  data_name <- data_names[idx_name, ]
  
  ## load graph
  load(url(paste0(source_dir, "Graphs/realts/", data_name, "_wnvg_realts.RData")))
  
  ## calculate features
  m_wnvg_realts <- calc_metrics(wnvg_realts, length(wnvg_realts), map_type = "NVG", weight_type = TRUE)
}

## (W)HVG
for(idx_name in 1:nrow(data_names)) {
  missingValues_id <- c(3, 4, 5, 26, 27, 28, 72, 105, 122)
  
  if(idx_name %in% missingValues_id)
    next
  
  data_name <- data_names[idx_name, ]
  
  ## load graph
  load(url(paste0(source_dir, "Graphs/realts/", data_name, "_whvg_realts.RData")))
  
  ## calculate features
  m_whvg_realts <- calc_metrics(whvg_realts, length(whvg_realts), map_type = "HVG", weight_type = TRUE)
}

## QG Markov
for(idx_name in 1:nrow(data_names)) {
  missingValues_id <- c(3, 4, 5, 26, 27, 28, 72, 105, 122)
  
  if(idx_name %in% missingValues_id)
    next
  
  data_name <- data_names[idx_name, ]
  
  ## load graph
  load(url(paste0(source_dir, "Graphs/realts/", data_name, "_50qg_Mkv_realts.RData")))
  
  ## calculate features
  m_qg_realts <- calc_metrics(qg50_realts, length(qg50_realts), map_type = "QG")
}


#######################################################
#### normalize NetF

## load auxiliary function
source("../min_max_norm.R")

## (W)NVG
for(idx_name in 1:nrow(data_names)) {
  missingValues_id <- c(3, 4, 5, 26, 27, 28, 72, 105, 122)
  
  if(idx_name %in% missingValues_id)
    next
  
  data_name <- data_names[idx_name, ]
  
  ## load features
  load(url(paste0(source_dir, "Metrics/realts/", data_name, "_metrics_wnvg_realts.RData")))
  
  if(idx_name == 35)
    m_wnvg_realts <- m_wnvg_realts[-to_rm_ElectricDev, ]
  
  ## normalize features
  nm_wnvg_realts <- norm_data(m_wnvg_realts)
}

## (W)HVG
for(idx_name in 1:nrow(data_names)) {
  missingValues_id <- c(3, 4, 5, 26, 27, 28, 72, 105, 122)
  
  if(idx_name %in% missingValues_id)
    next
  
  data_name <- data_names[idx_name, ]
  
  ## load features
  load(url(paste0(source_dir, "Metrics/realts/", data_name, "_metrics_whvg_realts.RData")))
  
  if(idx_name == 35)
    m_wnvg_realts <- m_wnvg_realts[-to_rm_ElectricDev, ]
  
  ## normalize features
  nm_whvg_realts <- norm_data(m_whvg_realts)
}

## QG Mkv
for(idx_name in 1:nrow(data_names)) {
  missingValues_id <- c(3, 4, 5, 26, 27, 28, 72, 105, 122)
  
  if(idx_name %in% missingValues_id)
    next
  
  data_name <- data_names[idx_name, ]
  
  ## load features
  load(url(paste0(source_dir, "Metrics/realts/", data_name, "_metrics_50qg_Mkv_realts.RData")))
  
  if(idx_name == 35)
    m_wnvg_realts <- m_wnvg_realts[-to_rm_ElectricDev, ]
  
  ## normalize features
  nm_qg_realts <- norm_data(m_qg_realts)
}


#############################################################
########## CALCULATE FEATURES - Classical Features ##########
#############################################################

#######################################################
#### calculate features - 'tsfeature' package

for(idx_name in 1:nrow(data_names)) {
  missingValues_id <- c(3, 4, 5, 26, 27, 28, 72, 105, 122)
  
  if(idx_name %in% missingValues_id)
    next
  
  data_name <- data_names[idx_name, ]
  
  ## load data set
  load(url(paste0(source_dir, "Data/realts/", data_name, ".RData")))
  
  ## calculate features
  metrics_Hynd <- tsfeatures(realts)
}

#######################################################
#### normalize tsfeature

for(idx_name in 1:nrow(data_names)) {
  missingValues_id <- c(3, 4, 5, 26, 27, 28, 72, 105, 122)
  
  if(idx_name %in% missingValues_id)
    next
  
  data_name <- data_names[idx_name, ]
  
  ## load features
  load(url(paste0(source_dir, "Metrics/realts/", data_name, "_metrics_tsfeature_realts.RData")))
  
  ## normalize features
  nmetrics_Hynd <- norm_data(metrics_Hynd)
}


#######################################################
#### calculate features - 'Rcatch22' package

for(idx_name in 1:nrow(data_names)) {
  missingValues_id <- c(3, 4, 5, 26, 27, 28, 72, 105, 122)
  
  if(idx_name %in% missingValues_id)
    next
  
  data_name <- data_names[idx_name, ]
  
  ## load data set
  load(url(paste0(source_dir, "Data/realts/", data_name, ".RData")))
  
  ## calculate features
  aux <- catch22_all(realts[[1]])
  metrics_catch22 <- as.data.frame(t(aux$values))
  colnames(metrics_catch22) <- aux$names
  for(i in 2:length(realts)) {
    aux <- catch22_all(realts[[i]])
    metrics_catch22 <- rbind(metrics_catch22, c(t(aux$values)))
  }
}

#######################################################
#### normalize catch22

for(idx_name in 1:nrow(data_names)) {
  missingValues_id <- c(3, 4, 5, 26, 27, 28, 72, 105, 122)
  
  if(idx_name %in% missingValues_id)
    next
  
  data_name <- data_names[idx_name, ]
  
  ## load features
  load(url(paste0(source_dir, "Metrics/realts/", data_name, "_metrics_tsfeature_realts.RData")))
  
  if(idx_name == 35)
    m_wnvg_realts <- m_wnvg_realts[-to_rm_ElectricDev, ]
  
  ## normalize features
  nmetrics_catch22 <- norm_data(metrics_catch22)
}
