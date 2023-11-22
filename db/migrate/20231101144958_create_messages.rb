class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.integer :user_id,     null: false
      t.integer :chatroom_id, null: false
      t.text :body,           null: false

      t.timestamps
    end
  end
end
