class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.references :law, foreign_key: true
      t.references :document, foreign_key: true
      t.datetime :asked_at
      t.datetime :answered_at

      t.timestamps
    end
  end
end
