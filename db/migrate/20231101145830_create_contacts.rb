class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.integer :user_id,     null: false
      t.string :title,        null: false, default: ""
      t.text :body,           null: false
      t.boolean :readed_flag, null: false, default: false

      t.timestamps
    end
  end
end
