# This file was created by Nicholas Malizia for an introductory lecture on R to graduate students at ASU. The data employed here are not my own. For attribution information contact me via email. 


################### APARTMENT DATA EXPLORATION ###################

# read some data from a file that is space delimited, note that the TRUE value here, designates that there is a header in the file. 
data=read.table("trolley.dat",TRUE)

# in fact, let's look at the help system at this point to find out more about reading tables
help(read.table)

# now, let's see how many entries are in the table.  
trolleyrows=nrow(data)

# let's also take a minute to look at the raw data.
data

# now, let's differentiate between stations and apartments, note that stations are identified by a -9 in the first two columns...
trolley=data$R==-9

# we're going to slice up the dataframe into parts identifying the stations and apartments, note the syntax here "!" corresponds to not equals, "," is a wildcard saying give me everything in this row
apart=data[!trolley,]
station=data[trolley,]

# now i want to look at the distribution of the apartment rents using a histogram
hist(apart$R)

# that was painless right? let's make it look a little prettier and publication worthy. this is a good point to explore the help system in R. let's see what options are available for the histogram function
help(hist)

# ok, now let's label the plot and change the x axis range
hist(apart$R, main='Distribution of Apartment Rents', xlab='Rent')

# cool, now that we have our plot looking a bit more respectable, let's output it to something that we can save... 
pdf(file="figures/figure1.pdf")
hist(apart$R, main='Distribution of Apartment Rents', xlab='Rent')
dev.off()

# cool right? now let's do a little bit more exploration of the dataset and plot the locations of the stations and the apartments and explore the relationship between the relative locations and rent prices.

# we'll need to extract the x and y coordinates for the stations and apartments
stationx=station$x1
stationy=station$y1
apartx=apart$x1
aparty=apart$y1

# now let's plot the apartments. 
plot(apartx,aparty,xlab="X Coordinate",ylab="Y Coordinate",main="Apartment Locations")

# and the stations, but we'll do these in a different color and symbol
points(stationx,stationy,pch=15,col="red")

# now let's read the values for square footage (s) and calculates the straight line distance from the apartments to the cbd. 
sqft=apart$s
dist2cbd=sqrt(apartx^2+aparty^2)

# we can use this data to plot the apartment size as a function of distance to the cbd.
plot(dist2cbd,sqft,xlab="Distance to CBD",ylab="Square Footage",main="Apartment Size Gradient")

# we can also calculate the rent per square foot and plot a similar gradient. 
sqftrent=apart$R/sqft
plot(dist2cbd,sqftrent,xlab="Distance to CBD",ylab="Apartment Rent Per Square Foot (Monthly)",main="Apartment Per Square Foot Rent Gradient")

# next let's explore some nested for loops to figure out which apartments are within that buffer of each of the stations 
within=(1:nrow(apart))*0
for(i in 1:nrow(apart)){
for(j in 1:nrow(station)){
trolleydist=sqrt((apartx[i]-stationx[j])^2+(aparty[i]-stationy[j])^2)
if(trolleydist<=1000){within[i]=1}
}}

# we're going to bind this new column vector with the trolley matrix so we can use it to slice it up further. 
apart<-cbind(apart,within)

# now let's slice up the apartment data so we can plot those within the buffer and those without separately
proximate=apart[,5]==1
apartfar=apart[!proximate,]
apartclose=apart[proximate,]

# here we plots the locations of apartments (within & outside buffer) and the trolley stations and their buffers. 
radius=(mat.or.vec(4,1))+1000
plot(apartfar[,3],apartfar[,4],xlab="X Coordinate", ylab="Y Coordinate", main="Apartment Locations Relative to Trolley Station")
points(stationx,stationy,pch=15,col="red")
points(apartclose[,3],apartclose[,4],col="red")
symbols(stationx,stationy,circles=radius,inches=FALSE,add=TRUE,fg="red")

# now let's fit a linear model to the square foot rent gradient and include a dummy variable to identify those within the buffer and those outside 
model=lm(sqftrent~ (dist2cbd + within))

# let's look at the results of the model
summary(model)

# sometimes we'd like to extract a single result of the model. given the object-oriented structure of R we can do this pretty easily. let's grab the the beta coefficient for the dummy variable and the associated t-test results from the model object 
beta=summary(model)$coefficients["within","Estimate"]
tvalue=summary(model)$coefficients["within","t value"]
tprob=summary(model)$coefficients["within","Pr(>|t|)"]

# prints the values
print(beta) 
print(tvalue)
print(tprob)



################### AUTOMOBILE DATA EXPLORATION ###################

# now let's look at some simple data on counts of automobiles observed on a particular road over the course of a week. the data come from a csv file. note, much of this code came from Frank McCown's website <http://www.harding.edu/fmccown/r/>

# let's read them in... simple right?
autodata = read.csv("autos.csv")

# let's summarize the data in the dataframe
summary(autodata)

# we could very easily plot the data as a line graph like this... 
plot(autodata$cars,type="l",col='blue')
lines(autodata$trucks,col='red')
lines(autodata$suvs,col='green')

# but that sucks, so we're going to create a slightly nicer graphic that is hopefully aethetically pleasing and publication worthy. first, we'll compute the largest y value used in the data 
max_y <- max(autodata)

# next we'll define colors to be used for plotting cars, trucks, suvs
plot_colors <- c("blue","red","forestgreen")

# first, we'll graph autos using y axis that ranges from 0 to max_y. we'll turn off axes and annotations (axis labels) so we can specify them ourself
plot(autodata$cars, type="o", col=plot_colors[1], 
   ylim=c(0,max_y), xlim=c(1,5), axes=FALSE, ann=FALSE)

# label the x axis using mon-fri labels
axis(1, at=1:5, lab=c("Mon", "Tue", "Wed", "Thu", "Fri"))

# and the y axis with a range from 0 to the max_y with labels at every 4
axis(2, las=1, at=4*0:max_y)

# and finally put a box around it all
box()

# we'll plot the truck counts with red dashed line and square points
lines(autodata$trucks, type="o", pch=22, lty=2, 
   col=plot_colors[2])

# and suvs with green dotted line and diamond points
lines(autodata$suvs, type="o", pch=23, lty=3, 
   col=plot_colors[3])


# next we'll add a title and label the axes
title(main="Autos")
title(xlab="Days")
title(ylab="Total")

# finally, we'll create a legend at (1, max_y) that is slightly smaller (by adjusting cex) and uses the same line colors and points used by the actual plots
legend(1, max_y, names(autodata), cex=0.8, col=plot_colors, 
   pch=21:23, lty=1:3);



################### TWITTER HASH TAG EXPLORATION ###################

# let's now look at another data source (and slightly cooler one), that is a little trickier to feed in. say we get some data from a collaborator in the form of an excel workbook or a dbf file... how do we import these data? we first will need to install an outside package because R doesn't come preloaded with the ability to read these files. also, to visualize the data we'll be using a wordcloud library.

library(gdata)
library(wordcloud)
riots = read.xls("twitter_riot.xls",sheet=2)
wordcloud(riots$tag, riots$occurences,scale=c(4,.5), max.words=250, random.order = FALSE, random.color=FALSE)
