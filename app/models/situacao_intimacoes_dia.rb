class SituacaoIntimacoesDia < ActiveRecord::Base
  attr_accessible :classificadas, :dia, :lancadas, :lixeira, :nao_classificadas

  def self.import_data_from_percept(dia = nil)
    dia = Date.today unless dia

    # vou buscar no percept sempre o dia anterior, onde a data de publicação foi ontem, o trabalho será feito hoje.
    start_date = end_date = dia - 1.day
    data = Percept::Intimacao.situacao_no_periodo(start_date,end_date)

    create(
        dia: dia,
        nao_classificadas: data["nao_classificadas"],
        classificadas: data["classificadas"],
        lancadas: data["lancadas"],
        lixeira: data["lixeira"]
        )

  end

  def self.dados_por_periodo(start_date,end_date)
    start_date = Date.today unless start_date
    end_date = Date.today unless end_date

    start_date = start_date.beginning_of_day
    end_date = end_date.end_of_day

    data = select("SUM(nao_classificadas) as nao_classificadas, SUM(lancadas) as lancadas, SUM(classificadas) as classificadas, sum(lixeira) as lixeira")
    .where("dia BETWEEN ? AND ?",start_date,end_date)

    data = data[0]
    data.nao_classificadas = 0 unless data.nao_classificadas
    data.classificadas = 0 unless data.classificadas
    data.lancadas = 0 unless data.lancadas
    data.lixeira = 0 unless data.lixeira

    data
  end
end
