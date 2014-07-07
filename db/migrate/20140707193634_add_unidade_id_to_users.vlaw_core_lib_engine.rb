# This migration comes from vlaw_core_lib_engine (originally 20121009223620)
class AddUnidadeIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :unidade_id, :integer
    add_index :users, :unidade_id
  end
end
