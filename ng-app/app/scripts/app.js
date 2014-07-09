//--------------------------------------------------------------
// MODULO PRINCIPAL ( APP EM SI)
//--------------------------------------------------------------
var mbkStation = angular.module('mbkStation', [
    'ngCookies',
    'ngSanitize',
    'ui.router',
    'angular-loading-bar',
    'angularCharts'
  ]);

mbkStation.constant('DEV_MODE', true);

//--------------------------------------------------------------
// PARA AS ROTAS VER O ARQUIVO routes.js
//--------------------------------------------------------------
