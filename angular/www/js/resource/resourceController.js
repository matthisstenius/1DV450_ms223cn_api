'use strict';

/* Controllers */

var module = angular.module('ToerhApp.controllers', []);

module.controller('ResourceController', function($scope, $filter, ResourceService, Notifications) {
	$scope.message = Notifications.getNotification();

	loadResources('http://toerh.matthis.se/api/v1/resources.json');

	$scope.next = function() {
		// Only load next in pagenation if there are more respurces to load, we are not already loading or
		// not filtering data
		if ($scope.count === 25 && !$scope.loading && !$scope.search.hasOwnProperty('data')) {
			loadResources($scope.nextUrl);
		}
	};

	$scope.resources = [];

	function loadResources(url) {
		var resources = ResourceService.all(url);
		
		$scope.loading = true;

		resources.success(function(resources) {
			$scope.loading = false;

			if (resources.items) {
				angular.forEach(resources.items, function(resource, value) {
					$scope.resources.push(resource);
				});

				$scope.nextUrl = resources.pagination.next_url;
				$scope.count = resources.count;
			}

			else {
				$scope.message = "No resources found";
			}
		});

		resources.error(function(err) {
			$scope.loading = false;
			console.log(err);
		});
	}
});
 