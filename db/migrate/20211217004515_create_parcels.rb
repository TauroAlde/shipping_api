class CreateParcels < ActiveRecord::Migration[6.1]
  def change
    create_table :parcels do |t|
      t.decimal :lenght, precision: 10, sacle: 2
      t.decimal :width, precision: 10, sacle: 2
      t.decimal :height, precision: 10, sacle: 2
      t.string :dimension_unit
      t.decimal :weight, precision: 10, sacle: 2
      t.string :weight_unit
      t.references :shipment, index: true
      t.timestamps
    end
  end
end
