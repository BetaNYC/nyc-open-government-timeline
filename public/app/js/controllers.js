'use strict';

var eventsControllers = angular.module('timelineControllers', []);

timelineApp.controller('EventListCtrl', ['$scope','$http',
  function($scope, $http){
    $http.get('http://localhost:3000/events.json').success(function(data) {
     $scope.events = data;
    });

    $scope.orderProp = 'name';
    
    $scope.deleteEvent = function(eventID) {
      alert("POOP");

      $http.delete('/events/' + eventID, {
        params: {authenticity_token: "693adc79550c672efede13aef56e7e63eba8a23e70b428c996abfb9fb83a2b29791da6ca283ac47dfad45e2e73143451b74241f561f8f8ca926b66446c77d533"}
      }).success(function(response) {
        $http.get('http://localhost:3000/events.json').success(function(data) {
          $scope.events = data;
        });
      })
    }
  }]);

// spacecatControllers.controller('CatDetailCtrl', ['$scope', '$routeParams', '$http',
//   function($scope, $routeParams, $http) {
//     $http.get("cats/cats-" + $routeParams.catId + '.json').success(function(data) {
//       $scope.cat = data[0];
//       $scope.mainImg = data[0].images[0];
//     });

//     $scope.setImage = function(imageName) {
//       $scope.mainImg = imageName;
//     }
//   }]);