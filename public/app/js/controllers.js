'use strict';

var timelineControllers = angular.module('timelineControllers', []);

timelineControllers.controller('EventListCtrl', ['$scope','$http',
  function($scope, $http){
    $http.get('/events.json').success(function(data) {
     $scope.events = data;
    });

    $scope.orderProp = 'date';
    
    $scope.deleteEvent = function(eventID) {
      alert("Deleted event");

      $http.delete('/events/' + eventID, {
        params: {angular: true}}).success(function(response) {
        $http.get('/events.json').success(function(data) {
          $scope.events = data;
        });
      })
    }
  }]);

timelineControllers.controller('CategoryListCtrl', ['$scope', '$http',
  function($scope, $http) {
    $http.get('/categories.json').success(function(data) {
      $scope.categories = data;
    });

    $scope.orderProp = 'name';

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