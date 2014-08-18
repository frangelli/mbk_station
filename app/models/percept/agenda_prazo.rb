#encoding: utf-8
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

  def self.import_prazos_situacao_por_responsavel_no_dia dia
    start_date = dia.beginning_of_day
    end_date = dia.end_of_day
    #precisamos dos prazos pendentes, cumpridos e reanotados
    # O retorno será no seguinte formato:
    # [
    #   "responsavel1":
    #   {
    #     "Pendente":
    #     "Cumprido":
    #       "Reanotado":
    #   },
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
    # CUMPRIDO = situacao 1 ou 7
    # NAO COUBE = 2
    # PENDENTE = situacao 0
    cumpridos_e_pendentes = select("responsavel, prazos.legal as legal, situacao, count(*) as count")
        .joins(:prazo)
        .where(" data_agenda BETWEEN ? AND ?
          AND (
            dt_anterior NOT BETWEEN ? AND ?
            OR dt_anterior IS NULL
          )",start_date, end_date,start_date,end_date)
        .order("responsavel, prazos.legal, situacao")
        .group("responsavel, prazos.legal, situacao")

    cumpridos_e_pendentes.each do |count|
      begin
        prazosPorFuncionario = SituacaoPrazoPorFuncionario.find_or_create count.responsavel, count.legal, dia
      rescue Exception => e
        Rails.logger.info "Dado de funcionário ignorado e não importado: "+e.message
        next
      end

      if [1,7].include? count.situacao
        prazosPorFuncionario.realizado = prazosPorFuncionario.realizado + count.count
      elsif count.situacao == 2
        prazosPorFuncionario.nao_coube = count.count
      else
        prazosPorFuncionario.pendente = count.count
      end

      prazosPorFuncionario.save
    end

    reanotados = select("responsavel, prazos.legal as legal, count(*) as count")
        .joins(:prazo)
        .where("( dt_anterior BETWEEN ? AND ?
            AND dt_anterior IS NOT NULL )
            AND situacao = 0", start_date, end_date)
        .group("responsavel, prazos.legal")


    reanotados.each do |count|
      begin
        prazosPorFuncionario = SituacaoPrazoPorFuncionario.find_or_create count.responsavel, count.legal, dia
      rescue Exception => e
        Rails.logger.info "Dado de funcionário ignorado e não importado: "+e.message
        next
      end

      prazosPorFuncionario.reanotado = count.count
      prazosPorFuncionario.save
    end

  end

end