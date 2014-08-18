class AddTipoAdministrativoLegalSituacaoPrazos < ActiveRecord::Migration
  def change
  	add_column :situacao_prazo_por_funcionarios, :legal, :boolean
  end
end
