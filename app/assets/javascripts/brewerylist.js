  var myApp2 = angular.module('myApp2', []);

  myApp2.controller("BreweriesController", function ($scope, $http) {
    $http.get('breweries.json').success( function(data, status, headers, config) {
      $scope.breweries = data;
    });

    $scope.order = 'name';

    $scope.sort_by = function (order){
      $scope.order = order;
      console.log(order);
    }

    $scope.searchText = '';
  });
