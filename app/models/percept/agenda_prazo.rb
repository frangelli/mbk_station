class Percept::AgendaPrazo < Percept::Base
	self.table_name = "pv_agenda_prazos"

	belongs_to :prazo, class_name: "Percept::Prazo", foreign_key: :evento, primary_key: :tipo
	belongs_to :funcionario, class_name: "Percept::Funcionario", foreign_key: :responsavel, primary_key: :nome

	def self.responsaveis_com_prazo_legal()
		joins(:prazo, :funcionario).where("prazos.legal = 1 AND funcionarios.unidade IS NOT NULL").uniq.pluck(:responsavel)
	end

	def self.responsaveis_sem_prazo_legal()
		joins(:prazo, :funcionario).where('prazos.legal = 0 AND funcionarios.unidade IS NOT NULL AND responsavel NOT IN (?)',responsaveis_com_prazo_legal).group(:responsavel).uniq.pluck(:responsavel)
	end

	def self.prazos_situacao_por_responsavel_no_periodo start_date, end_date
		start_date = start_date.beginning_of_day
		end_date = end_date.end_of_day
		#precisamos dos prazos pendentes, cumpridos e reanotados
		# O retorno será no seguinte formato:
		# [
		#   "responsavel1":
		#		{
		#			"Pendente":
		#			"Cumprido":
		# 			"Reanotado":
		#		},
		#    ...
		# ]

		#no percept a coluna situacao segue a seguinte lógica
		# O CAMPO SITUAÇÃO PODE ASSUMIR OS SEGUINTES VALORES:
	 	# 0 = Pendentes (Lançador de Prazos)
	 	# 1 = Cumpridos (Quando advogado cumpre o prazo)
	 	# 2 = Nao Coube (Quando prazo não se encaixa no contexto do processo)
	 	# 3 = Perdido (Quando alguem define prazo como Perdido, ou seja, a data passou e ninguem cumpriu o prazo)
	    # 7 = Realizados (Azul) (Quando a peça é elaborada, mas nao eh cumprido ainda)



	 	#Na regra deste relatório vamos seguir a seguinte logica:
	 	# todos prazos no período sem dt_anterior no período
	 	# CUMPRIDO = situacao 1,2 ou 7
	 	# PENDENTE = situacao 0
	 	cumpridos_e_pendentes = select("responsavel, situacao, count(*) as count")
	 	.where(" data_agenda BETWEEN ? AND ?
	 		AND (
	 			dt_anterior NOT BETWEEN ? AND ?
	 			OR dt_anterior IS NULL
	 		)",start_date, end_date,start_date,end_date)
	 	.group("responsavel, situacao")

	 	retVal = {}
	 	cumpridos_e_pendentes.each do |count|
	 		retVal[count.responsavel] = {} unless retVal[count.responsavel]
	 		if [1,2,7].include? count.situacao
	 			retVal[count.responsavel]["cumprido"] = count.count
	 		else
	 			retVal[count.responsavel]["pendente"] = count.count
	 		end
	 	end

	 	# REANOTADO = um prazo é considerado reanotado quando dt_anterior
	 	# é preenchida no período definido e situacao 0

	 	reanotados = select("responsavel, count(*) as count")
	 	.where("( dt_anterior BETWEEN ? AND ?
	 			AND dt_anterior IS NOT NULL )
	 			AND situacao = 0", start_date, end_date)
	 	.group("responsavel")


	 	reanotados.each do |count|
	 		retVal[count.responsavel] = {} unless retVal[count.responsavel]
	 		retVal[count.responsavel]["reanotado"] = count.count
	 	end

		retVal
	end

end