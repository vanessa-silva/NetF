#############################################################
############# (NON)LINEAR TIME SERIES MODELS ################
#############################################################


#######################################################
#### Data Generating Processes (DGP) Functions

## SETAR(1) function generate
simnlts <- function(n, alpha, beta, r, sigma, gamma, burnin = 100) {
  # Generate noise
  e <- rnorm(n+burnin, 0, sigma)
  # Create space for y
  y <- numeric(n+burnin)
  # Generate time series
  for(i in 2:(n+burnin)) {
    if(y[i-1] <= r)
      y[i] <- alpha*y[i-1] + e[i]
    else
      y[i] <- beta*y[i-1] + gamma*e[i]
  }
  # Throw away first burnin values
  y <- ts(y[-(1:burnin)])
  # Return result
  return(y)
}

## INAR(1) function generate 
geraINAR_Po <- function(n, theta) {
  #generate {x_t} inar sample
  #theta=c(alpha,lambda)
  nn <- n+500
  #generate poisson sample
  zlist <- rpois(nn,theta[2])
  x <- array(0,dim=nn)
  x[1] <- 1
  for(i in 2:nn) {
    x[i] <- rbinom(1,x[i-1], theta[1]) + zlist[i]
  }
  inar <- ts(x[501:nn], start=1,frequency=1)
  return(inar)
}

## EGARCH(1,1) function generate
gera_garch <- function(n, omega, alpha, beta, gamma, sigma = 1, burnin = 100){
  # Generate noise
  e <- rnorm(n+burnin, 0, sigma)
  # Create space for y
  y <- numeric(n+burnin)
  # Generate time series
  ## EGARCH
  for(i in 2:(n+burnin)) {
    y[i] = omega + (alpha * abs(e[i-1]/(exp(1)^(y[i-1]/2)))) - (alpha * sqrt(2/pi)) + (beta * y[i-1]) + (gamma * (e[i-1]/(exp(1)^(y[i-1]/2))))
  }
  # Throw away first burnin values
  y <- ts(y[-(1:burnin)])
  # Return result
  return(y)
}


#######################################################
#### Auxiliary function to call all DGP Functions

## Main function to generate (non)linear time series models
gera_TimeSeries <- function(T, theta, inst_numb, n_model) {
  
  ### Linear processes
  
  ## WN [1]
  #  mean = 0, sd = 1
  if(n_model == 1) {
    model <- as.ts(rnorm(T))
    
    for(i in 2:inst_numb) 
      model <- cbind(model, as.ts(rnorm(T)))
  }
  
  ## AR(1)-0.5 [2]
  #  p = 1, \phi_1 = -0.5, 
  else if(n_model == 2) {
    model <- arima.sim(list(order = c(1,0,0), ar = -0.5), T)
    
    for(i in 2:inst_numb)
      model <- cbind(model, arima.sim(list(order = c(1,0,0), ar = -0.5), T))
  }
  
  ## AR(1)0.5 [3]
  #  p = 1, \phi_1 = 0.5
  else if(n_model == 3) {
    model <- arima.sim(list(order = c(1,0,0), ar = 0.5), T)
    
    for(i in 2:inst_numb)
      model <- cbind(model, arima.sim(list(order = c(1,0,0), ar = 0.5), T))
  }
  
  ## AR(2) [4]
  #  p = 2, \phi1_ = 1.5, \phi_2 = -0.75
  else if(n_model == 4) {
    model <- arima.sim(list(order = c(2,0,0), ar =c(1.5,-.75)), n = T)
    
    for(i in 2:inst_numb)
      model <- cbind(model, arima.sim(list(order = c(2,0,0), ar =c(1.5,-.75)), n = T))
  }
  
  ## ARIMA(1,1,0) [5]
  #  p = 1, d = 1, \phi_1 = 0.7
  else if(n_model == 5) {
    model <- arima.sim(list(order = c(1,1,0), ar = 0.7), T)
    
    for(i in 2:inst_numb)
      model <- cbind(model, arima.sim(list(order = c(1,1,0), ar = 0.7), T))
  }
  
  ## ARFIMA(1,0.4,0) [6]
  #  p = 1, d = 0.4, \phi_1 = 0.5
  else if(n_model == 6) {
    model <- as.ts((fracdiff.sim(T, ar = 0.5, d = 0.4))$series)
    
    for(i in 2:inst_numb)
      model <- cbind(model, as.ts((fracdiff.sim(T, ar = 0.5, d = 0.4))$series))
  }
  
  
  ### Nonlinear processes
  
  ## SETAR(1) [7]
  #  p = 1, \alpha = 0.5, \beta = -1.8, \gamma = 2, r = -1
  else if(n_model == 7) {
    model <- simnlts(T, 0.5, -1.8, -1, 1, 2)
    
    for(i in 2:inst_numb)
      model <- cbind(model, simnlts(T, 0.5, -1.8, -1, 1, 2))
  }
  
  ## HMM [8]
  #  Poisson-HMM, N = 2, \lambda = c(10,15)
  else if(n_model == 8) {
    model <- as.ts(HMM_simulation(size = T,
                                  m = 2,
                                  distribution_class = "pois",
                                  distribution_theta = list(lambda=c(10,15)))$observations)
    
    for(i in 2:inst_numb)
      model <- cbind(model, as.ts(HMM_simulation(size = T,
                                                 m = 2,
                                                 distribution_class = "pois",
                                                 distribution_theta = list(lambda=c(10,15)))$observations)
      )
  }
  
  ## INAR(1) [9]
  #  Poisson- INAR, \alpha = 0.5, 
  else if(n_model == 9) {
    model <- geraINAR_Po(T, theta)
    
    for(i in 2:inst_numb)
      model <- cbind(model,geraINAR_Po(T, theta))
  }
  
  ## GARCH(1,1) [10]
  #  \omega = 10^-6, \alpha_1 = 0.1, \beta_1 = 0.8
  else if(n_model == 10) {
    spec <- garchSpec(model = list(omega = 1e-6, alpha = 0.1, beta = 0.8))
    model <- as.ts(garchSim(spec, T))
    
    for(i in 2:inst_numb)
      model <- cbind(model, as.ts(garchSim(spec, T)))
  }
  
  ## EGARCH(1,1) [11]
  #  \omega = 10^-6, \alpha_1 = 0.1, \beta_1 = 0.01, \gamma_1 = 0.3
  else if(n_model == 11) {
    model <- gera_garch(T, 1e-6, 0.1, 0.01, 0.3)
    
    for(i in 2:inst_numb)
      model <- cbind(model, gera_garch(T, 1e-6, 0.1, 0.01, 0.3))
  }
  
  return(model)
  
}
