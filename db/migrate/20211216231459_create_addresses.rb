class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string :name
      t.string :email
      t.string :street1
      t.string :city
      t.string :province
      t.integer :postal_code
      t.integer :contry_code
      t.timestamps
    end
  end
end
