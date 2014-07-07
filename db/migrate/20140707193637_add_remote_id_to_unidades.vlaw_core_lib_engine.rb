# This migration comes from vlaw_core_lib_engine (originally 20121017210915)
class AddRemoteIdToUnidades < ActiveRecord::Migration
  def change
    add_column :unidades, :remote_id, :integer

  end
end
