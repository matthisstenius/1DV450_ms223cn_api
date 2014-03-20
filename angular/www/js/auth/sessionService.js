var module = angular.module('ToerhApp.services');

module.service('SessionService', function($window) {
	this.isAuthenticated = function() {
		return ($window.sessionStorage.hasOwnProperty('token')) ? true : false;
	};

    this.destroySession = function() {
        delete $window.sessionStorage.token;
        delete $window.sessionStorage.userid;
    };
});