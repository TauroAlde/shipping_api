class ChangeContryCodeTypeToString < ActiveRecord::Migration[6.1]
  def change
    change_column :addresses, :contry_code, :string
  end
end
