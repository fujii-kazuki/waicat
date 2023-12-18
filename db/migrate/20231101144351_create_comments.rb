class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :cat_id,       null: false
      t.integer :user_id,      null: false
      t.text :body,            null: false
      t.boolean :deleted_flag, null: false, default: false

      t.timestamps
    end
  end
end
