'use strict';


// Declare app level module which depends on filters, and services
angular.module('ToerhApp', [
  'ngRoute',
  'ToerhApp.filters',
  'ToerhApp.services',
  'ToerhApp.directives',
  'ToerhApp.controllers'
]).
config(['$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
  $routeProvider.when('/', {templateUrl: 'partials/resources.html', controller: 'ResourceController'});
  $routeProvider.when('/view2', {templateUrl: 'partials/partial2.html', controller: 'MyCtrl2'});
  $routeProvider.otherwise({redirectTo: '/view1'});

  $routeProvider.otherwise('/404');

  $locationProvider.html5Mode(true).hashPrefix('!');
}]);
