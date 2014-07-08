# This migration comes from vlaw_core_lib_engine (originally 20121009223613)
class CreateClientes < ActiveRecord::Migration
  def change
    create_table :clientes do |t|
      t.string :nome, null: false, limit: 100
      t.string :descricao, limit: 255

      t.timestamps
    end
  end
end
