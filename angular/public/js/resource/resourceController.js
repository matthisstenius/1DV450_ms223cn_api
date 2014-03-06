'use strict';

/* Controllers */

var module = angular.module('ToerhApp.controllers', []);

module.controller('ResourceController', ['$scope', 'ResourceService', function($scope, ResourceService) {
	var resources = ResourceService.all();

	resources.success(function(resources) {
		$scope.resources = resources.items;
	});

	resources.error(function(err) {
		console.log(err);
	});
}]);
 