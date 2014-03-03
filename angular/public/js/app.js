'use strict';


// Declare app level module which depends on filters, and services
angular.module('ToerhApp', [
  'ngRoute',
  'ToerhApp.filters',
  'ToerhApp.services',
  'ToerhApp.directives',
  'ToerhApp.controllers'
]).
config(['$routeProvider', '$locationProvider', '$httpProvider', function($routeProvider, $locationProvider, $httpProvider) {
  $routeProvider.when('/', {templateUrl: 'partials/resources.html', controller: 'ResourceController'});
  $routeProvider.when('/view2', {templateUrl: 'partials/partial2.html', controller: 'MyCtrl2'});
  $routeProvider.otherwise({redirectTo: '/view1'});

  $routeProvider.otherwise('/404');

  $locationProvider.html5Mode(true).hashPrefix('!');

  $httpProvider.defaults.useXDomain = true;
  $httpProvider.defaults.headers.common.Authorization = "a9a3a2d126efc4cafcca";
  delete $httpProvider.defaults.headers.common['X-Requested-With'];
}]);
