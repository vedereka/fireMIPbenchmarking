convert_pacific_centric_2_regular <- function(dat) {
    if (xmax(dat) < 180) return(dat)

    index = 1:length(values(dat[[1]]))

    xyz = cbind(xyFromCell(dat,index), values(dat))
    x = xyz[, 1]
    test = x > 180

    x[test] = x[test] - 360

    xyz[,1] = x
    dat = rasterFromXYZ(xyz, crs = projection(dat))
    return(dat)
}
