(function() {
	/**
	 * Modal service
	 *
	 * Use this service to communicate with a modal (share state data, access controllers, show/hide...)
	 * @author Darlan
	 */
	function $modalProvider() {
		/**
		 * Finds a modal by id. Returns a instance of Modal
		 *
		 * @param {String} modalId
		 * @return {Modal}
		 */
		this.$get = ['$document', 'Modal',
			function($document, Modal) {
				return function(modalId) {
					var modalElement = $document.find('#' + String(modalId).replace('#', '')),
						modal;

					if (modalElement.length) {
						modal = modalElement.data('$modal') || null;

						if (null === modal) {
							modal = new Modal(modalElement);
							modalElement.data('$modal', modal);
						}

						return modal;
					}

					return null;
				};
			}
		];
	}

	function ModalClassFactory($timeout) {

		/**
		 * Sets arbitrary data into modal instance
		 *
		 * BE CAUTIOUS! This method will store references, so make sure you remove the data
		 * when it is no longer necessary!
		 *
		 * @param {String} name     A unique identifier to this stuff
		 * @param value
		 */
		function setData(name, value) {
			this.$data[name] = value;
		}

		/**
		 * Remove data
		 * @param {String} name
		 */
		function removeData(name) {
			delete this.$data[name];
		}

		function block() {
			this.element.addClass('ui-blocked');
		}

		function unblock() {
			this.element.removeClass('ui-blocked');
		}

		/**
		 * Tries to fetch previously saved data
		 * @param {String} name     The identifier of this stuff
		 * @return {null|mixed}     Returns null if not found
		 */
		function getData(name) {
			var data = this.$data;
			return typeof data[name] !== 'undefined' ? data[name] : null;
		}

		/**
		 * Show modal
		 */
		function show(fn) {
			var el = this.element.modal('show');

			$timeout(function() {
				// autofocus on first input
				el.find('[autofocus]').focus();

				if (typeof fn === 'function') {
					fn();
				}
			}, 650);
		}

		/**
		 * Hide modal
		 */
		function hide(fn) {
			this.element.modal('hide');
			$timeout(function() {
				if (typeof fn === 'function') {
					fn();
				}
			}, 200);
		}

		/**
		 * Finds the modal scope
		 * NOTE: modals have isolated scope, so we must dig down to get it right
		 * @private
		 */
		function getScope() {
			if (!this.$scope) {
				var element = this.element;

				if (element && element.length) {
					this.$scope = angular.element(element[0]).scope() || null;
				}
			}

			return this.$scope;
		}

		function setScope($scope) {
			this.$scope = $scope;
		}

		function setElement(element) {
			this.element = element;
		}

		function getElement() {
			return this.element;
		}

		/*function proxyToEvents(methodName) {
			return function(a, b, c, d, e) {
				return this.$events[methodName](a, b, c, d, e);
			};
		}*/

		/**
		 * @class Modal
		 */
		var Modal = extend(EventEmitter, {
			constructor: function Modal(element) {
				this.element = element;
				this.$data = {};
			},

			$scope: null,

			show: show,
			hide: hide,
			setData: setData,
			getData: getData,
			removeData: removeData,
			block: block,
			unblock: unblock,
			getScope: getScope,
			setScope: setScope,
			getElement: getElement,
			setElement: setElement
		});

		return Modal;
	}

	angular.module('yepApp')
		.provider('$modal', $modalProvider)
		.factory('Modal', ['$timeout', ModalClassFactory]);

}());