class CreateActivities < ActiveRecord::Migration[6.1]
  def change
    create_table :activities do |t|
      t.integer :user_id, null: false
      t.text :body,       null: false, default: ""

      t.timestamps
    end
  end
end
