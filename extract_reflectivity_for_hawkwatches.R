###Set up libraries 
library(sp)
library(sf)
library(terra)
library(exactextractr)
###Create Working directory
wd <- "/Users/brettbutcofsky/Library/CloudStorage/GoogleDrive-bbutcof@udel.edu/My Drive/hourly_summaries" #Bretts Home Computer
setwd(wd)
###Import list of times/days/Files?
bucket<-list.files(wd)
###Create sfdataframe
df<-data.frame(site=c("Cape Henlopen","Cape May"), lat =c(38.78417, 38.93258), lon = c(-75.0841,-74.958))
coordinates(df) <- c("lon", "lat") #This assigns coordinates to subpoints and turns it into a SpatialPointsDataFrame object
proj4string(df)<-CRS("+proj=longlat +datum=NAD83")
df<-st_as_sf(df)
###Create data frame to append data to
refl_df<-data.frame(matrix(ncol=7,nrow=length(bucket)))
colnames(refl_df)<-c('Date','Hour','Filetype','CHrefl','CMrefl','CHbuffer','CMbuffer')
###
for (n in 1:length(bucket)){
# read in raster
lc<-rast(paste0(wd,'/',bucket[n]))
df_t<-st_transform(df,crs(lc))
buffer_df<-st_buffer(df_t, dist=1000)


# extract values of raster to polygon buffers
buff_refl<- exact_extract(lc,buffer_df,"mean")
# extract values of raster to points
point_refl<-extract(lc,df_t)


###Append data


refl_df[n,1]<-substr(bucket[n],5,12)
refl_df[n,2]<-substr(bucket[n],14,15)
refl_df[n,3]<-substr(bucket[n],16,20)
refl_df[n,4]<-sub('0+$','',point_refl[1,2])
refl_df[n,5]<-sub('0+$','',point_refl[2,2])
refl_df[n,6]<-sub('0+$','',buff_refl[1])
refl_df[n,7]<-sub('0+$','',buff_refl[2])
print(paste0(sep=' ','Done with', n))
}



write.csv(refl_df, file = "/Users/brettbutcofsky/Desktop/Documents/2022UDRAW/Hawkwatchrefl.csv")









