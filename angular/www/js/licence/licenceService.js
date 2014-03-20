var module = angular.module('ToerhApp.services');

module.factory('LicenceService', function($http) {
	//var baseUri = 'http://toerh.dev/api/v1';
    var baseUri = 'http://toerh.matthis.se/api/v1';

	return {
		all: function() {
			return $http.get(baseUri + '/licences.json');
		}
	}
});