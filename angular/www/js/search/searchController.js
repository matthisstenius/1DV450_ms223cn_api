var module = angular.module('ToerhApp.controllers');

module.controller('SearchController', function($scope, $routeParams, ResourceService) {
	var resources = ResourceService.search($routeParams);

	resources.success(function(resources) {
		if (resources.items) {
			$scope.resources = resources.items;
		}

		else {
			$scope.message = "No resources could be found with search: " + $routeParams.search;
		}
	});

	resources.error(function(err) {
		console.log(err);
	});
});