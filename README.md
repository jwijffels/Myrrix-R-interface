Myrrix-R-interface
==================

Let R talk to Myrrix. Myrrix is a complete, real-time, scalable clustering and recommender system, evolved from Apache Mahout.

For more information about Myrrix, go to the Myrrix website: [http://myrrix.com](http://myrrix.com "http://myrrix.com").

The R packages allow to build recommendation engines using Myrrix and interact with it.
An example is shown below.

# Install Myrrixjars and Myrrix
To start up building recommendation engines, install the R packages Myrrixjars and Myrrix as follows.

    library(devtools)
    install.packages("rJava")
    install.packages("ffbase")
    install_github("Myrrix-R-interface", "jwijffels", subdir="/Myrrixjars/pkg")
    install_github("Myrrix-R-interface", "jwijffels", subdir="/Myrrix/pkg")
    

# Running Myrrix
The following example shows the basic usage on how to use Myrrix to build a local recommendation engine.
It uses the audioscrobbler data available on the Myrrix website.

    library(Myrrix)
    
    ## Download example dataset
    inputfile <- file.path(tempdir(), "audioscrobbler-data.subset.csv.gz")
    download.file(url="http://dom2bevkhhre1.cloudfront.net/audioscrobbler-data.subset.csv.gz", destfile = inputfile)
    
    ## Set hyperparameters
    setMyrrixHyperParameters(params=list(model.iterations.max = 2, model.features=10, model.als.lambda=0.1))
    x <- getMyrrixHyperParameters(parameters=c("model.iterations.max","model.features","model.als.lambda"))
    str(x)
    
    ## Build a model which will be stored in getwd() and ingest the data file into it
    recommendationengine <- new("ServerRecommender", localInputDir=getwd())
    ingest(recommendationengine, inputfile)
    await(recommendationengine)
    
    ## Get all users/items and score alongside the recommendation model
    items <- getAllItemIDs(recommendationengine)
    users <- getAllUserIDs(recommendationengine)
    estimatePreference(recommendationengine, userID=users[1], itemIDs=items[1:20])
    estimatePreference(recommendationengine, userID=users[10], itemIDs=items)
    mostPopularItems(recommendationengine, howMany=10L)
    recommend(recommendationengine, userID=users[5], howMany=10L)
