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
  function getPrazosPorAdvogado(){
        var request = $http({
            method: "get",
            url: "/test_data/prazos_por_advogado.json"
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
