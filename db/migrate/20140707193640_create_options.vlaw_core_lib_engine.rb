# This migration comes from vlaw_core_lib_engine (originally 20121119104338)
class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.string :option_name
      t.string :option_value
      t.string :option_description
      t.integer :unidade_id

      t.timestamps
    end
    add_index :options, :unidade_id
  end
end
