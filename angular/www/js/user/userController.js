'use strict';

var module = angular.module('ToerhApp.controllers');

module.controller('UserController', function($scope, $rootScope, $location, $window, Notifications, UserService, SessionService, ResourceService) {
    $scope.message = Notifications.getNotification();

    var user = UserService.user($window.sessionStorage.userid);

    user.success(function(user) {
        $scope.user = user.items.data;

        userResources('http://toerh.matthis.se/api/v1/users/' + $scope.user.user_id + '/resources.json');
    });

    user.error(function(err) {
        console.log(err);
    });

    $scope.removeResource = function(id, index) {
        var destroyResource = ResourceService.destroy($scope.user.user_id, id);

        destroyResource.success(function() {
            $scope.resources.splice(index, 1);
            $scope.message = 'Successfully removed resource';
        });

        destroyResource.error(function(err) {
            console.log(err);

            if (err.status == 401) {
                $rootScope.$broadcast('reAuthenticate');
            }
        });
    };

    $scope.next = function() {
        // Only load next in pagenation if there are more respurces to load, we are not already loading or
        // not filtering data
        if ($scope.count === 25 && !$scope.loading && !$scope.search.hasOwnProperty('data')) {
            loadResources($scope.nextUrl);
        }
    };

    $scope.removeUser = function() {
        var removeUser = UserService.destroy($scope.user.user_id);

        removeUser.success(function() {
            Notifications.setNotification('Your account has been deleted.');
            SessionService.destroySession();
            $location.url('/');
        });

        removeUser.error(function(err) {
            if (err.status == 401) {
                $rootScope.$broadcast('reAuthenticate');
            }
        });
    };

    $scope.resources = [];

    function userResources(url) {
        var userResources = ResourceService.byUser(url);

        $scope.loading = true;

        userResources.success(function(resources) {
            $scope.loading = false;
           if ( ! resources.items) {
                $scope.message = "No resources could be found";
                return;
            }

            angular.forEach(resources.items, function(resource, value) {
                $scope.resources.push(resource);
            });

            $scope.nextUrl = resources.pagination.next_url;
            $scope.count = resources.count;
            //$scope.tags = resources.items.tags;
        });

        userResources.error(function(err) {
            $scope.loading = false;
            console.log(err);
        });
    }
});