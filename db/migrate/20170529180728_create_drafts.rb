class CreateDrafts < ActiveRecord::Migration[5.1]
  def change
    create_table :drafts do |t|
      t.references :law, foreign_key: true
      t.datetime :published_at
      t.references :document, foreign_key: true

      t.timestamps
    end
  end
end
