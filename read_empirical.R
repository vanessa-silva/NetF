#############################################################
################# READ EMPIRICAL DATASET ####################
##############################################################

## load datasets
reats_url <- "http://www.timeseriesclassification.com/Downloads/Archives/Univariate2018_arff.zip"
download.file(reats_url, "Data/Univariate2018_arff.zip")
unzip(zipfile = "Data/Univariate2018_arff.zip", exdir = "Data/realts")

## get names of all datasets 
data_names <- read.table(load(url("https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Data/realts/data_names.txt")))
## datasets ID that lead to NA values of features
missingValues_id <- c(3, 4, 5, 26, 27, 28, 35, 72, 105, 122)

for(i in 1:nrow(data_names)) {
  if(i %in% missingValues_id)
    next
  
  ## current dataset
  data_name <- data_names[i, ]
  
  ## read TEST and TRAIN time series set files
  realts_TEST <- t(readARFF(paste0("Data/realts", data_name, "/", data_name, "_TEST.arff")))
  realts_TRAIN <- t(readARFF(paste0("Data/realts", data_name, "/", data_name, "_TRAIN.arff")))
  
  ## get and store all classes
  classes_TEST <- realts_TEST[nrow(realts_TEST), ]
  realts_TEST <- realts_TEST[-nrow(realts_TEST), ]
  classes_TRAIN <- realts_TRAIN[nrow(realts_TRAIN), ]
  realts_TRAIN <- realts_TRAIN[-nrow(realts_TRAIN), ]
  
  classes <- c(classes_TEST, classes_TRAIN)
  rm(classes_TEST, classes_TRAIN)
  
  ## store all UTS sets
  realts <- list()
  idx <- 1
  
  # TEST
  for(test in 1:ncol(realts_TEST)) {
    if(length(which(is.na(realts_TEST[, test]))) > 0)
      ts_aux <- ts(realts_TEST[1:(which(is.na(realts_TEST[, test]))[1] - 1), test])
    else
      ts_aux <- ts(realts_TEST[1:(nrow(realts_TEST)), test])
    realts[[idx]] <- ts_aux
    idx <- idx+1
  }
  # TRAIN
  for(train in 1:ncol(realts_TRAIN)) {
    if(length(which(is.na(realts_TRAIN[, train]))) > 0)
      ts_aux <- ts(realts_TRAIN[1:(which(is.na(realts_TRAIN[, train]))[1] - 1), train])
    else
      ts_aux <- ts(realts_TRAIN[1:(nrow(realts_TRAIN)), train])
    realts[[idx]] <- ts_aux
    idx <- idx+1
  }

  rm(ts_aux, idx, test, train, realts_TEST, realts_TRAIN)
  ## save datasets
  ##save.image(paste0("Data/realts/", data_name, ".RData"))  
}
