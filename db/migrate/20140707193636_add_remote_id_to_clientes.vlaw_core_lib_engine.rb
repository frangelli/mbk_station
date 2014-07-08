# This migration comes from vlaw_core_lib_engine (originally 20121017210902)
class AddRemoteIdToClientes < ActiveRecord::Migration
  def change
    add_column :clientes, :remote_id, :integer

  end
end
