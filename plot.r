library(rgl)
library(reshape)
rgl.clear(type = c("shapes"))
calls = read.delim('call_data.tsv', header = T)

bin_size = 0.18

calls$long_bin =  cut(calls$long, seq(min(calls$long), max(calls$long), bin_size))
calls$lat_bin =  cut(calls$lat, seq(min(calls$lat), max(calls$lat), bin_size))
calls$total = log(calls$total) / 3

calls = calls[,c('long_bin', 'lat_bin', 'total')]
calls = melt(calls)
calls = cast(calls, lat_bin~long_bin, fun = sum, fill = 0)
calls = calls[,2:(ncol(calls)-1)]
calls = as.matrix(calls)


ylim <- range(calls)
ylen <- ylim[2] - ylim[1] + 1
col <- topo.colors(ylen)[ calls-ylim[1]+1 ]


x =  (1: nrow(calls))
z =  (1: ncol(calls))

rgl.bg(sphere=FALSE, color=c("black"), lit=FALSE)
rgl.viewpoint( theta = 285, phi = 30, fov = 170, zoom = 0.04)
# rgl.surface(x, z, calls, color = col, shininess = 10)
rgl.surface(x, z, calls)
rgl.bringtotop()




