var module = angular.module('ToerhApp.controllers');

module.controller('SaveUserController', function($scope, $rootScope, $location, $window, $routeParams, UserService) {
 
    $scope.save = function() {
        var saveUser = UserService.save($scope.user);

        saveUser.success(function(user) {
            $window.sessionStorage.token = user.items.data.access_token;
            $window.sessionStorage.userid = user.items.data.user_id;

            $location.url('/profile');
        });

        saveUser.error(function(err) {
            if (err.status == 400) {
                $scope.message = 'The email: ' + $scope.user.email +  ' already exist.';
            }

            if (err.status == 401) {
                $rootScope.$broadcast('reAuthenticate');
            }
        });
    };
});