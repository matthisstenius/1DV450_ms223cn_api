'use strict';

var module = angular.module('ToerhApp.services', []);

module.factory('ResourceService', ['$http', function($http) {
	var baseUri = 'http://toerh.dev/api/v1/';

	return {
		all: function(url) {
			return $http.get(url);
		},

		show: function(id) {
			return $http.get(baseUri + 'resources/' + id);
		}
	};
}]);
