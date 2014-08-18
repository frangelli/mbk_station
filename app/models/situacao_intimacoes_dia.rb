class SituacaoIntimacoesDia < ActiveRecord::Base
  attr_accessible :classificadas, :dia, :lancadas, :lixeira, :nao_classificadas

  def self.import_data_from_percept(dia = nil)
    dia = Date.today unless dia



    # POG Monster plus, porque só trabalhamos com dada te publicação
    if dia.wday == 1 #segunda
      # na segunda-feira, precisamos capturar os dados da sexta anterior, afinal
      # nenhuma intimação é publicada nem sábado, nem domingo
      start_date = end_date = dia - 3.day
    elsif [0,7].include? dia.wday #sábado ou domingo
      # não importa nada, pois o setor de intimações não trabalha sábado ou domingo
      return
    else
      # vou buscar no percept sempre o dia anterior,
      # onde a data de publicação foi ontem, o trabalho será feito hoje.
      start_date = end_date = dia - 1.day
    end

    data = Percept::Intimacao.situacao_no_periodo(start_date,end_date)

    item = where("dia = ?",dia).first

    if item
      item.nao_classificadas = data["nao_classificadas"]
      item.classificadas =  data["classificadas"]
      item.lancadas =  data["lancadas"]
      item.lixeira =  data["lixeira"]
      item.save
    else
      create(
        dia: dia,
        nao_classificadas: data["nao_classificadas"],
        classificadas: data["classificadas"],
        lancadas: data["lancadas"],
        lixeira: data["lixeira"]
        )
    end
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
