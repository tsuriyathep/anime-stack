#Declare app level module which depends on filters, and services
#I don't like combining dot chaining with lambdas so I'm breaking it out here.

ng = angular.module "anime", ["anime.filters", "anime.services", "anime.directives", "anime.controllers"]

routeProvider = ($routeProvider) ->
	$routeProvider.when "/view/reset",
		templateUrl: "partials/reset.html"
		controller: "ResetControl"
	$routeProvider.when "/view/import",
		templateUrl: "partials/import.html"
		controller: "ImportControl"
	$routeProvider.when "/view/list",
		templateUrl: "partials/list.html"
		controller: "ListControl"
	$routeProvider.otherwise redirectTo: "/view/list"

ng = ng.config ["$routeProvider", routeProvider]

