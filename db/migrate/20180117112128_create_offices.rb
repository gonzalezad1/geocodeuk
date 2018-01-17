class CreateOffices < ActiveRecord::Migration[5.1]
  def change
    create_table :offices do |t|
      t.string :name
      t.decimal :lat,:precision => 15, :scale => 14
      t.decimal :long,:precision => 15, :scale => 14
      t.string :postcode

      t.timestamps
    end
  end
end
