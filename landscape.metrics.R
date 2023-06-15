library(landscapemetrics)
library(raster)
library(landscapetools)
library(foreign)

setwd("D:/New Folder With Items")
filenames <- list.files("D:/New Folder With Items", pattern = ".TIF$")
rc <-read.csv("reclass.csv")
# landscape raster
transect <-read.dbf("1kmBuffer.dbf")

#FOR LOOP!
f <- filenames[1]
all<-data.frame()
for(f in filenames){


l<-raster(f)
rl<-reclassify(l,rc)
contagion <-lsm_l_contag(rl)
meanpatcha <- lsm_c_area_mn(rl)
edgearea <-lsm_c_ed(rl)
#out<-calculate_lsm(l, level = "landscape")
tnum <- as.numeric(substring(f,14,15))+1
#out$transect <- transect$transect[transect$OBJECTID==tnum]
contagion$transect <- transect$transect[transect$OBJECTID==tnum]
meanpatcha$transect <- transect$transect[transect$OBJECTID==tnum]
edgearea$transect <- transect$transect[transect$OBJECTID==tnum]

all<-rbind(all,contagion,meanpatcha[meanpatcha$class==41,],edgearea[edgearea$class==41,])
#cbind mashes columns together, rbind upends rows. possibly cbind lines 23-25. subset also might subset classtype, grab the row where the clas == 41



}
write.csv(all,"D:/New Folder With Items/scapesmetrics.csv")
