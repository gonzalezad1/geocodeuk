class FixColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :offices, :long, :lng
  end
end
