# NetF: A Novel Set of Time Series Features

This is the original implementation of ***NetF*** for the paper ["*Novel Features for Time Series Analysis: A Complex Networks Approach*"](https://doi.org/10.1007/s10618-022-00826-3) published in Data Mining and Knowledge Discovery.

Please cite our paper if you use the code:

> Silva, V.F., Silva, M.E., Ribeiro, P., Silva, F.
> Novel features for time series analysis: a complex networks approach.
> Data Min Knowl Disc 36, 1062–1101 (2022).
> https://doi.org/10.1007/s10618-022-00826-3


## Requirements
- R (>= 3.6.0)


## Configurations

### Data
- All the data sets can be found [here](https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Data/) and a subset in the folder ***Data***.
	- **M3_data**: M3 competition data from *R* package *Mcomp*
	- **production_Brazil**: Production in Brazil data, the set of observations of *9* agriculture products in meso-regions of [Brazil](https://www.ibge.gov.br)
	- **real_ts**: Selected benchmark empirical data sets, namely, the set of *8* selected data sets from [*UEA \& UCR Time Series Classification Repository*](www.timeseriesclassification.com) and the *18Pairs* data set from *R* package *TSclust*  
	- **ts_models**: Data Generating Processes (DGP), the set of *11* *linear* and *nonlinear* time series models
- All the univariate time series data sets from *UEA \& UCR Time Series Classification Repository* can be found [here](https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Data/realts/). Can also be downloaded [here](https://www.timeseriesclassification.com/dataset.php).
	- Datasets are stored in *.RData* files and are in the following formats:
		- matrix of *ts* objects, ie. *mts*, for the **ts_models** dataset
		- list of *ts* objects, for the remaining datasets
- All the complex networks (*Visibility Graphs* and *Quantiles Graphs*) generated from the time series data sets can be found [here](https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Graphs/).
	- The networks/graphs are in *R* *igraph* format and stored in *.RData* files.
- All the feature vectores (from ***NetF***, ***tsfeatures***, ***Rcatch22***) can be found [here](https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Metrics/).
- All the empirical and experimental results can be found [here](https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Results/). 


### Source Files
- **main** : runs procedures for the experiments presented in paper
- **libraries** : contains all required packages for the procedures
- **ts_mapping** : contains the main function to run time series mapping algorithms
	- **vg_algorithm** : contains the Natural and Horizontal Visibility Graph algorithms
	- **qg_algorithm** : contains the Quantile Graph algorithm
- **net_features** : contains the network feature functions to create the ***NetF***
- **comp_clustering** : runs the main procedures for PCA and clustering analysis
- **func_clustering** : contains the auxiliary functions for de PCA and clustering tasks
- **min_max_norm** : contains the auxiliary functions to compute the Min-Max normalization of a data frame
- The folder ***main_tsmodels*** contains the source files for the empirical evaluation of DGP data
	- **simm_models** : contains the functions to simulate Data Generation Processes 
	- **dgp** : generates the specific Data Generation Processes to the paper
	- **main_features_tsmodels** : runs the main procedures for generating VGs and QGs from **synthetic DGP** time series set, and for computing the feature vectors: ***NetF***, ***tsfeatures*** and ***catch22***
	- **emp_eval_tsmodels** : runs the main procedures for the empirical evaluation of *synthetic DGP*
- The folder ***main_Brazil*** contains the source files for the experimental evaluation of Production in Brazil data
	- ***main_features_Brazil*** : runs the main procedures for generating VGs and QGs from **Production** time series set, and for computing the feature vectors: ***NetF***, ***tsfeatures*** and ***catch22***
	- ***exp_eval_Brazil*** : runs the main procedures for the experimental evaluation of *Production Brazil*
- The folder ***main_M3*** contains the source files for the experimental evaluation of M3 competition data
	- ***main_features_M3*** : runs the main procedures for generating VGs and QGs from **M3** time series set, and for computing the feature vectors: ***NetF***, ***tsfeatures*** and ***catch22***
	- ***exp_eval_M3*** : runs the main procedures for the experimental evaluation of *M3 data*
- The folder ***main_realts*** contains the source files for the experimental evaluation of benchmark empirical data
	- ***read_empirical*** : reads benchmark empirical data sets from *UEA & UCR Time Series Classification Repository*
	- ***main_features_realts*** : runs the main procedures for generating VGs and QGs from time series sets from **UEA & UCR repository**, and for computing the feature vectors: ***NetF***, ***tsfeatures*** and ***catch22***
	- ***exp_eval_realts*** : runs the main procedures for the experimental evaluation of *UEA & UCR data sets*
	- ***main_features_pairs*** :  runs the main procedures for generating VGs and QGs from **18 Pairs** time series sets, and for computing the feature vectors: ***NetF***, ***tsfeatures*** and ***catch22***
	- ***exp_eval_pairs*** : runs the main procedures for the experimental evaluation of *18 Pairs*
