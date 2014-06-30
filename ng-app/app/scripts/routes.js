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
          templateUrl: '/views/shared/404.html'
        },

        //principal
        'main': {
          abstract: true,
          templateUrl: '/views/main.html',
          controller: 'MainController'
        },

        'main.dashboard': {
          url: '/painel',
          views: {
            'content@main':  {
              templateUrl: '/views/dashboard.html',
              controller: 'DashboardController'
            }
          }
        }
    };

    angular.forEach(states, function(stateConfig, stateName) {
      $stateProvider.state(stateName, stateConfig);
    });

    $urlRouterProvider.otherwise('/404');

}]);
