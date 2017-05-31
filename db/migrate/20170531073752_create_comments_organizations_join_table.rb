class CreateCommentsOrganizationsJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_join_table :comments, :organizations do |t|
      # t.index [:comment_id, :organization_id]
      t.index [:organization_id, :comment_id], unique: true
    end
  end
end