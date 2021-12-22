class CreateImportDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :import_details do |t|
      t.uuid :uuid
      t.integer :row
      t.text :error
      t.integer :status
      t.text :data
      t.text :headers
      t.timestamps
    end
  end
end
