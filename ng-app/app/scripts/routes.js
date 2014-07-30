/**
* App routes
*
* @autor Leonardo Frangelli
*/
mbkStation.config(['$stateProvider','$urlRouterProvider',function ($stateProvider, $urlRouterProvider) {

    var states =  {

        'index': {
          url: '',
          controller: ['$location',
              function($location){
                $location.path('/painel');
              }
          ]
        },

        //404
        '404': {
          url:'/404',
          templateUrl: 'views/shared/404.html'
        },

        //principal
        'main': {
          abstract: true,
          templateUrl: 'views/main.html',
          controller: 'MainController'
        },

        'main.dashboard': {
          url: '/painel',
          views: {
            'content@main':  {
              templateUrl: 'views/dashboard.html',
              controller: 'DashboardController'
            }
          }
        },

        'main.advogados': {
          url: '/advogados',
          views: {
            'content@main':  {
              templateUrl: 'views/prazos_por_advogado.html'
            }
          }
        },

        'main.administrativos': {
          url: '/administrativos',
          views: {
            'content@main':  {
              templateUrl: 'views/prazos_administrativos.html'
            }
          }
        },

        'main.intimacoes': {
          url: '/intimacoes',
          views: {
            'content@main':  {
              templateUrl: 'views/intimacoes_dia.html'
            }
          }
        }

    };

    angular.forEach(states, function(stateConfig, stateName) {
      $stateProvider.state(stateName, stateConfig);
    });

    $urlRouterProvider.otherwise('/404');

}]);
