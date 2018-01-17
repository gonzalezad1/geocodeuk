class AddAdresseToOffices < ActiveRecord::Migration[5.1]
  def change
    add_column :offices, :address, :string
  end
end
