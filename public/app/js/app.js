'use strict';

//this used to be in our controllers 
// but now that we have more than one
// controller, it's going in here!

//the empty array argument also now holds
//2 items, these are the modules that the
//app depends on
// ngRoutes - allows us to use angular-route.js
// spacecatControllers - al
var timelineApp = angular.module('timelineApp', [
  'ngRoute',
  'timelineControllers'
]);

timelineApp.config(['$routeProvider',
  function($routeProvider) {
    $routeProvider.
      when('/events', {
        templateUrl: 'partials/event-list.html',
        controller: 'EventListCtrl'
      }).
      otherwise({
        redirectTo: '/events'
      });
  }]);

// myAngularApp.config([
//   "$httpProvider", function($httpProvider) {
//     $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
//   }
// ]);