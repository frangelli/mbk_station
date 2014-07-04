(function() {

	/**
	 * Modal directives
	 *
	 * @example
	 *  <modal id="modal-test" modal-label="foo-bar-baz">
	 * 		<modal-header text="{{ theModalTitle }}"></modal-header>
	 *
	 * 		<modal-content>  ... Content ... </modal-content>
	 *
	 * 		<modal-footer>
	 * 			<button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
	 * 			<button data-dismiss="modal" class="btn btn-primary">Confirm</button>
	 * 		</modal-footer>
	 *  </modal>
	 *
	 * @author Davi
	 * @author Darlan
	 */
	function modalDirective(Modal) {
		return {
			restrict: 'E',
			replace: true,
			transclude: true,
			template: '<div class="modal fade"><div class="modal-dialog"><div class="modal-content" ng-transclude></div></div></div>',
			scope: {
				modalLabel: '@label',
			},

			link: function($scope, $element, $attrs) {
				var modal = $element.data('$modal');

				if (!modal) {
					modal = new Modal($element);
					$element.data('$modal', modal);
				}

				// TODO $modal($attrs.id)

				$element.on('shown.bs.modal', function() {
					modal.emit('show', modal);
				});

				$element.on('hidden.bs.modal', function() {
					modal.emit('hide', modal);
				});
			}
		};
	}

	function modalHeaderDirective() {
		return {
			restrict: 'E',
			replace: true,
			template: '<div class="modal-header">' +
				'<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>' +
				'<h3>{{title}}</h3>' +
				'</div>',
			scope: {
				title: '@text'
			}
		};
	}

	function modalBodyDirective() {
		return {
			restrict: 'E',
			replace: true,
			transclude: true,
			template: '<div class="modal-body" ng-transclude></div>'
		};
	}

	function modalFooterDirective() {
		return {
			restrict: 'E',
			replace: true,
			transclude: true,
			template: '<div class="modal-footer" ng-transclude></div>'
		};
	}

	function modalHrefDirective() {
		return function($scope, $element, $attrs) {
			if (!$attrs.modalHref) return;

			var href = $attrs.modalHref;

			$element.on('click', function() {
				var modal = $modal(href);

				if (modal) {
					modal.show();
					return;
				}

				$(href).modal('show');
			});
		}
	}

	function modalHideHrefDirective($modal) {
		return function($scope, $element, $attrs) {
			if (!$attrs.modalHideHref) return;

			var href = $attrs.modalHideHref;

			$element.on('click', function() {
				var modal = $modal(href);

				if (modal) {
					modal.hide();
					return;
				}

				// old modals
				$(href).modal('hide');
			});
		}
	}

	mbkStation
		.directive('modal', ['Modal', modalDirective])
		.directive('modalHeader', modalHeaderDirective)
		.directive('modalBody', modalBodyDirective)
		.directive('modalFooter', modalFooterDirective)
		.directive('modalHref', modalHrefDirective)
		.directive('modalHideHref', ['$modal', modalHideHrefDirective]);

}());
