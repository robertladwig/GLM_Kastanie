# GLM_Kastanie
General Lake Model for a pond


- The folder 01 is the GLM version 3.1.1 with using R, GLM3r, glmtools, etc.
- The folder 02 is the GLM version 3.1.9 with executable


the 3.1.9 has worked and created output files

the 3.1.1 version is not working currently: 


> GLM3r::run_glm(sim_folder, verbose = T)

     Reading configuration from glm3.nml
     VolAtCrest= 35495.40535; MaxVol= 35495.40535 (m3)
     No 'sediment' section, turning off sediment heating
Warning in met file, snowice is enabled but Snow column not found!
     
    -------------------------------------------------------
    |  General Lake Model (GLM)   Version 3.1.1           |
    -------------------------------------------------------
     
     glm built using MSC version 1916

     nDays= 380; timestep= 3600.000000 (s)
     Maximum lake depth is 11.500000
     Depth where flow will occur over the crest is 11.500000

     Wall clock start time :  Tue Aug  8 18:01:00 2023

     Simulation begins...
     Running day  2459275, 100.00% of days complete

     Wall clock finish time : Tue Aug  8 18:01:00 2023
     Wall clock runtime was 0 seconds : 00:00:00 [hh:mm:ss]

    Model Run Complete
    -------------------------------------------------------

[1] 0

**Important Note 1:**
The runtime is too short and it doesn't create any new output.

**Important Note 2:**
The output of the `calibration_sim` function can't be right either, since it creates the same RMSE over and over again:


[1] "RMSE 2.601"

     Reading configuration from glm3.nml
     VolAtCrest= 35495.40535; MaxVol= 35495.40535 (m3)
     No 'sediment' section, turning off sediment heating
Warning in met file, snowice is enabled but Snow column not found!
     
    -------------------------------------------------------
    |  General Lake Model (GLM)   Version 3.1.1           |
    -------------------------------------------------------
     
     glm built using MSC version 1916

     nDays= 380; timestep= 3600.000000 (s)
     Maximum lake depth is 11.500000
     Depth where flow will occur over the crest is 11.500000

     Wall clock start time :  Tue Aug  8 18:01:27 2023

     Simulation begins...
     Running day  2459179, 100.00% of days complete

     Wall clock finish time : Tue Aug  8 18:01:27 2023
     Wall clock runtime was 0 seconds : 00:00:00 [hh:mm:ss]

    Model Run Complete
    -------------------------------------------------------

[1] "RMSE 2.601"

     Reading configuration from glm3.nml
     VolAtCrest= 35495.40535; MaxVol= 35495.40535 (m3)
     No 'sediment' section, turning off sediment heating
Warning in met file, snowice is enabled but Snow column not found!
     
    -------------------------------------------------------
    |  General Lake Model (GLM)   Version 3.1.1           |
    -------------------------------------------------------
     
     glm built using MSC version 1916

     nDays= 380; timestep= 3600.000000 (s)
     Maximum lake depth is 11.500000
     Depth where flow will occur over the crest is 11.500000

     Wall clock start time :  Tue Aug  8 18:01:27 2023

     Simulation begins...
     Running day  2459179, 100.00% of days complete

     Wall clock finish time : Tue Aug  8 18:01:27 2023
     Wall clock runtime was 0 seconds : 00:00:00 [hh:mm:ss]

    Model Run Complete
    -------------------------------------------------------

Saving 9.05 x 6.44 in image

     Reading configuration from glm3.nml
     VolAtCrest= 35495.40535; MaxVol= 35495.40535 (m3)
     No 'sediment' section, turning off sediment heating
Warning in met file, snowice is enabled but Snow column not found!
Saving 9.05 x 6.44 in image

     Reading configuration from glm3.nml
     VolAtCrest= 35495.40535; MaxVol= 35495.40535 (m3)
     No 'sediment' section, turning off sediment heating
Warning in met file, snowice is enabled but Snow column not found!
     
    -------------------------------------------------------
    |  General Lake Model (GLM)   Version 3.1.1           |
    -------------------------------------------------------
     
     glm built using MSC version 1916

     nDays= 380; timestep= 3600.000000 (s)
     Maximum lake depth is 11.500000
     Depth where flow will occur over the crest is 11.500000

     Wall clock start time :  Tue Aug  8 18:01:33 2023

     Simulation begins...
     Running day  2459275, 100.00% of days complete

     Wall clock finish time : Tue Aug  8 18:01:33 2023
     Wall clock runtime was 0 seconds : 00:00:00 [hh:mm:ss]

    Model Run Complete
    -------------------------------------------------------

Saving 9.05 x 6.44 in image
[1] "calibration: 2.6  RMSE"
[1] "validation: 2.6  RMSE"
[1] "total time period: 2.6  RMSE"
             pars    lb    ub    x0 calibrated
1   coef_mix_conv 0.010 0.400 0.050     0.2018
2  coef_wind_stir 0.150 0.300 0.170     0.2339
3   coef_mix_turb 0.250 0.700 0.280     0.2873
4  coef_mix_shear 0.110 0.500 0.120     0.2767
5     coef_mix_KH 0.200 0.500 0.250     0.5000
6    coef_mix_hyp 0.200 0.800 0.250     0.2000
7     wind_factor 0.600 1.100 0.700     0.6000
8     rain_factor 0.900 1.100 0.950     0.9954
9       sw_factor 0.950 1.150 0.950     1.0607
10      lw_factor 0.950 1.800 0.950     0.9500
11      at_factor 0.950 1.100 0.950     0.9500
12      rh_factor 0.950 1.100 0.950     1.0876
13             ce 0.001 0.003 0.001     0.0013
14             ch 0.001 0.003 0.001     0.0010
15             cd 0.001 0.003 0.001     0.0015
             pars    lb    ub    x0 calibrated
1   coef_mix_conv 0.010 0.400 0.050     0.2018
2  coef_wind_stir 0.150 0.300 0.170     0.2339
3   coef_mix_turb 0.250 0.700 0.280     0.2873
4  coef_mix_shear 0.110 0.500 0.120     0.2767
5     coef_mix_KH 0.200 0.500 0.250     0.5000
6    coef_mix_hyp 0.200 0.800 0.250     0.2000
7     wind_factor 0.600 1.100 0.700     0.6000
8     rain_factor 0.900 1.100 0.950     0.9954
9       sw_factor 0.950 1.150 0.950     1.0607
10      lw_factor 0.950 1.800 0.950     0.9500
11      at_factor 0.950 1.100 0.950     0.9500
12      rh_factor 0.950 1.100 0.950     1.0876
13             ce 0.001 0.003 0.001     0.0013
14             ch 0.001 0.003 0.001     0.0010
15             cd 0.001 0.003 0.001     0.0015
There were 29 warnings (use warnings() to see them)
> 
