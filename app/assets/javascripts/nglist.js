  var myApp = angular.module('myApp', []);

  myApp.controller("BeersController", function ($scope, $http) {
    $http.get('beers.json').success( function(data, status, headers, config) {
      $scope.beers = data;
    });

    $scope.order = 'name';

    $scope.sort_by = function (order){
      $scope.order = order;
      console.log(order);
    }

    $scope.searchText = '';
  });
