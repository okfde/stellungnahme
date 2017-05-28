class CreateLawsMinistriesJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_join_table :laws, :ministries do |t|
      # t.index [:law_id, :ministry_id]
      t.index [:ministry_id, :law_id], unique: true
    end
  end
end
