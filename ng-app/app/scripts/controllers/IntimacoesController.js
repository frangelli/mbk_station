mbkStation.controller('IntimacoesController', ['$rootScope','$scope','ChartsService', function($rootScope,$scope,ChartsService){
  //--------------------------------------------------------------
  // CHART CONFIG
  //--------------------------------------------------------------
  var config = {
    title: 'Setor de Intimações',
    tooltips: true,
    labels: true,
    legend: {
      display: true,
      //could be 'left, right'
      position: 'right'
    },
    innerRadius: 0, // applicable on pieCharts, can be a percentage like '50%'
    lineLegend: 'traditional' // can be also 'traditional'
  };

  //--------------------------------------------------------------
  // $SCOPE VARIABLES
  //--------------------------------------------------------------
  $scope.intimacoes_dia_chart_config = config;
  $scope.chart_type = 'pie';
  $scope.intimacoes_dia_data = {};
  loadRemoteDataIntimacoes(null,{"start_date":$scope.start_date,"end_date":$scope.end_date});
  //--------------------------------------------------------------
  // $SCOPE FUNCTIONS
  //--------------------------------------------------------------


  //--------------------------------------------------------------
  // EVENT LISTENERS
  //--------------------------------------------------------------
  $scope.$on('dateChanged',loadRemoteDataIntimacoes);

  //--------------------------------------------------------------
  // PRIVATE METHODS
  //--------------------------------------------------------------
  function applyRemoteDataIntimacoes(newData){
    $scope.intimacoes_dia_data = newData;
  };

  function loadRemoteDataIntimacoes(evt,params) {
    console.log("EVENT LISTENER INTIMACOES");
    ChartsService.getIntimacoesByStatus(params).then(function(data){
      applyRemoteDataIntimacoes(data);
    });
  };
}]);
