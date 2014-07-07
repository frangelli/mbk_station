# This migration comes from vlaw_core_lib_engine (originally 20121009223617)
class CreateUnidades < ActiveRecord::Migration
  def change
    create_table :unidades do |t|
       t.string :nome, null: false, limit: 100
      t.string :descricao, limit: 255
      t.integer :cliente_id, null: false
      
      t.timestamps
    end
    
    add_index :unidades, :cliente_id
  end
end
