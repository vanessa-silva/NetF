#############################################################
######################### MAIN ##############################
#############################################################


#######################################################
#### load libraries

source("libraries.R")



#######################################################
#### load data generating processes

source("simm_models.R")

## create a seed to the simulations
set.seed(123456789)

## parameters
T <- 10000          ## time series length
inst_numb <- 100    ## total of realizations
theta <- c(0.5,1)

## simulate Synthetic DGP's
source("dgp.R")


#######################################################
#### load benchmark empirical data sets of UEA & UCR 
#    Time Series Classification Repository

source("read_empirical.R")


#######################################################
#### load time series mapping algorithms

source("ts_mapping.R")



#######################################################
#### load network feature functions

source("net_features.R")



#######################################################
#### load main procedure to calculate features from
#### the synthetic DGP dataset

## generate VGs and QGs; calculate NetF, tsfeature and
#  catch22 matrices
source("main_features_tsmodels.R")

