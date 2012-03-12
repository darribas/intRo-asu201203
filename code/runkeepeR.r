########################################################################################
# Example II                                                                           # 
# Author: Dani Arribas-Bel <darribas@asu.edu>                                          #
# This file was created for an introductory lecture on R to graduate students at ASU.  #
# Most of the code to use the library OpenStreetMap was inspired by a post             #
# from Ian at <http://blog.fellstat.com/?p=130>                                        #
# The data in 'tracking.csv' are property of Dani Arribas-Bel. You are free to         #
# use them as long as you acknowledge the source                                       #
########################################################################################

# In this example we will learn to read in coordinates from a GPS that are
# stored in csv format, visualize them, add contextual information borrowed
# from OpenStreetMap and save the points into a shapefile

# First off, let's load up the libraries we will need. Before we need to turn off AWT to
# avoid a bug in the Macs (see the referenced post for context)
#Sys.setenv(NOAWT=1)
library(rgdal)
library(OpenStreetMap)

# Now, assuming your working directory is in the same folder as the csv, we
# can read it in (we also get rid of the column "nothing" to make it simpler):
link <- '../data/tracking.csv'
xys <- read.csv(link)
xys$nothing <- NULL
# We need to tell R what column is latitude and which is longitude
coordinates(xys) <- ~y+x
# We could readily plot the coordinates, although this doesn't have much
# context
plot(xys)

# Let's add OpenStreetMap data to get a better sense of the context.
# First we'll need the bounding box of our coordinates to know what part of
# the Map we should download
bb <- bbox(xys)
minY <- bb[1]
maxY <- bb[3]
minX <- bb[2]
maxX <- bb[4]
# Now, if we're online, we're ready to call OpenStreetMap and download the
# tiles for the area of our points
map <- openmap(c(maxX, minY), c(minX, maxY))

# Now we have to project our points to overlay them on the OSM data. First
# we'll tell R our data is in long lat. We can do this by passing the full
# string:
oprj <- CRS('+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs')
# or by calling the handy function in the OpenStreetMap library:
oprj <- longlat()
# Now we assign this coordinate system to our dataset
proj4string(xys) <- oprj
# And convert it to the one OSM uses by default
osm.prj <- " +proj=merc +a=6378137 +b=6378137 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 +units=m +nadgrids=@null +no_defs"
pxys <- spTransform(xys, CRS(osm.prj))

# We're ready to plot! Comment out line 58 and 61 if you want the output
# dumped into a png file
#png('osmOverlay.png')
plot(map, raster=TRUE)
plot(pxys, add=TRUE, pch=20, cex=0.05)
#dev.off()

# Imagine we now have some extra variables to append to the coordinates
data <- data.frame('A'=rnorm(length(xys)), 'B'=rnorm(length(xys)))
sdf <- SpatialPointsDataFrame(xys, data)
# If we want to save the coordinates as a point shapefile, there are
# several ways to do it. A very easy one is:
shp <- writeShapeSpatial(sdf)

