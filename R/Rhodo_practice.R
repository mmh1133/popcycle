library(popcycle)

file.name <-get.latest.evt.with.day()
evt <- readSeaflow(paste(evt.location, file.name, sep='/'))

notch <- best.filter.notch(evt, notch=seq(0.1, 1.4, by=0.1),width=0.5, do.plot=TRUE)
plot.filter.cytogram(evt, notch=notch, width=0.5)
setFilterParams(notch=notch, width=0.5)

opp <- filter.notch(evt, notch=notch, width=0.5)
setGateParams(opp, popname='beads', para.x='chl_small', para.y='pe')
