'use strict';


// Declare app level module which depends on filters, and services
angular.module('ToerhApp', [
  'ngRoute',
  'ngCookies',
  'NotificationProvider',
  'ToerhApp.filters',
  'ToerhApp.services',
  'ToerhApp.directives',
  'ToerhApp.controllers'
]).
config(['$routeProvider', '$locationProvider', '$httpProvider', function($routeProvider, $locationProvider, $httpProvider) {
  $routeProvider.when('/', {
    templateUrl: 'partials/resource/resources.html', 
    controller: 'ResourceController'
  });

  $routeProvider.when('/login', {
    templateUrl: 'partials/auth/login.html',
    controller: 'AuthController'
  });

  $routeProvider.when('/search/:search', {
    templateUrl: 'partials/resource/resources.html',
    controller: 'SearchController'
  });

  $routeProvider.when('/resources/add', {
    templateUrl: 'partials/resource/addResource.html',
    controller: 'CreateController'
  });

  $routeProvider.when('/resources/:id/edit', {
    templateUrl: 'partials/resource/addResource.html',
    controller: 'CreateController'
  });

  $routeProvider.when('/profile', {
    templateUrl: 'partials/user/profile.html',
    controller: 'UserController'
  });

  $routeProvider.when('/signup', {
    templateUrl: 'partials/user/create.html',
    controller: 'SaveUserController'
  });

  $routeProvider.when('/users/:id/edit', {
    templateUrl: 'partials/user/create.html',
    controller: 'SaveUserController'
  });

  $routeProvider.otherwise({redirectTo: '/view1'});

  $routeProvider.otherwise('/404');

  $locationProvider.html5Mode(false).hashPrefix('');

  $httpProvider.defaults.headers.common['X-Api-Token'] = "30873ace69839a904aea";
}]).
run(function(SessionService, ProtectedRoutes, $rootScope, $location) {
  $rootScope.$on('$locationChangeStart', function(event, next, current) {
    if (ProtectedRoutes.indexOf($location.path()) !== -1 && !SessionService.isAuthenticated()) {
      $location.url('/login');
    }
  });
});
