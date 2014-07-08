# This migration comes from vlaw_core_lib_engine (originally 20121219163248)
class AddColumnsToOptions < ActiveRecord::Migration
  def change
    add_column :options, :option_display_name, :string
    add_column :options, :option_value_type, :string
  end
end
