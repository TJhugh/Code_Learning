require(RDSTK)
require(geosphere)
conv <- street2coordinates("7029 Autumn Terrace, Eden Prairie, MN 55346", session = getCurlHandle())

add1 <- data.frame(HomeLat = c(44.87511), HomLon = c(-93.5153), WkLat = c(44.9783780), WkLon = c(-93.2726360))
distGeo(c(add1$HomLon, add1$HomeLat), c(add1$WkLon, add1$WkLat), a=6378137, f=1/298.257223563)*.00062137
