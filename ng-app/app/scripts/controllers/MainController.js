mbkStation.controller('MainController', ['$rootScope', '$scope','$state','$interval', function($rootScope, $scope,$state,$interval){

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

  //--------------------------------------------------------------
  // TIMEOUT TO REFRESH DATA
  //--------------------------------------------------------------
  $interval(function(){
    $rootScope.$broadcast('dateChanged',{"start_date":$scope.start_date,"end_date":$scope.end_date});
  },900000);

  $scope.available_states = ['main.dashboard','main.advogados','main.administrativos','main.intimacoes'];
  $scope.current = 0;

  $interval(function(){
    console.log("trocando state");
    if($scope.current < ($scope.available_states.length -1)) {
      $scope.current++;
      console.log("entrou no incremento");
    } else {
      $scope.current = 0;
    }
      console.log($scope.available_states[$scope.current]);
      $state.go($scope.available_states[$scope.current]);
  },300000);

}]);
