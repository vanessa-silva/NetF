#############################################################
######################### MAIN ##############################
#############################################################


#######################################################
#### load libraries

source("libraries.R")



#######################################################
#### load time series mapping algorithms

source("ts_mapping.R")



#######################################################
#### load network feature functions

source("net_features.R")



#######################################################
#### load data generating processes: DGP dataset

source("main_tsmodels/simm_models.R")

## create a seed to the simulations
set.seed(123456789)

## parameters
T <- 10000          ## time series length
inst_numb <- 100    ## total of realizations
theta <- c(0.5,1)

## simulate Synthetic DGP's
source("main_tsmodels/dgp.R")


#######################################################
#### load main procedure to calculate features from
###  the synthetic DGP dataset:
###  generate VGs and QGs; calculate NetF, tsfeature and
###  catch22 matrices

source("main_tsmodels/main_features_tsmodels.R")


#######################################################
#### load main procedure to run empirical evaluation:
###  clustering of time series models

source("main_tsmodels/emp_eval_tsmodels.R")



#######################################################
#### load main procedure to calculate features from
#### the Production in Brazil dataset:
###  generate VGs and QGs; calculate NetF, tsfeature and
###  catch22 matrices

source("main_Brazil/main_features_Brazil.R")


#######################################################
#### load main procedure to run experimental evaluation:
#### clustering of production in Brazil data

source("main_Brazil/exp_eval_Brazil.R")



#######################################################
#### load main procedure to calculate features from
#### the M3 dataset:
###  generate VGs and QGs; calculate NetF, tsfeature and
###  catch22 matrices

source("main_M3/main_features_M3.R")



#######################################################
#### load main procedure to run experimental evaluation:
#### clustering of M3 data

source("main_M3/exp_eval_M3.R")



#######################################################
#### load benchmark empirical data sets of UEA & UCR 
###  Time Series Classification Repository

source("main_realts/read_empirical.R")


#######################################################
#### load main procedure to calculate features from
#### the benchmark empirical data sets:
###  generate VGs and QGs; calculate NetF, tsfeature and
###  catch22 matrices

source("main_realts/main_features_realts.R")


#######################################################
#### load main procedure to run experimental evaluation:
#### clustering of benchmark empirical data sets

source("main_realts/exp_eval_realts.R")


#######################################################
#### load main procedure to calculate features from
#### the benchmark empirical data set "18 Pairs":
###  generate VGs and QGs; calculate NetF, tsfeature and
###  catch22 matrices

source("main_realts/main_features_pairs.R")


#######################################################
#### load main procedure to run experimental evaluation:
#### clustering of benchmark empirical "pairs" data set

source("main_realts/exp_eval_pairs.R")

