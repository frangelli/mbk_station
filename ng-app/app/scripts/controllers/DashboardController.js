mbkStation.controller('DashboardController', ['$scope','$http', function($scope,$http){

  $http({method: 'GET', url: 'http://localhost:3000/home.json'}).
    success(function(data, status, headers, config) {
      $scope.teste = data;
    }).
    error(function(data, status, headers, config) {
      // called asynchronously if an error occurs
      // or server returns response with an error status.
    });

}]);
