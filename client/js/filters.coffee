#Filters 
#I don't like combining dot chaining with lambdas so I'm breaking it out here.

ng = angular.module "anime.filters", []

ng = ng.filter "interpolate", ["version", (version) -> (text) -> String(text).replace /\%VERSION\%/g, version]