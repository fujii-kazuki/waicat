class CreateNotices < ActiveRecord::Migration[6.1]
  def change
    create_table :notices do |t|
      t.integer :user_id,      null: false
      t.string :title,         null: false, default: ""
      t.text :body,            null: false, default: ""
      t.boolean :readed_flag,  null: false, default: false
      t.boolean :deleted_flag, null: false, default: false

      t.timestamps
    end
  end
end
