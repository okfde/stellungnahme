class AddDraftReferenceToComment < ActiveRecord::Migration[5.1]
  def change
    add_reference :comments, :draft, foreign_key: true
  end
end
