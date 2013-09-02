#Controllers 
#I don't like combining dot chaining with lambdas so I'm breaking it out here.

ng = angular.module "anime.controllers", []

resetControl = ($scope, $http) ->
	$http.get('/db/reset').then (res)->
		$scope.status = res.data
ng = ng.controller "ResetControl", resetControl

importControl = ($scope, $http) ->
	$http.get('/db/import').then (res)->
		$scope.status = res.data
ng = ng.controller "ImportControl", importControl

#Show listing
listControl = ($scope, $http) ->
	$http.get('/db/list').then (res)->
		$scope.products = res.data
ng = ng.controller "ListControl", listControl