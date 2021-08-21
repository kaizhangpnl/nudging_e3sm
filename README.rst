How to configure a nudged simulation using E3SM 
=================================================


Nudging configuration  
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
  Nudge_Uprof          = 1
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
  Nudge_File_Ntime     = 4        !! should be the same as Nudge_Times_Per_Day 
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



Reference
--------------------------------------------------------------------------------
Sun, J., Zhang, K., Wan, H., Ma, P.-L., Tang, Q., Zhang, S. (2019), Impact of nudging strategy on the climate representativeness and hindcast skill of constrained EAMv1 simulations, Journal of Advances in Modeling Earth Systems, `doi: 10.1029/2019MS001831  <https://agupubs.onlinelibrary.wiley.com/doi/full/10.1029/2019MS001831>`_.


