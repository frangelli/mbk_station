mbkStation.directive('toggle',[function() {
  return {
    restrict: 'A',
    scope: {
    },
    link: function(scope, element, attrs) {
      element.on('click', function(event){
        event.preventDefault();
        var targets = attrs.targets.split(",");
        angular.forEach(targets,function(value,key){
          var el = $(value);
          el.slideToggle( "slow" );
        });

        //--------------------------------------------------------------
        // POG: gamb para dar um toggle no margin-top do body por conta do menu e fullscreen
        //--------------------------------------------------------------
        var fullPage = document.documentElement;
        var bodyMargin = $('body').css('margin-top');
        if(bodyMargin === '70px') {
            $('body').css('margin-top','0px');
            if(fullPage.requestFullscreen) {
              fullPage.requestFullscreen();
            } else if(fullPage.mozRequestFullScreen) {
              fullPage.mozRequestFullScreen();
            } else if(fullPage.webkitRequestFullscreen) {
              fullPage.webkitRequestFullscreen();
            } else if(fullPage.msRequestFullscreen) {
              fullPage.msRequestFullscreen();
            }
        } else {
          $('body').css('margin-top','70px');
            if(document.exitFullscreen) {
              document.exitFullscreen();
            } else if(document.mozCancelFullScreen) {
              document.mozCancelFullScreen();
            } else if(document.webkitExitFullscreen) {
              document.webkitExitFullscreen();
            }
        }

      });
    }
  }
}]);

// function launchFullscreen(element) {
//   if(element.requestFullscreen) {
//     element.requestFullscreen();
//   } else if(element.mozRequestFullScreen) {
//     element.mozRequestFullScreen();
//   } else if(element.webkitRequestFullscreen) {
//     element.webkitRequestFullscreen();
//   } else if(element.msRequestFullscreen) {
//     element.msRequestFullscreen();
//   }
// }
// function exitFullscreen() {
//   if(document.exitFullscreen) {
//     document.exitFullscreen();
//   } else if(document.mozCancelFullScreen) {
//     document.mozCancelFullScreen();
//   } else if(document.webkitExitFullscreen) {
//     document.webkitExitFullscreen();
//   }
// }
