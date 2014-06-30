class HomeController < ApplicationController
	def index

		respond_to do |format|
			format.json {render json: [teste: "testando"]}
			format.xml {render xml: [teste: "testando"]}
		end
	end
end
