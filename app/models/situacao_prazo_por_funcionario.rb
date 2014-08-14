#encoding: utf-8
class SituacaoPrazoPorFuncionario < ActiveRecord::Base


  attr_accessible :funcionario, :funcionario_id, :pendente, :realizado, :reanotado, :nao_coube, :dia, :created_at

  belongs_to :funcionario

  def self.import_data_from_percept(dia = nil)
  	dia = Date.today unless dia

  	start_date = end_date = dia
  	Percept::AgendaPrazo.prazos_situacao_por_responsavel_no_periodo(start_date,end_date).each do |nome,data|
  		data["pendente"] = 0 if data["pendente"].blank?
  		data["realizado"] = 0 if data["realizado"].blank?
  		data["reanotado"] = 0 if data["reanotado"].blank?
      data["nao_coube"] = 0 if data["nao_coube"].blank?

      funcionario = Funcionario.find_by_nome_percept(nome)
      unless funcionario
        Rails.logger.error "Funcionário com nome_percept #{nome} não encontrado. Favor cadastrar"
        next
      end

  		item = where("funcionario_id = ? AND dia = ?",funcionario.id,dia).first

  		if item
  			item.pendente = data["pendente"]
  			item.realizado = data["realizado"]
  			item.reanotado = data["reanotado"]
        item.nao_coube = data["nao_coube"]
  			item.save
  		else
  			create(funcionario_id: funcionario.id, dia: dia, pendente: data["pendente"], realizado: data["realizado"], reanotado: data["reanotado"], nao_coube: data["nao_coube"])
  		end
  	end
  end

  def self.dados_por_periodo(start_date,end_date,grupo = "Advogados")
  	start_date = Date.today unless start_date
  	end_date = Date.today unless end_date

  	start_date = start_date.beginning_of_day
	  end_date = end_date.end_of_day

  	select("funcionario_id, SUM(pendente) as pendente, SUM(realizado) as realizado, SUM(reanotado) as reanotado, SUM(nao_coube) as nao_coube")
  	.where("funcionario_id IN (?) AND dia BETWEEN ? AND ?",Funcionario.where(grupo:grupo).pluck(:id),start_date,end_date)
  	.group("funcionario_id")
  end


end
