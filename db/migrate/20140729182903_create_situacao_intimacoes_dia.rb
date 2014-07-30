class CreateSituacaoIntimacoesDia < ActiveRecord::Migration
  def change
    create_table :situacao_intimacoes_dia do |t|
      t.date :dia
      t.integer :nao_classificadas
      t.integer :classificadas
      t.integer :lancadas
      t.integer :lixeira

      t.timestamps
    end
  end
end
