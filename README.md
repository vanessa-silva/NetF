# NetF: A Novel Set of Time Series Features

This is the original implementation of ***NetF*** for the paper ["*Novel Features for Time Series Analysis: A Complex Networks Approach*"](https://arxiv.org/pdf/2110.09888.pdf).
<!--- and published in DAMI Journal (D M 2022) -->

Please cite our paper if you use the code:

> Silva, V.F.; Silva, M.E.; Ribeiro, P.; Silva, F.
> Novel Features for Time Series Analysis: A Complex Networks Approach
> arXiv preprint arXiv:2110.09888 (2021).


## Configurations

### Data
- All the data sets can be found [here](https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Data/) and a subset in the folder ***Data***.
	- **M3_data**: M3 competition data from *R* package *Mcomp*
	- **production_Brazil**: Production in Brazil data, the set of observations of *9* agriculture products in meso-regions of [Brazil](https://www.ibge.gov.br)
	- **real_ts**: Selected benchmark empirical data sets, namely, the set of *8* selected data sets from [*UEA \& UCR Time Series Classification Repository*](www.timeseriesclassification.com) and 
the *18Pairs* data set from *R* package *TSclust*  
	- **ts_models**: Data Generating Processes, the set of *11* linear and nonlinear time series models
- All the univariate time series data sets from *UEA \& UCR Time Series Classification Repository* can be found 
[here](https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Data/realts/). Can also be downloaded [here](https://www.timeseriesclassification.com/dataset.php).
- Datasets are stored in *.RData* files and are in the following formats:
	- matrix of *ts* objects, ie. *mts*, for the **ts_models** dataset
	- list of *ts* objects, for the remaining datasets
- All the complex networks (Visibility Graphs and Quantiles Graphs) generated from the time series data sets can be found [here](https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Graphs/).
- The networks/graphs are in *R* *igraph* format and stored in *.RData* files.
- All the feature vectores (from ***NetF***, ***tsfeatures***, ***Rcatch22***) can be found [here](https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Metrics/).
- All the empirical and experimental results can be found [here](https://www.dcc.fc.up.pt/~vanessa.silva/datasets/NetF/Results/). 


### Source Files
- **main** : runs all experiments presented in paper
- **libraries** : contains all required packages for the procedures
- **simm_models** : contains the functions to simulate Data Generation Processes 
- **dgp** : generates the specific Data Generation Processes to the paper
- **read_empirical** : reads benchmark empirical data sets of UEA & UCR Time Series Classification Repository
- **vg_algorithm** : contains the Natural and Horizontal Visibility Graph algorithms
- **qg_algorithm** : contains the Quantile Graph algorithm
- **ts_mapping** : contains the main function to run time series mapping algorithms
- **net_features** : contains the network feature functions to create de NetF
- **main_features_tsmodels** : runs main procedure to calculate features matrices from the synthetic DGP dataset
