'use strict';

var module = angular.module('ToerhApp.services');

module.factory('AuthService', function($http) {
	var baseUri = 'http://toerh.matthis.se/api/v1/';
	//var baseUri = 'http://toerh.dev/api/v1/';
	return {
		auth: function(credentials) {
			return $http.post(baseUri + 'authenticate.json', credentials);
		}
	}
});