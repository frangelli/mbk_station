#encoding: utf-8

namespace :import_data do
	desc "Tasks para importação de dados na aplicação"

	task :percept => :environment do
		desc "importar dados da base do percepttools"

		SituacaoPrazoPorFuncionario.import_data_from_percept
		puts "Dados importados com sucesso."
	end

end