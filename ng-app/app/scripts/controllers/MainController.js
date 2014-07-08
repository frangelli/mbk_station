mbkStation.controller('MainController', ['$rootScope', '$scope','$state', function($rootScope, $scope,$state){

  //--------------------------------------------------------------
  // SCOPE VARIABLES
  //--------------------------------------------------------------
  $scope.$state = $state;
  $scope.start_date = moment().format("DD/MM/YYYY");
  $scope.end_date = moment().format("DD/MM/YYYY");

  //--------------------------------------------------------------
  // SCOPE METHODS
  //--------------------------------------------------------------
  $scope.filterData = function(){
    $rootScope.$broadcast('dateChanged',{"start_date":$scope.start_date,"end_date":$scope.end_date});
  };

}]);
