var module = angular.module('ToerhApp.directives');

module.directive('validateSame', function() {
    return {
        require: 'ngModel',
        link: function(scope, elm, attrs, c) {
            scope.$watch(attrs.ngModel, function() {
                if (scope.user) {
                    if (scope.user.password === scope.user.password_confirmation) {
                        c.$setValidity('same', true);
                    }

                    else {
                        c.$setValidity('same', false);
                    }    
                }
                
            });
        }
    }
});