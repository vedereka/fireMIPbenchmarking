################################
## cfg   				      ##
################################
source("cfg.r")

#					  CLM    CTEM    INFERNO     JSBACH       LPJglob    LPJSpit,   Blaze    MC2         ORCHIDEE
ModelSplit = list(
	 VegModelGroup = c('CLM'       , 'CTEM' , 'JULES'    , 'JSBACH'  , 'LPJ'     ,   'LPJ'   , 'LPJ'    , 'MC2'    , 'ORCHIDEE'),
	Dymanic        = c('P'         , 'P'    ,'SD'        , 'P'       , 'D'       , 'D'       , 'D'      , 'D'      , 'P'       ),
	FireModelGroup = c('Li '       , 'CTEM' , 'INFERNO'  , 'SPITFIRE', 'GLOBFIRM', 'SPITFIRE', 'SIMFIRE', 'MC-fire', 'SPITFIRE'),
	Empirical      = c('P'         , 'P'    , 'SP'       , 'P'       , 'E'       , 'P'       , 'E'      , 'SP'     , 'P'       ),
	SpatialRes     = c(2           , 1      , 4          , 3         , 1         ,  1        , 1        , 1        , 1         ),
	TempralRes     = c('Sub-daily' , 'Daily', 'Sub-daily', 'Daily'   , 'Annual'  , 'Daily'   , 'Annual' , 'Monthly', 'Daily'   ))  
	
	
maxY = 2

colourSelectFun <- function(cats)
		rainbow(length(cats))

################################
## plotting function	      ##
################################
compModelCatigory <- function(dat, addXaxis = FALSE, addYaxis = FALSE) {
	################################################
	## Grab params  						      ##
	################################################
	compName = dat[[1]]
	scores   = dat[[2]]
	
	nullMean =  mean(as.numeric(scores[, 1]), na.rm = TRUE)
	nullRR   = scores[, 2]
	nullRR   = strsplit(nullRR, ' +/- ', fixed = TRUE)
	
	meanStr <- function(x, i) {
		x = sapply(x, function(j) j[i])
		x = mean(as.numeric(x), na.rm = TRUE)
		return(x)
	}
	
	nullRRMN = meanStr(nullRR, 1)
	nullRRVR = meanStr(nullRR, 2)
	
	allScores = c(sapply(scores[,-c(1:2)], as.numeric), nullMean, nullRRMN + nullRRVR)
	minY = min(allScores, na.rm = TRUE)
	maxY = max(allScores, na.rm = TRUE)
	
	if ((maxY - minY) > 2) log = 'y' else log = ''
	################################################
	## set up plot frame					      ##
	################################################
	plot(c(0, nAxis), c(minY, maxY), type = 'n', yaxt = 'n', xaxt = 'n', xlab = '', log = log)
	mtext(compName)
	if (addXaxis) labels = names(ModelSplit) else labels = rep('', nAxis)
	axis(1, at = 1:nAxis, labels = labels, las = 2)
	
	if (addYaxis) axis(2)
	
	################################################
	## Add Null Models 						      ##
	################################################
	
	nullLine <- function(y, ...) lines(c(0, nAxis), c(y, y), ...)
	
	nullLine(nullMean)
	nullLine(nullRRMN - nullRRVR, col = 'grey', lty = 2)
	nullLine(nullRRMN + nullRRVR, col = 'grey', lty = 2)
	nullLine(nullRRMN, col = 'grey')	
	
	################################################
	## Plot Catigories 						      ##
	################################################
	plotCat <- function(info, x, ys, offset, boxLab = NULL) {
		cats    = unique(info)
		catCols = colourSelectFun(cats)
		cols = sapply(info, function(i) catCols[which(cats == i)])
		points(rep(x + offset, length(ys)), ys, col = cols, pch = 19)
		if (!is.null(boxLab)) {
			xbox = rep(c(x + offset - 0.1, x + offset + 0.1), each = 2)
			xbox = c(xbox, xbox[1])
			ybox = c(min(ys, na.rm = TRUE) -0.1, max(ys, na.rm = TRUE) + 0.1)
			ybox = c(ybox, rev(ybox), ybox[1])			
			lines(xbox, ybox)
			text(boxLab, x = x + offset, y = min(ys, na.rm = TRUE) - 0.2)
		}
	}
	
	plotStep <- function(stepN, offset) {		
		score = as.numeric(scores[, stepN])
		mapply(plotCat, ModelSplit, 1:nAxis, MoreArgs = list(score, offset, NULL))
	}
	
	steps = 3:ncol(scores)
	if (length(steps) == 3) offsets = c(-0.25, 0, 0.25)
	else if (length(steps) == 1) offsets = 0
	else browser()
	
	mapply(plotStep, steps, offsets)
	
}

openFile <- function(file) {
	scores = read.csv(file, stringsAsFactors = FALSE)
	cats   = colnames(scores)
	
	compName = strsplit(file, 'outputs/')[[1]][2]
	compName = strsplit(compName, '-')[[1]][2]
	
	testIndexUnique <- function(index) all(sapply(index, length) == 1)
	
	findMetricTypeScores <- function(indexs,nm) {
		index = lapply(indexs, grep, cats)
		if (nm !="") compName = paste(compName, nm, sep = '.')
		if (testIndexUnique(index))
			return(list(compName, scores[unlist(index)]))
		else invisible()
	}
	
	indexess = list(c("mean", "random", "step1", "step2", "step3"),
					c("mean", "random", "model"),
					c("mean.phase", "random.phase", "models.phase"),
					c("mean.concentration2", "random.concentration",
					  "models.concentration1", "models.concentration2",
 					  "models.concentration3"))
		
	nms = c("", "", "phase", "concentration")	
	out = mapply(findMetricTypeScores, indexess, nms)
	
	return(out[!sapply(out, is.null)])
}

#############################
## Open                    ##
#############################
dat = c()
files = list.files('outputs/',  full.names = TRUE)
files = files[grep('.csv', files)]
for (i in files) dat = c(dat, openFile(i))

#############################
## plot                    ##
#############################
## setup
nplots = length(dat)
nplotsX = floor(sqrt(nplots))
nplotsY = ceiling(sqrt(nplots))
nAxis = length(ModelSplit)
if (nplots > (nplotsX * nplotsY)) nplotsX = nplotsX + 1
nplotsY = nplotsY + 1

pdf("wow.pdf", height = nplotsX * 4, width = nplotsY * 2.5)

lmat = t(matrix(1:(nplotsX *nplotsY), nrow = nplotsY))
lmat[lmat > nplots] = 0.0
lmat[nplotsX, ] = nplots + 1
layout(lmat)
par(mar = c(1, 1, 2, 0), oma = c(1, 2, 1,0))

##performs
addYaxis = addXaxis = rep(FALSE, nplots)
addYaxis[seq(1, nplots, nplotsY)] = TRUE
addXaxis[(nplots - nplotsX):nplots] = TRUE

mapply(compModelCatigory, dat, addXaxis, addYaxis)

## turn off


addLegends <- function(cats, y, title) {
	cats = unique(cats)
	cols = colourSelectFun(cats)
	
	legend(x = 0.5, xjust = 0.5, y = y, legend = cats, title = title,
	       horiz = TRUE, pch = 19, col = cols, xpd = TRUE, bty = 'n')
	
}

plot.new()
ys = seq(0.9, 0.1, length.out =length(ModelSplit))
mapply(addLegends, ModelSplit, ys, names(ModelSplit))
dev.off()
