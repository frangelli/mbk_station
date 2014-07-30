# encoding: utf-8
class SituacaoIntimacoesDiaController < ApplicationController
	def grafico
		start_date = Date.strptime(params[:start_date],"%d/%m/%Y") if params[:start_date]
		end_date = Date.strptime(params[:end_date],"%d/%m/%Y") if params[:end_date]

		data = SituacaoIntimacoesDia.dados_por_periodo(start_date,end_date)

		ret = {
			data: [
				{x: "Não Classificadas", y: [data.nao_classificadas]},
				{x: "Classificadas", y: [data.classificadas]},
				{x: "Lançadas", y: [data.lancadas]},
				{x: "Lixeira", y: [data.lixeira]}
			]
		}

		respond_to do |format|
			format.json {render json: ret}
		end
	end
end
