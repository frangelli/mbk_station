# This migration comes from vlaw_core_lib_engine (originally 20121017235624)
class AddAuthorityIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :authority_id, :integer
    add_index :users, :authority_id
  end
end
