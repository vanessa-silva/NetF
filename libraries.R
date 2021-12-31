#############################################################
###################### LOAD LIBRARIES #######################
#############################################################

## to generate time series
if (!require(timeSeries)) 
  install.packages('timeSeries')
if (!require(fracdiff)) 
  install.packages('fracdiff')
if (!require(fGarch)) 
  install.packages('fGarch')
if (!require(HMMpa)) 
  install.packages('HMMpa')

## to read time series in ARFF format
if (!require(farff)) 
  install.packages('farff')

## to load M3 data
if (!require(Mcomp)) 
  install.packages('Mcomp')

## to generate graphs and calculate network features
if (!require(igraph)) 
  install.packages('igraph')

## to calculate ts features
if (!require(tsfeatures)) 
  install.packages('tsfeatures')

## to calculate ts features from catch22
if (!require(Rcatch22)) 
  install.packages('Rcatch22')

## to clustering task
if (!require(cluster)) 
  install.packages('cluster')
if (!require(aricode)) 
  install.packages('aricode')
if (!require(vegan)) 
  install.packages('vegan')

## to generate plots
if (!require(factoextra)) 
  install.packages('factoextra')
if (!require(corrplot)) 
  install.packages('corrplot')
if (!require(ggplot2)) 
  install.packages('ggplot2')

