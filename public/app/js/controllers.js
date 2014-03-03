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
        params: {angular: true}}).success(function(response) {
        $http.get('http://localhost:3000/events.json').success(function(data) {
          $scope.events = data;
        });
      })
    }
  }]);

timeline



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