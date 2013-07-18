#' @title TODO
#' @description TODO
#'
#' @section Methods: 
#'  \describe{
#'    \item{\code{show(TODO)}:}{TODO}
#'  }
#' @param TODO TODO
#' @param ... other arguments passed on the the methods
#' @name RecommenderMethods-methods
#' @rdname RecommenderMethods-methods
#' @aliases await await,ClientRecommender-method await,ServerRecommender-method
#' @exportMethod await
setGeneric("await", function(object, ...) standardGeneric("await"))
setMethod("await", "ClientRecommender", function(object) object@recommender$await())
setMethod("await", "ServerRecommender", function(object) object@recommender$await())

#' @rdname RecommenderMethods-methods
#' @aliases getAllItemIDs getAllItemIDs,ServerRecommender-method getAllItemIDs,ClientRecommender-method
#' @exportMethod getAllItemIDs
setGeneric("getAllItemIDs", function(object, ...) standardGeneric("getAllItemIDs"))
setMethod("getAllItemIDs", "ClientRecommender", function(object) object@recommender$getAllItemIDs()$toArray())
setMethod("getAllItemIDs", "ServerRecommender", function(object) object@recommender$getAllItemIDs()$toArray())

#' @rdname RecommenderMethods-methods
#' @aliases getAllUserIDs getAllUserIDs,ServerRecommender-method getAllUserIDs,ClientRecommender-method
#' @exportMethod getAllUserIDs
setGeneric("getAllUserIDs", function(object, ...) standardGeneric("getAllUserIDs"))
setMethod("getAllUserIDs", "ClientRecommender", function(object) object@recommender$getAllUserIDs()$toArray())
setMethod("getAllUserIDs", "ServerRecommender", function(object) object@recommender$getAllUserIDs()$toArray())

#' @rdname RecommenderMethods-methods
#' @aliases estimatePreference estimatePreference,ClientRecommender,numeric,numeric-method 
#' @exportMethod estimatePreference
setGeneric("estimatePreference", function(object, userID, itemIDs, ...) standardGeneric("estimatePreference"))
setMethod("estimatePreference", signature=signature(object = "ClientRecommender", userID="numeric", itemIDs="numeric"),
          definition = function(object, userID, itemIDs){
            stopifnot(length(userID) == 1)
            if(length(itemIDs) == 1){
              return(object@recommender$estimatePreference(.jlong(userID), .jlong(itemIDs)))
            }else{
              return(object@recommender$estimatePreferences(.jlong(userID), .jlong(itemIDs)))
            }
          })





