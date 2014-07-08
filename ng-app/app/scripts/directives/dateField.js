mbkStation.directive('dateField',[function() {
	return {
		restrict: 'A',
		scope: {
		},
		link: function(scope, element, attrs) {
			element.datepicker({
				dateFormat: 'dd/mm/yy',
        defaultDate: new Date()
			});

		}
	}
}]);
