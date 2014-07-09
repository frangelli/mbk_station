mbkStation.service('ChartsService', ['$http','$q', function($http,$q){

  //--------------------------------------------------------------
  // PUBLIC INTERFACE
  //--------------------------------------------------------------
  return {

    getPrazosPorAdvogado: getPrazosPorAdvogado

  };

  //--------------------------------------------------------------
  // PUBLIC METHOS (returned by the service above)
  //--------------------------------------------------------------
  //situacao_prazo_por_funcionario/grafico.json
  function getPrazosPorAdvogado(params){
        var request = $http({
            method: "get",
            url: "/situacao_prazo_por_funcionario/grafico.json",
            params: params
        });

        return( request.then( handleSuccess, handleError ) );
  };

  //--------------------------------------------------------------
  // PRIVATE METHODS
  //--------------------------------------------------------------
  function handleSuccess(response) {
    return response.data;
  };

  function handleError(response) {
    if (
        ! angular.isObject( response.data ) ||
        ! response.data.message
        ) {

        return( $q.reject( "An unknown error occurred." ) );

    }

    // Otherwise, use expected error message.
    return( $q.reject( response.data.message ) );
  };

}]);
