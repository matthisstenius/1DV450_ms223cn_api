'use strict';

var module = angular.module('ToerhApp.services', []);

module.factory('ResourceService', ['$http', function($http) {
	var baseUri = 'http://localhost:3000/api/v1/';

	return {
		all: function() {
			return $http.get(baseUri + 'resources.json');
		},

		show: function(id) {
			return $http.get(baseUri + 'resources/' + id);
		}
	};
}]);
