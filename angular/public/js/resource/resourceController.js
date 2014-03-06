'use strict';

/* Controllers */

var module = angular.module('ToerhApp.controllers', []);

module.controller('ResourceController', ['$scope', 'ResourceService', function($scope, ResourceService) {
	loadResources('http://localhost:3000/api/v1/resources.json');

	$scope.next = function() {
		loadResources($scope.nextUrl);
	}

	function loadResources(url) {
		var resources = ResourceService.all(url);

		resources.success(function(resources) {
			$scope.resources = resources.items;
			$scope.nextUrl = resources.pagination.next_url;
		});

		resources.error(function(err) {
			console.log(err);
		});
	}
}]);
 