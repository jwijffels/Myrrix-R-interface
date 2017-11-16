##
## Download data available at http://www-etud.iro.umontreal.ca/~bergstrj/audioscrobbler_data.html
##
library(data.table)
x <- data.table::fread("C:/Users/Jan/Desktop/profiledata_06-May-2005/user_artist_data.txt")

## save a sample of that data in format Myrrix wants
setwd("C:/Users/Jan/Desktop/Myrrixexample")
inputfile <- "user_artist_interest.csv"
write.table(x[sample(x = nrow(x), size = 1000), ], file = inputfile, col.names = FALSE, sep = ",", row.names=FALSE)
tar("user_artist_interest.gz", inputfile, compression = "gzip")


##
## Set training parameters of Alternating Least Squares
##
library(Myrrix)
setMyrrixHyperParameters(params=list(model.iterations.max = 10, model.features=30, model.als.lambda=0.1))
x <- getMyrrixHyperParameters(parameters=c("model.iterations.max","model.features","model.als.lambda"))

##
## Build a model which will be stored in getwd() and ingest the data file into it
##
recommendationengine <- new("ServerRecommender", localInputDir=getwd())
ingest(recommendationengine, "user_artist_interest.gz")
await(recommendationengine)

##
## Get users/items available in the data and predict
##

## Get all users/items and score
items <- getAllItemIDs(recommendationengine)
users <- getAllUserIDs(recommendationengine)
estimatePreference(recommendationengine, userID=users[5], itemIDs=items[1:20])
mostPopularItems(recommendationengine, howMany=10L)
recommend(recommendationengine, userID=users[5], howMany=10L)


