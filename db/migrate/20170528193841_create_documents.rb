class CreateDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :documents do |t|
      t.string :source_url
      t.text :contents
      t.string :filetype
      t.integer :filesize

      t.timestamps
    end
  end
end
