# This migration comes from vlaw_core_lib_engine (originally 20121009223623)
class AddEmailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email, :string

  end
end
