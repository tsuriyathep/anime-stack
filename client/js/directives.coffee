#Directives 
#I don't like combining dot chaining with lambdas so I'm breaking it out here.

ng = angular.module "anime.directives", []

ng = ng.directive "appVersion", ["version", (version) -> (scope, elm, attrs) ->	elm.text version]