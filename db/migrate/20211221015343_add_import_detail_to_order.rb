class AddImportDetailToOrder < ActiveRecord::Migration[6.1]
  def change
    add_reference :orders, :import_detail, index: true
  end
end
