class AddNaoCoubeToSituacaoPrazosPorFuncionario < ActiveRecord::Migration
  def change
  	add_column :situacao_prazo_por_funcionarios, :nao_coube, :integer
  end
end
