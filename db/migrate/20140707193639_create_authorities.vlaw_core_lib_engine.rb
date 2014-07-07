# This migration comes from vlaw_core_lib_engine (originally 20121018002415)
class CreateAuthorities < ActiveRecord::Migration
  def change
    create_table :authorities do |t|
      t.string :name
      t.string :display_name
      t.integer :remote_id

      t.timestamps
    end
  end
end
