var module = angular.module('ToerhApp.services', []);

module.factory('ProtectedRoutes', function() {
	return [
		'/resources/add',
        '/profile'
	];
});