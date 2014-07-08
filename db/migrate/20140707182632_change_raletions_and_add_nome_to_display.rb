class ChangeRaletionsAndAddNomeToDisplay < ActiveRecord::Migration
  def change
  	add_column :funcionarios, :nome_percept, :string
  	add_column :funcionarios, :ativo, :integer, default: 1


  	execute "update funcionarios set nome_percept = nome, ativo = 1"

  	add_column :situacao_prazo_por_funcionarios, :funcionario_id, :integer

  	execute "update situacao_prazo_por_funcionarios set funcionario_id = (select id from funcionarios where nome = funcionario limit 1)"

  	remove_column :situacao_prazo_por_funcionarios, :funcionario


  	add_index :situacao_prazo_por_funcionarios, :funcionario_id
  end

end
