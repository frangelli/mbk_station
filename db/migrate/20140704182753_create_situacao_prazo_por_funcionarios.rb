class CreateSituacaoPrazoPorFuncionarios < ActiveRecord::Migration
  def change
    create_table :situacao_prazo_por_funcionarios do |t|
      t.string :funcionario
      t.integer :pendente
      t.integer :realizado
      t.integer :reanotado
      t.date :dia

      t.timestamps
    end
  end
end
