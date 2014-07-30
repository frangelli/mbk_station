class Percept::Intimacao < Percept::Base
    self.table_name = "classificaintima"

    def self.situacao_no_periodo start_date, end_date
        retVal = {}
        start_date = start_date.beginning_of_day
        end_date = end_date.end_of_day

        # precisamos da contagem da situação das intimações no sistema
        # Não Classificadas -> revisado=0
        # Classificadas -> revisado=1, statusCPJ=0, status_1 = NOSSO
        # Lançadas (inclui sem prazos)  -> status_1 = NOVO, statusCPJ=1 | status_1 = NOSSO, revisado=2, statusCPJ=0
        # Lixeira  -> status_1 = LIXEIRA, revisado = 1
        counts = select("count(*) as count, status_cpj, revisado, status_1")
            .where("data_publicacao BETWEEN ? AND ?",start_date, end_date)
            .group(:revisado, :status_cpj, :status_1)

        nao_classificadas = 0
        classificadas = 0
        lancadas = 0
        lixeira = 0
        counts.each do |count|
            puts count.inspect
            if count.revisado == 1 and count.status_cpj == 0 and count.status_1 == "NOSSO"
                classificadas = classificadas + count.count
            elsif count.status_cpj == 1 || ( count.status_1 == "NOSSO" and count.revisado == 2 )
                lancadas = lancadas + count.count
            elsif count.revisado == 1 and count.status_1 == "LIXEIRA"
                lixeira = lixeira + count.count
            else
                nao_classificadas = nao_classificadas + count.count
            end

        end

        retVal["nao_classificadas"] = nao_classificadas
        retVal["classificadas"] = classificadas
        retVal["lancadas"] = lancadas
        retVal["lixeira"] = lixeira

        retVal
    end
end