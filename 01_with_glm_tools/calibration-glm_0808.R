
setwd(dirname(rstudioapi::getSourceEditorContext()$path))

setwd('./example')

# overview of files for this workshop
#list.files()

# install these packages:
# install.packages("devtools")
# require(devtools)
# devtools::install_github("robertladwig/GLM3r", ref = "v3.1.1")
# devtools::install_github("USGS-R/glmtools")
# install.packages("rLakeAnalyzer")
# install.packages("tidyverse")

#devtools::install_github("GLEON/GLM3r")

# we will need these packages
library(glmtools)
library(GLM3r)
library(rLakeAnalyzer)
library(tidyverse)
library(lubridate)

#.libPaths()
#find_rtools()

# check out which R version we're currently using
glm_version()

#### Example 1: reading the namelist file into R  ####
glm_template = 'glm3-template.nml' 
sim_folder <- getwd()
#print(sim_folder)
out_file <- file.path(sim_folder, "output","output.nc")
#print(out_file)


glm_template = 'glm3-template.nml' 
file.copy(glm_template, 'glm3.nml', overwrite = TRUE)
nml_file <- file.path(sim_folder, 'glm3.nml')

Sys.setenv(TZ = "UTC") # to avoid the 'Etc/GMT--1 errors'

field_data <- file.path(sim_folder,"bcs","corrected_testing_field_data.csv")


# run GLM
GLM3r::run_glm(sim_folder, verbose = T)


# slide changes to adjust the y-axes, but it still doenst look realistic
plot_var(nc_file = out_file, 
         var_name = 'temp',
         zlim = c(0, 35),
         shiftPalette = c(10,0.1,10))
plot_var_compare(nc_file = out_file, 
                 field_file = field_data, 
                 var_name = 'temp',
                 zlim = c(0, 35),
                 method = 'match')

#### Example 3: calibrating water temperature parameters ####

temp_rmse <- compare_to_field(nc_file = out_file, 
                              field_file = field_data,
                              metric = 'water.temperature', 
                              as_value = FALSE, 
                              precision= 'hours')

print(paste('Total time period (uncalibrated):',round(temp_rmse,2),'deg C RMSE'))

var = 'temp'         # variable to which we apply the calibration procedure
path = getwd()       # simulation path/folder
nml_file = nml_file  # path of the nml configuration file that you want to calibrate on
glm_file = nml_file # # path of the gml configuration file


calib_setup <- data.frame('pars' = as.character(c('coef_mix_conv','coef_wind_stir','coef_mix_turb','coef_mix_shear','coef_mix_KH','coef_mix_hyp',
                                                  'wind_factor','rain_factor',
                                                  'sw_factor','lw_factor','at_factor','rh_factor',
                                                  'ce','ch','cd')),
                          'lb' = c(0.01,0.15,0.25,0.11,0.2,0.2,0.6,0.9,0.95,0.95,0.95,0.95,0.001,0.001,0.001),
                          'ub' = c(0.4,0.3,0.7,0.5,0.5,0.8,1.1,1.1,1.15,1.8,1.1,1.1,0.003,0.003,0.003),
                          'x0' = c(0.05,0.17,0.28,0.12,0.25,0.25,0.7,0.95,0.95,0.95,0.95,0.95,0.001,0.001,0.001))

print(calib_setup)
glmcmd = NULL        # command to be used, default applies the GLM3r function
# glmcmd = '/Users/robertladwig/Documents/AquaticEcoDynamics_gfort/GLM/glm'        # custom path to executable
# Optional variables
first.attempt = TRUE # if TRUE, deletes all local csv-files that stores the 
#outcome of previous calibration runs
period = get_calib_periods(nml_file, ratio = 2) # define a period for the calibration, 
# this supports a split-sample calibration (e.g. calibration and validation period)
# the ratio value is the ratio of calibration period to validation period
print(period)
scaling = TRUE       # scaling of the variables in a space of [0,10]; TRUE for CMA-ES
verbose = TRUE
method = 'CMA-ES'    # optimization method, choose either `CMA-ES` or `Nelder-Mead`
metric = 'RMSE'      # objective function to be minimized, here the root-mean square error
target.fit = 2.0     # refers to a target fit of 2.0 degrees Celsius (stops when RMSE is below that)
target.iter = 1000    # refers to a maximum run of 20 calibration iterations (stops after that many runs)
plotting = TRUE      # if TRUE, script will automatically save the contour plots
output = out_file    # path of the output file
field_file = field_data # path of the field data
conversion.factor = 1 # conversion factor for the output, e.g. 1 for water temp.

calibrate_sim(var = 'temp', path = getwd(), 
              field_file = field_file, 
              nml_file = 'glm3.nml',
              glm_file = 'glm3.nml',
              calib_setup = calib_setup, 
              glmcmd = NULL, first.attempt = TRUE, 
              period = period, 
              scaling = TRUE, method = 'CMA-ES', metric = 'RMSE', 
              target.fit = target.fit, target.iter = target.iter, 
              plotting = TRUE, 
              output = output, 
              verbose = TRUE,
              conversion.factor = 1)


field <- read_field_obs(field_file, var_name='temp')
field %>% filter(Depth == 8.5) %>%
  ggplot() + geom_line(aes(DateTime, temp))

data = resample_to_field(nc_file = 'output/output.nc', field_file = field_file)
sqrt(sum((data$Observed_temp - data$Modeled_temp)^2, na.rm = T)/(nrow(data)))

temp_rmse <- compare_to_field(nc_file = out_file, 
                              field_file = field_data,
                              metric = 'water.temperature', 
                              as_value = FALSE, 
                              precision= 'hours')
print(temp_rmse)
