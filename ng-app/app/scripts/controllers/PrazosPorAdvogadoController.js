mbkStation.controller('PrazosPorAdvogadoController', ['$rootScope','$scope','ChartsService', function($rootScope,$scope,ChartsService){

  //--------------------------------------------------------------
  // CHART CONFIG
  //--------------------------------------------------------------
  var config = {
    title: 'Prazos por Advogado',
    tooltips: true,
    labels: false,
    legend: {
      display: true,
      //could be 'left, right'
      position: 'right'
    },
    innerRadius: 0, // applicable on pieCharts, can be a percentage like '50%'
    lineLegend: 'lineEnd' // can be also 'traditional'
  };

  //--------------------------------------------------------------
  // $SCOPE VARIABLES
  //--------------------------------------------------------------
  $scope.prazos_por_advogado_chart_config = config;
  $scope.chart_type = 'bar';
  // $scope.prazos_por_advogado_data = {};

  loadRemoteData(null,{"start_date":$scope.start_date,"end_date":$scope.end_date,"grupo":"Advogados"});
  //--------------------------------------------------------------
  // $SCOPE FUNCTIONS
  //--------------------------------------------------------------
  $scope.changeChartType = changeChartType = function(chartType) {

    $scope.prazos_por_advogado_data = {};

    if(chartType == 'bar'){
      $scope.prazos_por_advogado_data = $scope.dataForBar;
    } else {
      $scope.prazos_por_advogado_data = $scope.dataForPie;
    }
    $scope.chart_type = chartType;
  };

  //--------------------------------------------------------------
  // EVENT LISTENERS
  //--------------------------------------------------------------
  $scope.$on('dateChanged',loadRemoteData);

  //--------------------------------------------------------------
  // PRIVATE METHODS
  //--------------------------------------------------------------
  function applyRemoteData(newData){
    $scope.dataForBar = newData;

    var dataForPie = JSON.parse(JSON.stringify(newData));

    angular.forEach(dataForPie.data,function (value,key){
      var totalY = 0;
      angular.forEach(value.y,function(v,k){
        totalY = totalY + v;
      });
      dataForPie.data[key].y = [totalY];
    });
    $scope.dataForPie = JSON.parse(JSON.stringify(dataForPie));

    $scope.prazos_por_advogado_data = ($scope.chart_type == 'bar') ? $scope.dataForBar : $scope.dataForPie;
  };

  function loadRemoteData(evt,params) {
    params.grupo = "Advogados";
    ChartsService.getPrazosPorAdvogado(params).then(function(data){
      applyRemoteData(data);
    });
  };
}]);
