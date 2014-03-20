var module = angular.module('ToerhApp.services');

module.factory('UserService', function($http, $window) {
    //var baseUri = 'http://toerh.dev/api/v1/users';
    var baseUri = 'http://toerh.matthis.se/api/v1/users';

    return {
        user: function(userID) {
            return $http.get(baseUri + '/' + userID + '.json');
        },

        save: function(user) {
            $http.defaults.headers.common.Authorization = $window.sessionStorage.token;

            if (user.user_id) {
                return $http.put(baseUri + '/' + user.user_id + '.json', user);
            }

            return $http.post(baseUri + '.json', user);
        },

        destroy: function(userID) {
            $http.defaults.headers.common.Authorization = $window.sessionStorage.token;
            return $http.delete(baseUri + '/' + userID + '.json');
        }
    }
});