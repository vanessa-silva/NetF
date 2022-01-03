#############################################################
##################### SYNTHETIC DGP #########################
#############################################################


#######################################################
## simulate Synthetic DGP's

## linear models
WN_ts <- gera_TimeSeries(T, theta, inst_numb, 1)              ## WN
AR1._0.5_ts <- gera_TimeSeries(T, theta, inst_numb, 2)        ## AR(1)
AR1.0.5_ts <- gera_TimeSeries(T, theta, inst_numb, 3)         ## AR(1)
AR2_ts <- gera_TimeSeries(T, theta, inst_numb, 4)             ## AR(2)
ARIMA <- gera_TimeSeries(T, theta, inst_numb, 5)              ## ARIMA(1,1,0)
ARIMA_ts <- cbind(as.ts(ARIMA[2:10001, 1]), as.ts(ARIMA[2:10001, 2]))
for(i in 3:inst_numb)
  ARIMA_ts <- cbind(ARIMA_ts, as.ts(ARIMA[2:10001, i]))
ARFIMA_ts <- gera_TimeSeries(T, theta, inst_numb, 6)          ## ARFIMA(1,0.4,0)

## non linear models
SETAR_ts <- gera_TimeSeries(T, theta, inst_numb, 7)           ## SETAR(1)
HMM_ts <- gera_TimeSeries(T, theta, inst_numb, 8)             ## HMM
INAR_ts <- gera_TimeSeries(T, theta, inst_numb, 9)            ## INAR(1)
GARCH_ts <- gera_TimeSeries(T, theta, inst_numb, 10)          ## GARCH(1,1)
EGARCH_ts <- gera_TimeSeries(T, theta, inst_numb, 11)         ## EGARCH(1,1)