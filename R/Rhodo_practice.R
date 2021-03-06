 ##### Tutorial Practice with Feb 2014 Rhodomonas culture SeaFlow run #####

#### Initialization ####

# NEW COMMENT: maybe include at beginning a list of everything you need/things that are nice to have (R,python,sourcetree-nice to have, markdown used to edit readme, ect.) 


## step 1 ##

library(popcycle)

file.name <-get.latest.evt.with.day() #name of the latest evt file collected
evt <- readSeaflow(paste(evt.location, "/2014_053/29.evt", sep='/')) #load evt file, can change to only look at a specific and not the latest 

notch <- best.filter.notch(evt, notch=seq(0.1, 1.4, by=0.1),width=0.5, do.plot=TRUE) #finds notch
plot.filter.cytogram(evt, notch=notch, width=0.5) #plots filteration
setFilterParams(notch=notch, width=0.5) #saves filter parameters


## step 2 ## manual gating ## 

#should be made clear that it is manual i.e. drawing
#right click after closing gate

#probably should add special section for monoculture 

opp <- filter.notch(evt, notch=notch, width=0.5)
#beads
setGateParams(opp, popname='beads', para.x='chl_small', para.y='pe')
#synecho
setGateParams(opp, popname='synecho', para.x='fsc_small', para.y='pe')
#pro
setGateParams(opp, popname='prochloro', para.x='fsc_small', para.y='chl_small')
#picoeukaryotes
setGateParams(opp, popname='picoeuk', para.x='fsc_small', para.y='chl_small')

resetGateParams() 

#visualizing populations#
vct<-classify.opp(opp,ManualGating) #clusters populations based on manual gating
opp$pop<-vct
par(mfrow=c(1,2))
plot.vct.cytogram(opp, para.x='fsc_small', para.y='chl_small')
plot.vct.cytogram(opp, para.x='fsc_small', para.y='pe')


### since our rhodo culture is not real time data ###
### reanalyzing previous SeaFlow file structure ### 

## conversion of sds to sfl files and upload into database is done in terminal ##
#maybe fix python steps to explain that it is still done in terminal 

#with rhodo, sfl needs to be in same place as original evt files to set gate parameters and such - potential problem


## "Play" ##

run.filter.v1('/Volumes/seaflow/Rhodomonas_Feb2014')

run.gating.v1('rhodo')

get.evt.list()

plot.cytogram.by.file("2014_055/61.evt",para.x="fsc_small", para.y="pe")
plot.cytogram.by.file("2014_054/61.evt.opp")

stat <- get.stat.table() # to load the aggregate statistics
> plot.map(stat, pop='synecho', param='abundance') 
> plot.time(stat, pop='synecho', param='abundance')

sfl <- read.delim("/Users/mariaham/popcycle_repo/rhodo.sfl")
sfl$FILE.DURATION <- 180
write.delim(sfl, "/Users/mariaham/popcycle_repo/rhodo.sfl",quote=F, row.names=F)
