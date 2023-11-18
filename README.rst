How to configure a nudged simulation using E3SM 
=================================================


Nudging configuration (for E3SMv2) 
------------------------------------------------------------

The following variables need to be modified to activate nudging. 
The example shown below switches on nudging for horizontal winds :: 

 cat <<EOF >> user_nl_cam
  !.......................................................
  ! Nudging setup 
  !.......................................................
  Nudge_Model          = .True.
  Nudge_Path           = '${path_nudging_data}'
  Nudge_File_Template  = '${casename}.h1.%y-%m-%d-00000.nc'
  Nudge_Times_Per_Day  = 4        !! nudging input data frequency
  Model_Times_Per_Day  = 48       !! should not be larger than 48 if dtime = 1800s
  Nudge_Uprof          = 1        !! 2 if nudging tendency has a vertical profile 
  Nudge_Ucoef          = 1.
  Nudge_Vprof          = 1
  Nudge_Vcoef          = 1.
  Nudge_Tprof          = 0
  Nudge_Tcoef          = 0.
  Nudge_Qprof          = 0
  Nudge_Qcoef          = 0.
  Nudge_PSprof         = 0
  Nudge_PScoef         = 0.
  Nudge_Beg_Year       = 0001
  Nudge_Beg_Month      = 1
  Nudge_Beg_Day        = 1
  Nudge_End_Year       = 9999
  Nudge_End_Month      = 1
  Nudge_End_Day        = 1
  Nudge_Vwin_Lindex    = 0.       !! activated only when Nudge_Xprof = 2 !! X = U, V, T 
  Nudge_Vwin_Hindex    = 70.      !! activated only when Nudge_Xprof = 2 
  Nudge_Vwin_Ldelta    = 0.1.     !! activated only when Nudge_Xprof = 2 
  Nudge_Vwin_Hdelta    = 0.1.     !! activated only when Nudge_Xprof = 2 
  Nudge_Vwin_lo        = 0.       !! activated only when Nudge_Xprof = 2 
  Nudge_Vwin_hi        = 1.       !! activated only when Nudge_Xprof = 2 
  Nudge_Method         = 'Linear' !!  
  Nudge_Tau            = 6.       !! relaxation time scale, unit: h 
  Nudge_Loc_PhysOut    = .True.   !! nudging tendency calculated before radiation 
  Nudge_File_Ntime     = 4        !! should be the same as Nudge_Times_Per_Day or 1 (see code for details) 
  Nudge_Allow_Missing_File = .False. 

 EOF

This setup will nudge the model towards a baseline E3SM simulation. The nudging data were 
created from the baseline simulation by archiving the 6-hourly meteorological fields. 
Only the horizontal winds are nudged, with a relaxation time scale of 6h. The 
nudging is applied at every grid box.  
More detailed information on how to setup a nudged simulation can be found in the 
source code `nudging.F90 <https://github.com/E3SM-Project/E3SM/blob/master/components/eam/src/physics/cam/nudging.F90>`_. 




Creating nudging files from a baseline simulation 
------------------------------------------------------------
 
To nudge the model towards a baseline model simulation (e.g. E3SMv1), you will need to 
run the reference model first and output U,V,T,Q,PS 6-hourly: :: 
 
  cat <<EOF >> user_nl_cam
     nhtfrq  = 0,-6
     mfilt   = 1,1
     fincl2  = ‘PS’,’U,’V’,’T’,’Q’,
     avgflag_pertape(2) = 'I'
  EOF


Creating nudging files from reanalysis 
------------------------------------------------------------

Under construction ...  



Verification 
------------------------------------------------------------

To verify whether nudging works, we often output 6-hourly model data for a whole month and calculate the anomaly (instantaneous – monthly mean). Then we compare the anomaly with that calculated from the reanalysis data and calculate the anomaly correlation. If the correlation is high (as shown by `Zhang et al. (2014) <https://doi.org/10.5194/acp-14-8631-2014>`_ and `Sun et al. (2019) <https://agupubs.onlinelibrary.wiley.com/doi/full/10.1029/2019MS001831>`_ ), it indicates nudging is effective.

The purpose of most nudging applications is to constrain the large-scale circulation so that the model can capture the synoptic weather events, e.g., you should be able to see similar day-to-day variations in meterological fields between the nudged model and reanalysis.


References 
--------------------------------------------------------------------------------
- Sun, J., Zhang, K., Wan, H., Ma, P.-L., Tang, Q., Zhang, S. (2019), Impact of nudging strategy on the climate representativeness and hindcast skill of constrained EAMv1 simulations, Journal of Advances in Modeling Earth Systems, `doi: 10.1029/2019MS001831  <https://agupubs.onlinelibrary.wiley.com/doi/full/10.1029/2019MS001831>`_.

- Zhang, K., Wan, H., Liu, X., Ghan, S. J., Kooperman, G. J., Ma, P.-L., Rasch, P. J., Neubauer, D., and Lohmann, U. (2014): Technical Note: On the use of nudging for aerosol–climate model intercomparison studies, Atmos. Chem. Phys., 14, 8631–8645, `doi: 10.5194/acp-14-8631-2014  <https://doi.org/10.5194/acp-14-8631-2014>`_.

- Zhang, S., Zhang, K., Wan, H., and Sun, J.: Further improvement and evaluation of nudging in the E3SM Atmosphere Model version 1 (EAMv1), Geosci. Model Dev. Discuss. [preprint], https://doi.org/10.5194/gmd-2022-10, in review, 2022.

- Liu, Y., Zhang, K., Qian, Y., Wang, Y., Zou, Y., Song, Y., Wan, H., Liu, X., and Yang, X.-Q.: Investigation of short-term effective radiative forcing of fire aerosols over North America using nudged hindcast ensembles, Atmos. Chem. Phys., 18, 31–47, https://doi.org/10.5194/acp-18-31-2018, 2018. 

- Lin, G., Wan, H., Zhang, K., Qian, Y., and Ghan, S. J. (2016), Can nudging be used to quantify model sensitivities in precipitation and cloud forcing?, J. Adv. Model. Earth Syst., 8, 1073-1091, https://doi.org/10.1002/2016MS000659. 

- Kooperman, G. J., Pritchard, M. S., Ghan, S. J., Wang, M., Somerville, R. C. J., and Russell, L. M. (2012), Constraining the influence of natural variability to improve estimates of global aerosol indirect effects in a nudged version of the Community Atmosphere Model 5, J. Geophys. Res., 117, D23204, https://doi.org/10.1029/2012JD018588. 



