class CreateLaws < ActiveRecord::Migration[5.1]
  def change
    create_table :laws do |t|
      t.string :title, null: false
      t.string :slug, null: false

      t.timestamps
    end

    add_index :laws, :slug, unique: true
  end
end
