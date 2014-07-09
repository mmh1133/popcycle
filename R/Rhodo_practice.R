 ##### Tutorial Practice with Feb 2014 Rhodomonas culture SeaFlow run #####

#### Initialization ####

## Step 1 ##

library(popcycle)

file.name <-get.latest.evt.with.day() #name of the latest evt file collected
evt <- readSeaflow(paste(evt.location, "/2014_053/29.evt", sep='/')) #load evt file, can change to only look at a specific and not the latest 

notch <- best.filter.notch(evt, notch=seq(0.1, 1.4, by=0.1),width=0.5, do.plot=TRUE) #finds notch
plot.filter.cytogram(evt, notch=notch, width=0.5) #plots filteration
setFilterParams(notch=notch, width=0.5) #saves filter parameters


## Step 2 ## manual gating ## 

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





