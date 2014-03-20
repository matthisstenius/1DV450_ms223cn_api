'use strict';

var module = angular.module('NotificationProvider', []);

module.service('Notifications', function($window) {
    this.setNotification = function(message) {
        $window.sessionStorage.notification = message;
    };

    this.getNotification = function() {
        var notification = $window.sessionStorage.notification
        this.removeNotification();
        return notification;
    };

    this.removeNotification = function() {
        delete $window.sessionStorage.notification;
    };
});