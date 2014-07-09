#encoding: utf-8
class SituacaoPrazoPorFuncionario < ActiveRecord::Base


  attr_accessible :funcionario, :funcionario_id, :pendente, :realizado, :reanotado, :dia, :created_at

  belongs_to :funcionario

  def self.import_data_from_percept(dia = nil)
  	dia = Date.today unless dia

  	start_date = end_date = dia
  	Percept::AgendaPrazo.prazos_situacao_por_responsavel_no_periodo(start_date,end_date).each do |nome,data|
  		data["pendente"] = 0 if data["pendente"].blank?
  		data["realizado"] = 0 if data["realizado"].blank?
  		data["reanotado"] = 0 if data["reanotado"].blank?

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
  			item.save
  		else
  			create(funcionario_id: funcionario.id, dia: dia, pendente: data["pendente"], realizado: data["realizado"], reanotado: data["reanotado"])
  		end
  	end
  end

  def self.dados_por_periodo(start_date,end_date,grupo = "Advogados")
  	start_date = Date.today unless start_date
  	end_date = Date.today unless end_date

  	start_date = start_date.beginning_of_day
	  end_date = end_date.end_of_day

  	select("funcionario_id, SUM(pendente) as pendente, SUM(realizado) as realizado, SUM(reanotado) as reanotado")
  	.where("funcionario_id IN (?) AND dia BETWEEN ? AND ?",Funcionario.where(grupo:grupo).pluck(:id),start_date,end_date)
  	.group("funcionario_id")
  end


end
