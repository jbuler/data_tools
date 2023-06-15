### R code for Chapter 4 of Gergel & Turner 2017
### Understanding Landscape Metrics
### Written by Jeff Buler 02/25/2021
### modified 02/15/2023
### Vignette for getting started with landscapemetrics package
### https://r-spatialecology.github.io/landscapemetrics/articles/get_started.html 

library(landscapemetrics)
library(raster)

options(scipen = 999)

### Part 3

#create list of all available landscape metrics
metrics <- list_lsm(level = c("landscape"))

# set working directory
wd<- "C:/Users/jbuler/OneDrive - University of Delaware - o365/Classes/Landscape_Ecology/Spring2021/lab_materials/Lab2_Landscape Metrics/Ch4 Landscape Metrics/"
setwd(paste0(wd,"Part 3-Fragstats-compatible-landscapes"))

### Calculation 16: Early Settlement landscape metrics using 4 neighbor rule
# read in ascii table
dfe <- read.table("esett.asc", header = F)
# create empty raster
re <- raster(ncol=10, nrow=10, xmn = 0, xmx = 10000, ymn=0, ymx = 10000, res=c(1000,1000), crs="EPSG:26918")
# set values of raster from table
values(re)<-as.matrix(dfe)
# plot the raster to check that it is correct
plot(re)
# check to see that raster has properties needed to compute metrics
check_landscape(re)
# compute all landscape metrics and write results as csv file
out4<-calculate_lsm(re, level="landscape", directions=4, classes_max=3) 
out4<-merge(out4,metrics, by="metric")
write.csv(out4, "early4_all.csv")

# alternatively we can compute just selected landscape metrics and write results as csv file
out4<-calculate_lsm(re, what=c("lsm_l_np","lsm_l_area_mn","lsm_l_shei","lsm_l_contag"), directions=4) 
out4<-merge(out4, metrics, by="metric")
write.csv(out4, "early4_select.csv")

### Calculation 17: Early Settlement landscape metrics using 8 neighbor rule
out8<-calculate_lsm(re, what=c("lsm_l_np","lsm_l_area_mn","lsm_l_shei","lsm_l_contag"), directions=8) 
out8<-merge(out8, metrics, by="metric")
write.csv(out8, "early8_select.csv")

### Calculation 18: Post Settlement landscape metrics using 4 neighbor rule (on your own)

### Calculation 19: Post Settlement landscape metrics using 8 neighbor rule (on your own)

### Part 4
setwd(paste0(wd,"Part 4-Fragstats-compatible-landscapes-and-Images"))
### Calculation 20: Madison, Wisconsin, USA
dfmad1 <- read.table("./Madison/Mad 1/mad1.asc", header = F)
rmad1 <- raster(ncol=800, nrow=575, xmn = 0, xmx = 30*800, ymn=0, ymx = 30*575, res=c(30,30), crs="EPSG:26918")
values(rmad1)<-as.matrix(dfmad1)
plot(rmad1)
outmad1<-calculate_lsm(rmad1, what=c("lsm_l_pd","lsm_l_ed","lsm_l_lsi","lsm_l_contag","lsm_l_lpi","lsm_l_pr"), directions=8) 
outmad1<-merge(outmad1, metrics, by="metric")
write.csv(outmad1, "mad1_metrics.csv")

dfmad2 <- read.table("./Madison/Mad 2/mad2.asc", header = F)
rmad2 <- raster(ncol=800, nrow=575, xmn = 0, xmx = 30*800, ymn=0, ymx = 30*575, res=c(30,30), crs="EPSG:26918")
values(rmad2)<-as.matrix(dfmad2)
plot(rmad2)
outmad2<-calculate_lsm(rmad2, what=c("lsm_l_pd","lsm_l_ed","lsm_l_lsi","lsm_l_contag","lsm_l_lpi","lsm_l_pr"), directions=8) 
outmad2<-merge(outmad2, metrics, by="metric")
write.csv(outmad2, "mad2_metrics.csv")

### Calculation 21: New England Landscape #1 (on your own)

### Calculation 22: New England Landscape #2 (on your own)

### Calculation 23: New England Landscape #3 (on your own)