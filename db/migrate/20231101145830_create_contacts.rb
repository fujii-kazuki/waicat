class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.integer :user_id, null: false
      t.string :title,    null: false, default: ""
      t.text :body,       null: false, default: ""

      t.timestamps
    end
  end
end
