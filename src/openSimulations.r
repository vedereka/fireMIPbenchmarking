openSimulations <- function(name, varnN,  ...)
    mapply(openSimulation,  Model.Variable[-1], Model.RAW,
           MoreArgs = list(name, varnN, ...))


openSimulation <- function(modInfo, rawInfo, name, varnN, layers) {
    varInfo = Model.Variable[[1]][,varnN]
    modInfo = modInfo[,varnN]
    dat = openModel(varInfo, modInfo, rawInfo, layers)
    return(dat)
}

openModel <- function(varInfo, modInfo, rawInfo, layers) {
    if (modInfo[1] == "NULL") return(NULL)

    c(modLayers, layersIndex) :=
        calculateLayersFromOpening(varInfo, modInfo, layers, modInfo[3])

    tempFile = paste(c(temp_dir, '/processed',  modInfo,
                     min(layers), '-', max(layers), '.nc'), collapse = '')

    if (file.exists(tempFile)) dat = brick(tempFile)
    else dat = process.RAW(rawInfo, varInfo, modInfo,
                           modLayers, layersIndex, tempFile)

    return(dat)
}


################################################################################
## Layer Indexing Funs                                                        ##
################################################################################
calculateLayersFromOpening <- function(varInfo, modInfo, layers, startYear) {
    varTime = varInfo[3]; modTime = modInfo[4]

    FUN = paste(varTime, '2', modTime, sep = '')
    if (!exists(FUN, mode = 'function')) stop("unknown timestep combinations")

    FUN = match.fun(FUN)
    return(FUN(layers, as.numeric(startYear)))
}

 Daily2Daily  <- function(...) Monthly2Monthly(..., n = 365)
Annual2Annual <- function(...) Monthly2Monthly(..., n = 1  )

Monthly2Monthly <- function(layers, start, n = 12) {
    ModLayers = layers - n * (start - 1900) + 1
    return(list(ModLayers, layers))
}

Monthly2Daily <- function(layers, start) {
    monthN = layers %% 12 + 1
    ModLayers = c()
    ModLayersindex = c()

    for (i in 1:length(layers)) {
        ModLayer = 365 * floor(layers[i]/12)
        mn = monthN[i]
        if (mn > 1) ModLayer = ModLayer + sum(month_length[(mn - 1):1])
        ModLayer = (ModLayer+1):(ModLayer + month_length[mn])
        ModLayers = c(ModLayers, ModLayer)

        ModLayer = rep(layers[i], length.out = length(ModLayer))
        ModLayersindex = c(ModLayersindex, ModLayer)
    }

    ModLayers = ModLayers - 365 * (start - 1900)

    return(list(ModLayers, ModLayersindex))
}

Monthly2Annual <- function(layers, start) {

    ModLayers = floor(layers / 12)
    ModLayers = ModLayers - start + 1900 +1
    
    return(list(ModLayers, layers))
}


Daily2Monthly <- function(layers, start) {
    browser()
}

Daily2Annual <- function(layers, start) {
    browser()
}

Annual2Monthly <- function(layers, start) {
    browser()
}


Annual2Daily <- function(layers, start) {
    browser()
}