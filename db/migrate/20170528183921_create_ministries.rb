class CreateMinistries < ActiveRecord::Migration[5.1]
  def change
    create_table :ministries do |t|
      t.string :name, null: false
      t.string :slug, null: false

      t.timestamps
    end
    add_index :ministries, :slug, unique: true
  end
end
