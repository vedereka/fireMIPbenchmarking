
daily_pc = 100/30.4167
sec_frac = 1/(60*60*24*30)
kgpersec =  sec_frac/1000

###########################################################
## Burnt area                                            ##
###########################################################

Model.Variable  = list( #Line 1  variable name; Line 2  scaling; Line 3 - timestep
            varname  = rbind(c("MODIS", "GFED4"    , "GFED4s"   , "GFED4sSeason", "MODISSeason", "meris"    , "MCD45"    , "GFAS"    , "GFASSeason", "NRfire"  , "meanFire" ),
                             c(1      , 1          , 1          , 1            , 1          , 1          , 1          , kgpersec  , kgpersec    , 1         , 1          ),
                             c('Monthly', 'Monthly'  , 'Monthly'  , 'Monthly'    , 'Monthly'  ,  'Monthly'  , "Monthly"  , 'Monthly' , 'Monthly'   , "Annual"  , "Annual"   ),
                             c(2001  , 1996       , 1998       , 1996         , 1996         , 2006       , 2001       , 2000      , 2000        , 2002      , 2002       ),
                             c('mean', 'mean'     , 'mean'     , "mean"       , "mean"       , "mean"     , "mean"     , "mean"    , "mean"      , "mean"    , "mean"    )),
            CLM      = rbind(c("BAF", "BAF"      , "BAF"      , "BAF"        , "BAF"        , "BAF"      , "BAF"      , "CFFIRE"  , "CFFIRE"    , "nrfire"  , "mean_fire"),
                             c(100, 100        , 100        , 100          , 100          , 100        , 100        , kgpersec  , kgpersec    , 1         , 1          ),
                             c(1850, 1850       , 1850       , 1850         , 1850         , 1850       , 1850       , 1850      , 1850        , 1850      , 1850       ),
                             c('Monthly',  'Monthly'  , 'Monthly'  , "Monthly"    ,  "Monthly"    , 'Monthly'  , "Monthly"  , "Monthly" , "Monthly"   , "Monthly" , "Monthly" )),
            CTEM     = rbind(c("burntArea", "burntArea", "burntArea", "burntArea"  , "burntArea"  , "burntArea", "burntArea", "fFirepft", "fFirepft"  ,"nrfire"  , "mean_fire"),
                             c(100, 100        , 100        , 100          , 100          , 100        , 100        , kgpersec  , kgpersec    , 1         , 1          ),
                             c(1861, 1861       , 1861       , 1861         , 1861         , 1861       , 1861       , 1861      , 1861        , 1861      , 1861       ),
                             c('Monthly'  , 'Monthly'  , 'Monthly'  , "Monthly"    , "Monthly"    , 'Monthly'  , "Monthly"  , "Monthly" , "Monthly"   , "Monthly" , "Monthly" )),
            INFERNO  = rbind(c("burntArea", "burntArea", "burntArea", "burntArea"  , "burntArea"  , "burntArea", "burntArea", "fFirepft", "fFirepft"  , "nfire"   , "mean_fire"),
                             c(sec_frac   , sec_frac   , sec_frac   , sec_frac     , sec_frac     , sec_frac   , sec_frac   , kgpersec  , kgpersec    , 1         , 1          ),
                             c(1700       , 1700       , 1700       , 1700         , 1700         , 1700       , 1700       , 1700      , 1700        , 1700      , 1700       ),
                             c('Monthly'  , 'Monthly'  , 'Monthly'  , "Monthly"    , "Monthly"    , 'Monthly'  , "Monthly"  , "Monthly" , "Monthly"   , "Monthly" , "Monthly" )),
            JSBACH   = rbind(c("burntArea", "burntArea", "burntArea", "burntArea"  ,"burntArea"  , "burntArea", "burntArea", "fFirepft", "fFirepft"  , "nrfire"  , "burntArea%nrfire"),
                             c(rep(daily_pc, 7)                                                 , kgpersec  , kgpersec    , 1E-6      , daily_pc * 1E6),
                             c(1700       , 1700       , 1700       , 1700         , 1700         , 1700       , 1700       , 1700      , 1700        , 1950      , "1700&1950"),
                             c('Monthly'  , 'Monthly'  , 'Monthly'  , "Monthly"    , "Monthly"    , 'Monthly'  , "Monthly"  , "Monthly" , "Monthly"   , "Monthly" , "Monthly"  )),
            LPJglob  = rbind(c("burntArea", "burntArea", "burntArea", "NANA"       , "NANA"       , "burntArea", "burntArea", "Cfire"   , "NANA"      , "nrfire"  , "mean_fire"),
                             c(rep(100, 7)                                                      , kgpersec  , kgpersec    , 1         , 100        ),
                             c(1700       , 1700       , 1700       , 1700       , 1700         , 1700       , 1700       , 1700      , 1700        , 1700      , 1700       ),
                             c('Annual'   , 'Annual'   , "Annual"   , "Annual"   , "Annual"     , 'Annual'   , "Annual"   , "Annual"  , "Annual"    ,  "Annual" , "Annual"  )),
            LPJspit  = rbind(c(rep("BA", 7)                                                     , "fFire"   , "fFire"     , "nrfire"  , "mean_fire"),
                             c(100        , 100        , 100        , 100          , 100          , 100        , 100        , kgpersec  , kgpersec    , 1E-6      , 1E8        ),
                             c(1700       , 1700       , 1700       , 1700         , 1700         , 1700       , 1700       , 1700      , 1700        , 1700      , 1700       ),
                             c('Monthly'  ,'Monthly'  , "Monthly"  , "Monthly"    , "Monthly"    , 'Monthly'  , "Monthly"  , "Monthly" , "Monthly"   , "Monthly" , "Monthly" )),
            LPJblze  = rbind(c("BA"       , "BA"       , "BA"       , "NANA"       , "NANA"       , "BA"       , "BA"       , "Cfire"   , "NANA"      , "nrfire"  , "mean_fire"),
                             c(100        , 100        , 100        , 100          , 100          , 100        , 100        , kgpersec  , kgpersec    , 1         , 100        ),
                             c(1700       , 1700       , 1700       , 1700         , 1700         , 1700       , 1700       , 1700      , 1700        , 1700      , 1700       ),
                             c('Monthly'  , 'Monthly'  , 'Monthly'  , "Monthly"    , "Monthly"    , 'Monthly'  , "Monthly"  , "Monthly" , "Monthly"   , "Monthly" , "Monthly" )),
            MC2      = rbind(c("BA"       , "BA"       , "BA"       , "NANA"       , "NANA"       , "BA"       , "BA"       , "Cfire"   , "NANA"      , "nnfire"  , "mean_fire"),
                             c(rep(100, 7)                                                      , kgpersec  , kgpersec    , 1         , 1          ),
                             c(1901       , 1901       , 1901       , 1901         ,1901         , 1901       , 1901       , 1901      , 1901        , 1901      , 1901       ),
                             c('Annual'   , 'Annual'   , 'Annual'   , "Annual"     , "Annual"     , 'Annual'   , "Annual"   , "Annual"  , "Annual"    , "Annual"  , "Annual"  )),
            ORCHIDEE = rbind(c("burntArea", "burntArea", "burntArea", "burntArea"  , "burntArea"  , "burntArea", "burntArea", "fFire"   , "fFire"     , "nrfire"  , "mean_fire"),
                             c(daily_pc   ,daily_pc   , daily_pc   , daily_pc     , daily_pc     , daily_pc   , daily_pc   , 12*kgpersec, 12*kgpersec, 1E-6/30   , daily_pc * 30E-6),
                             c(1700       , 1700       , 1700       , 1700         , 1700         , 1700       , 1700       , 1700      , 1700        , 1950      , "1950"     ),
                             c('Monthly'  , 'Monthly'  , 'Monthly'  , "Monthly"    , "Monthly"    , 'Monthly'  , "Monthly"  , "Monthly" , "Monthly"   , "Monthly" , "Monthly"  )))


################################################################################
## Plotting Info                                                              ##
################################################################################
FractionBA.Spatial = list(cols    = c('white', "#EE8811", "#FF0000", "#110000"),
                     dcols   = c('#a50026','#d73027','#f46d43','#fdae61','#fee090','#ffffbf','#e0f3f8','#abd9e9','#74add1','#4575b4','#313695'),#c('#0000AA', '#2093FF', '#C0D0FF','white',
                                # '#FFD793', "#F07700", "#AA0000"),
                     limits  = c(0.001,.01,.02,.05,.1,.2),
                     dlimits = c(-0.2,-0.1,-0.05,-0.01,0.01,0.05,0.1, 0.2))
					 
FractionBA.Trend = list(cols    = c('#0000AA', '#2093FF', '#C0D0FF','white',
                                 '#FFD793', "#F07700", "#AA0000"),
                     dcols   = c('#0000AA', '#2093FF', '#C0D0FF','white',
                                 '#FFD793', "#F07700", "#AA0000"),
                     limits  = c(-20, -10, -5, -2, -1, 1, 2, 5, 10, 20),
                     dlimits = c(-20, -10, -5, -2, -1, 1, 2, 5, 10, 20))
					 
FractionBA.Spatial = list(cols    = c('white', "#EE7711", "#FD2200", "#3F0000"),
                     dcols   = c('#000033', '#0066FF','white',
                                 '#FF6600',"#330000"),
                     limits  = c(0.001,.01,.02,.05,.1,.2),
                     dlimits = c(-0.2,-0.1,-0.05,-0.01,-0.005, -0.001, 0.001, 0.005, 0.01,0.05,0.1, 0.2))

FractionBA.IA      = list(x = 1997:2009)
GFED4.IA      = list(x = 1997:2009)

GFED4s.IA     = list(x = 1997:2013)

## GFAS
GFAS          = list(cols    = c('white', "#EE8811", "#FF0000", "#110000"),
                     dcols   = c('#0000AA', '#2093FF', '#C0D0FF','white',
                                 '#FFD793', "#F07700", "#AA0000"),
                     limits  = c(0.01, 0.1, 1, 10, 100),
                     dlimits = c(-100, -10, -1, -0.1, -0.01 ,0.01, 0.1, 1, 10, 100))

## NR
NRfire        = list(cols    = c('white', "#EE8811", "#FF0000", "#110000"),
                     dcols   = c('#0000AA', '#2093FF', '#C0D0FF','white',
                                 '#FFD793', "#F07700", "#AA0000"),
                     limits  = c(0.001,.01,.05,.1,.2,.5),
                     dlimits = c(-0.2,-0.1,-0.05,-0.01,0.01,0.05,0.1, 0.2)*10)
					 
## meanFire
meanFire      = list(cols    = c('white', "#EE8811", "#FF0000", "#110000"),
                     dcols   = c('#0000AA', '#2093FF', '#C0D0FF','white',
                                 '#FFD793', "#F07700", "#AA0000"),
                     limits  = c(0.001,.01,.05,.1,.2,.5) * 10000,
                     dlimits = c(-0.2,-0.1,-0.05,-0.01,0.01,0.05,0.1, 0.2) * 10000)
################################################################################
## Full comparisons info                                                      ##
################################################################################
## GFED4
MODIS.Spatial = list(obsFile       = "MODIS250_q_BA_regridded0.5.nc",
                     obsVarname    = "burnt_area",
                     obsLayers     = 1:108,
                     ComparisonFun = FullNME,
                     plotArgs      = FractionBA.Spatial ,
                     ExtraArgs     = list(mnth2yr = TRUE))
					 
MODIS.Trend    = list(obsFile       = "MODIS250_q_BA_regridded0.5.nc",
                      obsVarname    = "burned_area",
                      obsLayers     = 1:108,
                      obsStart      = 2001,
                      ComparisonFun = FullNME,
                      plotArgs      = FractionBA.Trend,
                      ExtraArgs     = list(zTrend = TRUE))

MODISSeason    = list(obsFile       = "MODIS250_q_BA_regridded0.5.nc",
                      obsVarname    = "burnt_area",
                      obsLayers     = 1:108,
                      obsStart      = 2001,
                      ComparisonFun = FullSeasonal,
                      plotArgs      = TRUE)

MODIS.IA      = list(obsFile       = "MODIS250_q_BA_regridded0.5.nc",
                     obsVarname    = "burnt_area",
                     obsLayers     = 1:108,
                     ComparisonFun = FullNME,
                     plotArgs      = list(x = 2001:2009),
                     ExtraArgs     = list(byZ = TRUE, nZ = 12))

MODIS.Season  = list(obsFile       = "MODIS250_q_BA_regridded0.5.nc",
                     obsVarname    = "burnt_area",
                     obsLayers     = 1:108,
                     ComparisonFun = FullSeasonal,
                     plotArgs      = TRUE)

## GFED4
GFED4.Spatial = list(obsFile       = "Fire_GFEDv4_Burnt_fraction_0.5grid9.nc",
                     obsVarname    = "mfire_frac",
                     obsLayers     = 8:163,
                     ComparisonFun = FullNME,
                     plotArgs      = FractionBA.Spatial ,
                     ExtraArgs     = list(mnth2yr = TRUE))
					 
GFED4.Trend   = list(obsFile       = "Fire_GFEDv4_Burnt_fraction_0.5grid9.nc",
                      obsVarname    = "mfire_frac",
                      obsLayers     = 8:163,
                      obsStart      = 1997,
                      ComparisonFun = FullNME,
                      plotArgs      = FractionBA.Trend,
                      ExtraArgs     = list(zTrend = TRUE))

GFED4.IA      = list(obsFile       = "Fire_GFEDv4_Burnt_fraction_0.5grid9.nc",
                     obsVarname    = "mfire_frac",
                     obsLayers     = 8:163,
                     ComparisonFun = FullNME,
					 plotArgs      = FractionBA.IA,
                     ExtraArgs     = list(byZ = TRUE, nZ = 12))

GFED4.Season  = list(obsFile       = "GFED4.nc",
                     obsVarname    = "mfire_frac",
                     obsLayers     = 1:156,
                     ComparisonFun = FullSeasonal,
                     plotArgs      = TRUE)

##GFED4s
GFED4s.Spatial = list(obsFile       = "GFED4s_v2.nc",
                      obsVarname    = "variable",
                      obsLayers     = 1:156,
                      obsStart      = 1998,
                      ComparisonFun = FullNME,
                      plotArgs      = FractionBA.Spatial,
                      ExtraArgs     = list(mnth2yr = TRUE))
					  
GFED4s.Trend   = list(obsFile       = "GFED4s_v2.nc",
                      obsVarname    = "variable",
                      obsLayers     = 1:156,
                      obsStart      = 1998,
                      ComparisonFun = FullNME,
                      plotArgs      = FractionBA.Trend,
					  inherit       = "GFED4s.Spatial",
                      ExtraArgs     = list(zTrend = TRUE))
					  
GFED4s.Grad    = list(obsFile       = "GFED4s_v2.nc",
                      obsVarname    = "variable",
                      obsLayers     = 1:156,
                      obsStart      = 1998,
                      ComparisonFun = FullGrad,
					  inherit       = "GFED4s.Spatial",
                      plotArgs      = FractionBA.Spatial)
					  
GFED4s.NMDE1    = list(obsFile       = "GFED4s_v2.nc",
                      obsVarname    = "variable",
                      obsLayers     = 1:156,
                      obsStart      = 1998,
                      ComparisonFun = FullNMDE,
                      plotArgs      = FractionBA.Spatial,
					  inherit       = "GFED4s.Spatial",
                      ExtraArgs     = list(mnth2yr = TRUE, scale_fact = 1))

					  
GFED4s.NMDE10    = list(obsFile       = "GFED4s_v2.nc",
                      obsVarname    = "variable",
                      obsLayers     = 1:156,
                      obsStart      = 1998,
                      ComparisonFun = FullNMDE,
                      plotArgs      = FractionBA.Spatial,
					  inherit       = "GFED4s.Spatial",
                      ExtraArgs     = list(mnth2yr = TRUE, scale_fact = 0.1))


					  
GFED4s.NMDE20    = list(obsFile       = "GFED4s_v2.nc",
                      obsVarname    = "variable",
                      obsLayers     = 1:156,
                      obsStart      = 1998,
                      ComparisonFun = FullNMDE,
                      plotArgs      = FractionBA.Spatial,
					  inherit       = "GFED4s.Spatial",
                      ExtraArgs     = list(mnth2yr = TRUE, scale_fact = 0.05))
					  
GFED4s.NMDE50    = list(obsFile       = "GFED4s_v2.nc",
                      obsVarname    = "variable",
                      obsLayers     = 1:156,
                      obsStart      = 1998,
                      ComparisonFun = FullNMDE,
                      plotArgs      = FractionBA.Spatial,
					  inherit       = "GFED4s.Spatial",
                      ExtraArgs     = list(mnth2yr = TRUE, scale_fact = 0.02))

GFED4s.IA      = list(obsFile       = "GFED4s_v2.nc",
                      obsVarname    = "variable",
                      obsLayers     = 1:156,
                      obsStart      = 1998,
                      ComparisonFun = FullNME,
					  plotArgs      = GFED4s.IA,
					  ExtraArgs     = list(byZ = TRUE, nZ = 12))

GFED4sSeason    = list(obsFile = "GFED4s_v2.nc",
                      obsVarname    = "variable",
                      obsLayers     = 1:156,
                      obsStart      = 1997,
                      ComparisonFun = FullSeasonal,
                      plotArgs      = TRUE)

## GFAS
GFAS           = list(obsFile       = "GFAS.nc",
                      obsVarname    = "cfire",
                      obsLayers     = 1:108,
                      obsStart      = 2000,
                      ComparisonFun = FullNME,
                      plotArgs      = GFAS,
                      ExtraArgs     = list(mnth2yr = TRUE))

## GFAS
GFASSeason     = list(obsFile       = "GFAS.nc",
                      obsVarname    = "cfire",
                      obsLayers     = 1:108,
                      obsStart      = 2000, 
                      ComparisonFun = FullSeasonal,
                      plotArgs      = TRUE)

GFAS.IA       = list(obsFile       = "GFAS.nc",
                     obsVarname    = "cfire",
                     obsLayers     = 1:108,
                     obsStart      = 2000,
                     ComparisonFun = FullNME,
                     plotArgs      = list(x = 2000:2008),
                     ExtraArgs     = list(byZ = TRUE, nZ = 12))
					 
## Meris
meris.Spatial  = list(obsFile       = "meris.nc",
                      obsVarname    = "variable",
                      obsLayers     = 1:36,
                      obsStart      = 2006,
                      ComparisonFun = FullNME,
                      plotArgs      = FractionBA.Spatial,
                      ExtraArgs     = list(mnth2yr = TRUE))
					  
					  
meris.Season   = list(obsFile       = "meris.nc",
                      obsVarname    = "variable",
                      obsLayers     = 1:36,
                      obsStart      = 2006, 
                      ComparisonFun = FullSeasonal,
                      plotArgs      = TRUE)

## MCD45
MCD45.Spatial  = list(obsFile       = "MCD45.nc",
                      obsVarname    = "variable",
                      obsLayers     = 1:96,
                      obsStart      = 2001,
                      ComparisonFun = FullNME,
                      plotArgs      = FractionBA.Spatial,
                      ExtraArgs     = list(mnth2yr = TRUE))

					  
MCD45.Trend   = list(obsFile       = "MCD45.nc",
                      obsVarname    = "variable",
                      obsLayers     = 1:96,
                      obsStart      = 2001,
                      ComparisonFun = FullNME,
                      plotArgs      = FractionBA.Trend,
					  inherit       = "MCD45.Spatial",
                      ExtraArgs     = list(zTrend = TRUE))
					  
MCD45.Season   = list(obsFile       = "MCD45.nc",
                      obsVarname    = "variable",
                      obsLayers     = 1:96,
                      obsStart      = 2001, 
                      ComparisonFun = FullSeasonal,
                      plotArgs      = TRUE)
					  
MCD45.IA       = list(obsFile       = "MCD45.nc",
                      obsVarname    = "variable",
                      obsLayers     = 1:96,
                      obsStart      = 2001,
                      ComparisonFun = FullNME,
                      plotArgs      = list(x = 2001:2008),
                      ExtraArgs     = list(byZ = TRUE, nZ = 12))
					  
NRfire        = list(obsFile       = "NRfire-nr_fire.nc",
                     obsLayers     = 1:9,
                     ComparisonFun = FullNME,
                     plotArgs      = NRfire)
					 
meanFire        = list(obsFile       = "NRfire-mean_fire.nc",
                     obsLayers     = 1:9,
                     ComparisonFun = FullNME,
                     plotArgs      = meanFire)
