wd <- "G:/Shared drives/aplab/research_projects (1)/DE_quail/git/data_tools"
setwd(wd)
source("functions/api_postgres.R")
library(DBI)
start <- Sys.time()

####SETTINGS#####
my_token <- "f9d299ec213376d4bbedfeccf1e1cf448d780e1d03d87f7effd4fdb9afc2a970"
db_name <- "quaildb"
myproject <- "Cedar Swamp WMA" #this is your project name on your CTT account
#conn <- dbConnect(RPostgres::Postgres(), dbname=db_name)
################
outpath <- "G:/Shared drives/aplab/research_projects (1)/DE_quail/data"
get_my_data(my_token, outpath=outpath, myproject=myproject, begin="2023-05-30")# , conn, myproject) #the folder path is where you want your downloaded files to go
#update_db(conn, outpath, myproject)
#dbDisconnect(conn)

#source("functions/filecatch.R")
#findfiles(outpath, "directory path where you want your caught files to go")

time_elapse <- Sys.time() - start
print(time_elapse)

