class CreateChatrooms < ActiveRecord::Migration[6.1]
  def change
    create_table :chatrooms do |t|
      t.integer :candidate_id, null: false
      t.boolean :deleted_flag, null: false, default: false

      t.timestamps
    end
  end
end
