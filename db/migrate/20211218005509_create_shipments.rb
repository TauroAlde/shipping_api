class CreateShipments < ActiveRecord::Migration[6.1]
  def change
    create_table :shipments do |t|
      t.references :order, index: true
      t.references :address_from, index: true
      t.references :address_to, index: true
      t.timestamps
    end
  end
end
