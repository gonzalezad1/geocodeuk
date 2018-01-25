class AddScaleToOffices < ActiveRecord::Migration[5.1]
  def change
    change_column :offices, :lat, :decimal, precision: 15, scale: 13
    change_column :offices, :long, :decimal, precision: 15, scale: 13

  end
end
