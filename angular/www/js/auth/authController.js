var module = angular.module('ToerhApp.controllers');

module.controller('AuthController', function($scope, $window, AuthService, $cookies, $rootScope, $location, SessionService) {
	if ($window.sessionStorage.message) {
		$scope.message = $window.sessionStorage.message;
		delete $window.sessionStorage.message;
	}

	$scope.isLoggedIn = function() {
		return SessionService.isAuthenticated();	
	};

	$scope.login = function() {
		var auth = AuthService.auth({
			email: $scope.email,
			password: $scope.password,
		});

		auth.success(function(authorized) {
			$window.sessionStorage.token = authorized.access_token;
			$window.sessionStorage.userid = authorized.user.user_id;

			$location.url('/profile');
		});

		auth.error(function(err) {
			if (err.status == 400) {
				$scope.message = "Wrong email or password.";
			}
		});
	};

	$scope.logout = function() {
		SessionService.destroySession();
		$location.url('/login');
	};

	$rootScope.$on('reAuthenticate', function(message) {
		$window.sessionStorage.message = "The session has expired. Please login again.";
		$scope.logout();
	});
});
