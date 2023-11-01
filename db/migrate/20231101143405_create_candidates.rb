class CreateCandidates < ActiveRecord::Migration[6.1]
  def change
    create_table :candidates do |t|
      t.integer :user_id, null: false
      t.integer :cat_id,  null: false
      t.integer :status,  null: false, default: 0

      t.timestamps
    end
  end
end
