mbkStation.controller('PrazosAdministrativosController', ['$rootScope','$scope','ChartsService', function($rootScope,$scope,ChartsService){
  //--------------------------------------------------------------
  // CHART CONFIG
  //--------------------------------------------------------------
  var config = {
    tooltips: true,
    labels: true,
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
  $scope.prazos_administrativos_chart_config = config;
  $scope.chart_type = 'bar';

  loadRemoteDataAdministrativos(null,{"start_date":$scope.start_date,"end_date":$scope.end_date,"grupo":"Administrativo"});
  //--------------------------------------------------------------
  // $SCOPE FUNCTIONS
  //--------------------------------------------------------------
  $scope.changeChartType = changeChartType = function(chartType) {

    $scope.prazos_administrativos = {};

    if(chartType == 'bar'){
      $scope.prazos_administrativos = $scope.dataForBar;
    } else {
      $scope.prazos_administrativos = $scope.dataForPie;
    }
    $scope.chart_type = chartType;
  };

  //--------------------------------------------------------------
  // EVENT LISTENERS
  //--------------------------------------------------------------
  $scope.$on('dateChanged',loadRemoteDataAdministrativos);

  //--------------------------------------------------------------
  // PRIVATE METHODS
  //--------------------------------------------------------------
  function applyRemoteDataAdministrativos(newData){
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

    $scope.prazos_administrativos = ($scope.chart_type == 'bar') ? $scope.dataForBar : $scope.dataForPie;
  };

  function loadRemoteDataAdministrativos(evt,params) {
    console.log("EVENT LISTENER ADM");
    params.grupo = "Administrativo";
    ChartsService.getPrazosAdministrativos(params).then(function(data){
      applyRemoteDataAdministrativos(data);
    });
  };
}]);
