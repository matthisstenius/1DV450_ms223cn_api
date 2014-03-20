'use strict';

var module = angular.module('ToerhApp.services');

module.factory('ResourceService', function($http, $window) {
	var baseUri = 'http://toerh.matthis.se/api/v1/';
	//var baseUri = 'http://toerh.dev/api/v1/';

	$http.defaults.headers.common.Authorization = $window.sessionStorage.token;

	return {
		all: function(url) {
			return $http.get(url);
		},

		show: function(id) {
			return $http.get(baseUri + 'resources/' + id + '.json');
		},

		byUser: function(url) {
			return $http.get(url);
		},

		store: function(resource) {
			$http.defaults.headers.common.Authorization = $window.sessionStorage.token;
			if (resource.id) {
				return $http.put(baseUri + 'users/' + $window.sessionStorage.userid + '/resources/' + resource.id + '.json', resource);
			}

			return $http.post(baseUri + 'users/' + $window.sessionStorage.userid + '/resources.json', resource);
		},

		destroy: function(userID, resourceID) {
			$http.defaults.headers.common.Authorization = $window.sessionStorage.token;
			return $http.delete(baseUri + 'users/' + userID + '/resources/' + resourceID + '.json');
		},

		search: function(search) {
			return $http.get(baseUri + 'resources.json/?search=' + search.search);
		}
	};
});
