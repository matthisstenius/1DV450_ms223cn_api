var module = angular.module('ToerhApp.filters', []);

module.filter('excerpt', function() {
    return function(text, length) {
        if (text.length > length) {
            return String(text).slice(0, length) + '...';
        }

        return text;
    }
});