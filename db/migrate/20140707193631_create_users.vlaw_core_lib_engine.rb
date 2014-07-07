# This migration comes from vlaw_core_lib_engine (originally 20101007212537)
class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :uid
      t.string :first_name
      t.string :last_name
      t.string :status

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
