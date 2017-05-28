class AddShortNameToMinistry < ActiveRecord::Migration[5.1]
  def change
    add_column :ministries, :short_name, :string
    add_index :ministries, :short_name, unique: true
  end
end
