############################################################################
############################################################################
###                                                                      ###
###                      Setup Environmental Paths                       ###
###                                                                      ###
############################################################################
############################################################################
start_date <- "2012/01/01"
end_date <- "2021/12/31"

#setup working space
outdir <- "/projectnb/dietzelab/dongchen/All_NEON_SDA/NEON42/SDA"
SDA_run_dir <- "/projectnb/dietzelab/dongchen/All_NEON_SDA/NEON42/SDA/run"
SDA_out_dir <- "/projectnb/dietzelab/dongchen/All_NEON_SDA/NEON42/SDA/out"

ERA5_dir <- "/projectnb/dietzelab/dongchen/All_NEON_SDA/NEON42/ERA5_2012_2021/"
XML_out_dir <- "/projectnb/dietzelab/dongchen/All_NEON_SDA/NEON42/SDA/pecan.xml"

pft_csv_dir <- "/projectnb/dietzelab/dongchen/All_NEON_SDA/NEON42/site_pft.csv"

#Obs_prep part
#AGB
AGB_indir <- "/projectnb/dietzelab/dongchen/Multi-site/download_500_sites/AGB"
allow_download <- TRUE
AGB_export_csv <- TRUE
AGB_timestep <- list(unit="year", num=1)

#LAI
LAI_search_window <- 30
LAI_timestep <- list(unit="year", num=1)
LAI_export_csv <- TRUE
run_parallel <- TRUE

#SMP
SMP_search_window <- 30
SMP_timestep <- list(unit="year", num=1)
SMP_export_csv <- TRUE
update_csv <- FALSE

#SoilC
SoilC_timestep <- list(unit="year", num=1)
SoilC_export_csv <- TRUE

#Obs Date
obs_start_date <- "2012-07-15"
obs_end_date <- "2021-07-15"
obs_outdir <- "/projectnb/dietzelab/dongchen/All_NEON_SDA/test_OBS"
timestep <- list(unit="year", num=1)

#Start building template
template <- PEcAn.settings::Settings(list(
  ############################################################################
  ############################################################################
  ###                                                                      ###
  ###                     STATE DATA ASSIMILATION PART                     ###
  ###                                                                      ###
  ############################################################################
  ############################################################################
  state.data.assimilation = structure(list(
    process.variance = TRUE,
    adjustment = TRUE,
    censored.data = FALSE,
    FullYearNC = TRUE,
    NC.Overwrite = FALSE,
    NC.Prefix = "sipnet.out",
    q.type = "SINGLE",
    Localization.FUN = "Local.support",
    scalef = 1,
    chains = 5,
    data = structure(list(format_id = 1000000040, input.id = 1000013298)),
    state.variables = structure(list(
      #you could add more state variables here
      variable = structure(list(variable.name = "AbvGrndWood", unit = "MgC/ha", min_value = 0, max_value = 9999)),
      variable = structure(list(variable.name = "LAI", unit = "", min_value = 0, max_value = 9999)),
      variable = structure(list(variable.name = "SoilMoistFrac", unit = "", min_value = 0, max_value = 1)),#soilWFracInit
      variable = structure(list(variable.name = "TotSoilCarb", unit = "kg/m^2", min_value = 0, max_value = 9999))
    )),
    forecast.time.step = "year",
    start.date = start_date,
    end.date = end_date,
    
    Obs_Prep = structure(list(
      Landtrendr_AGB = structure(list(AGB_indir = AGB_indir, timestep = AGB_timestep, allow_download = allow_download, export_csv = AGB_export_csv)),
      MODIS_LAI = structure(list(search_window = LAI_search_window, timestep = LAI_timestep, export_csv = LAI_export_csv, run_parallel = run_parallel)),
      SMAP_SMP = structure(list(search_window = SMP_search_window, timestep = SMP_timestep, export_csv = SMP_export_csv, update_csv = update_csv)),
      Soilgrids_SoilC = structure(list(timestep = SoilC_timestep, export_csv = SoilC_export_csv)),
      start.date = obs_start_date,
      end.date = obs_end_date,
      outdir = obs_outdir,
      timestep = timestep
    ))
  )),
  
  ###########################################################################
  ###########################################################################
  ###                                                                     ###
  ###                              INFO PART                              ###
  ###                                                                     ###
  ###########################################################################
  ###########################################################################
  info = structure(list(
    notes = NULL, userid = "-1", username = "",
    date = "2017/12/06 21:19:33 +0000"
  )),
  
  ###########################################################################
  ###########################################################################
  ###                                                                     ###
  ###                               DIR PART                              ###
  ###                                                                     ###
  ###########################################################################
  ###########################################################################
  outdir = outdir,
  rundir = SDA_run_dir,
  modeloutdir = SDA_out_dir,
  
  ###########################################################################
  ###########################################################################
  ###                                                                     ###
  ###                              BETY PART                              ###
  ###                                                                     ###
  ###########################################################################
  ###########################################################################
  database = structure(list(
    bety = structure(
      list(user = "bety", password = "bety", host = "128.197.168.114",
           dbname = "bety", driver = "PostgreSQL", write = "FALSE"
      ))
  )),
  
  ###########################################################################
  ###########################################################################
  ###                                                                     ###
  ###                              PFT PARTS                              ###
  ###                                                                     ###
  ###########################################################################
  ###########################################################################
  pfts = structure(list(
    #you could add more pfts you needed and make sure to modify the outdir of each pft!!!
    pft = structure(
      list(name = "temperate.deciduous.HPDA", 
           constants = structure(list(num = "1")), 
           posteriorid = "1000022311", 
           outdir = "/fs/data2/output//PEcAn_1000010530/pft/temperate.deciduous.HPDA"
      )),
    
    pft = structure(
      list(name = "boreal.coniferous",
           outdir = "/projectnb/dietzelab/hamzed/SDA/ProductionRun/50Sites/SDA_50Sites_1000008768/pft/Conifer/boreal.coniferous"
      )),
    
    pft = structure(
      list(name = "semiarid.grassland_HPDA",
           constants = structure(list(num = "1")),
           posteriorid = "1000016525",
           outdir = "/projectnb/dietzelab/hamzed/SDA/ProductionRun/50Sites/SDA_50Sites_1000008768/pft/GrassA/semiarid.grassland"
      ))
  )),
  
  ############################################################################
  ############################################################################
  ###                                                                      ###
  ###                          META ANALYSIS PART                          ###
  ###                                                                      ###
  ############################################################################
  ############################################################################
  meta.analysis = structure(list(
    iter = "3000", random.effects = FALSE
  )),
  
  ###########################################################################
  ###########################################################################
  ###                                                                     ###
  ###                            ENSEMBLE PART                            ###
  ###                                                                     ###
  ###########################################################################
  ###########################################################################
  ensemble = structure(list(size = 25, variable = "NPP", 
                            samplingspace = structure(list(
                              parameters = structure(list(method = "lhc")),
                              met = structure(list(method = "sampling"))
                            ))
  )),
  
  ############################################################################
  ############################################################################
  ###                                                                      ###
  ###                              MODEL PART                              ###
  ###                                                                      ###
  ############################################################################
  ############################################################################
  model = structure(list(id = "1000000022",
                         type = "SIPNET",
                         revision = "ssr",
                         delete.raw = FALSE,
                         binary = "/usr2/postdoc/istfer/SIPNET/trunk//sipnet_if",
                         jobtemplate = "~/sipnet_geo.job"
  )),
  
  ###########################################################################
  ###########################################################################
  ###                                                                     ###
  ###                              HOST PART                              ###
  ###                                                                     ###
  ###########################################################################
  ###########################################################################
  #be carefull of the host section, you need to specify the host of your own!!!
  host = structure(list(
    name = "geo.bu.edu",
    usr = "zhangdc",
    folder = "/projectnb/dietzelab/dongchen/All_NEON_SDA/NEON42/SDA/out",
    prerun = "module load R/4.1.2",
    cdosetup = "module load cdo/2.0.6",
    qsub = "qsub -l h_rt=24:00:00 -q &apos;geo*&apos; -N @NAME@ -o @STDOUT@ -e @STDERR@ -S /bin/bash",
    qsub.jobid = "Your job ([0-9]+) .*",
    qstat = "qstat -j @JOBID@ || echo DONE",
    tunnel = "~/Tunnel/Tunnel",
    outdir = "/projectnb/dietzelab/dongchen/All_NEON_SDA/NEON42/SDA/out",
    rundir = "/projectnb/dietzelab/dongchen/All_NEON_SDA/NEON42/SDA/run"
  )),
  
  ############################################################################
  ############################################################################
  ###                                                                      ###
  ###                          SETTINGS INFO PART                          ###
  ###                                                                      ###
  ############################################################################
  ############################################################################
  settings.info = structure(list(
    deprecated.settings.fixed = TRUE,
    settings.updated = TRUE,
    checked = TRUE
  )),
  
  ############################################################################
  ############################################################################
  ###                                                                      ###
  ###                               RUN PART                               ###
  ###                                                                      ###
  ############################################################################
  ############################################################################
  run = structure(list(
    inputs = structure(list(
      met = structure(list(
        source = "ERA5", 
        output = "SIPNET",
        id = "",
        path = ERA5_dir
      )),
      
      #Saved for latter use of initial condition files.
      # poolinitcond = structure(list(source = "NEON_veg",
      #                               output = "poolinitcond",
      #                               ensemble = 31,
      #                               path = "/projectnb/dietzelab/ahelgeso/NEON_ic_data/Harvard/April15/"
      #                               )),
      # soilinitcond = structure(list(path = "/projectnb/dietzelab/ahelgeso/EFI_Forecast_Challenge/"
      #                               )),
      pft.site = structure(list(path = "/projectnb/dietzelab/dongchen/All_NEON_SDA/NEON42/site_pft.csv"))
    ))
  ))
))

############################################################################
############################################################################
###                                                                      ###
###                Using Site Group to create the Settings               ###
###                                                                      ###
############################################################################
############################################################################

sitegroupId <- 1000000031
nSite <- 39

multiRunSettings <- PEcAn.settings::createSitegroupMultiSettings(
  template,
  sitegroupId = sitegroupId,
  nSite = nSite)
if(file.exists(XML_out_dir)){
  unlink(XML_out_dir)
}
PEcAn.settings::write.settings(multiRunSettings, outputfile = "pecan.xml")

#here we re-read the xml file to fix issues of some special character within the Host section.
tmp = readChar(XML_out_dir,100000000)
tmp = gsub("&amp;","&",tmp)
writeChar(tmp, XML_out_dir)

settings <- PEcAn.settings::read.settings(XML_out_dir)

#iteratively grab ERA5 paths for each site
for (i in 1:nSite) {
  temp_ERA5_path <- settings[[i]]$run$inputs$met$path
  temp_site_id <- settings[[i]]$run$site$id
  temp_full_paths <- list.files(path=paste0(temp_ERA5_path, temp_site_id), pattern = '*.clim', full.names = T)
  
  #need a better way to code it up
  #test works!!!!
  #populated IC file paths into settings
  Create_mult_list <- function(list.names, paths){
    out <- as.list(paths)
    names(out) <- list.names
    out
  }
  settings[[i]]$run$inputs$met$path <- Create_mult_list(rep("path", length(temp_full_paths)), temp_full_paths)
  
  #code on met_start and met_end
  settings[[i]]$run$site$met.start <- start_date
  settings[[i]]$run$site$met.end <- end_date
  settings[[i]]$run$start.date <- start_date
  settings[[i]]$run$end.date <- end_date
}

#add Lat and Lon to each site
#grab Site IDs from settings
site_ID <- c()
for (i in 1:length(settings)) {
  obs <- settings[[i]]$run$site$id
  site_ID <- c(site_ID,obs)
}
#query site info
#open a connection to bety and grab site info based on site IDs
con <- PEcAn.DB::db.open(settings$database$bety)
site_info <- db.query(paste("SELECT *, ST_X(ST_CENTROID(geometry)) AS lon,
                                      ST_Y(ST_CENTROID(geometry)) AS lat 
                           FROM sites WHERE id IN (",paste(site_ID,collapse=", "),")"),con = con)

#write Lat and Lon into the settings
for (i in 1:nSite) {
  temp_ID <- settings[[i]]$run$site$id
  index_site_info <- which(site_info$id==temp_ID)
  settings[[i]]$run$site$lat <- site_info$lat[index_site_info]
  settings[[i]]$run$site$lon <- site_info$lon[index_site_info]
  settings[[i]]$run$site$name <- site_info$sitename[index_site_info]#temp_ID
}

#####
unlink(paste0(settings$outdir,"/pecan.xml"))
PEcAn.settings::write.settings(settings, outputfile = "pecan.xml")

#test create site pft function
#read the settings already done previously
settings <- PEcAn.settings::read.settings(file.path(settings$outdir, "pecan.xml"))