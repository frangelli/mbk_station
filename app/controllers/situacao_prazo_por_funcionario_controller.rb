#encoding: utf-8
class SituacaoPrazoPorFuncionarioController < ApplicationController
	def grafico
		start_date = Date.strptime(params[:start_date],"%d/%m/%Y") if params[:start_date]
		end_date = Date.strptime(params[:end_date],"%d/%m/%Y") if params[:end_date]
		grupo = params[:grupo]

		data = SituacaoPrazoPorFuncionario.dados_por_periodo(start_date,end_date,grupo)

		ret = {
			series: ['Realizados', 'Pendentes', 'Reanotados', 'Não Coube'],
			data: []
		}

		data.each do |item|
			ret[:data] << {
					x: item.funcionario.nome,
					y: [item.realizado,item.pendente,item.reanotado,item.nao_coube]
				}
		end

		respond_to do |format|
			format.json {render json: ret}
		end
	end
end
