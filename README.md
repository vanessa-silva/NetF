# NetF: A Novel Set of Time Series Features

This is the original implementation of ***NetF*** for the paper ["*Novel Features for Time Series Analysis: A Complex Networks Approach*"](https://arxiv.org/pdf/2110.09888.pdf).
<!--- and published in DAMI Journal (D M 2022) -->

Please cite our paper if you use the code:

> Silva, V.F.; Silva, M.E.; Ribeiro, P.; Silva, F.
> Novel Features for Time Series Analysis: A Complex Networks Approach
> arXiv preprint arXiv:2110.09888 (2021).

<!--- ## Pcakege Requirements -->

## Configurations
### Data
- All the data sets can be found in the folder *Data*
- **M3_data**: M3 competition data from *R* package *Mcomp*
- **production_Brazil**: Production in Brazil data, the set of observations of *9* agriculture products in meso-regions of [Brazil](https://www.ibge.gov.br)
- **real_ts**: benchmark empirical data, the set of *8* selected data sets from [*UEA \& UCR Time Series Classification Repository*](www.timeseriesclassification.com) and the *18Pairs* data set from *R* package *TSclust*  
- **ts_models**: Data Generating Processes, the set of *11* linear and nonlinear time series models
<!--- - Each file is the current format: -->
<!--- - The folder *Data/realts* contains all the univariate time series data sets from *UEA \& UCR Time Series Classification Repository*. These data sets can also be downloaded [here](https://www.timeseriesclassification.com/dataset.php). -->

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
