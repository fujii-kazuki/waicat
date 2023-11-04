class CreateCats < ActiveRecord::Migration[6.1]
  def change
    create_table :cats do |t|
      t.integer :user_id,               null: false
      t.string :publication_title,      null: false, default: ""
      t.string :name,                   null: false, default: ""
      t.float :age,                     null: false, default: ""
      t.integer :gender,                null: false
      t.float :weight,                  null: false, default: ""
      t.string :breed,                  null: false, default: ""
      t.string :animal_print,           null: false, default: ""
      t.integer :hair_length,           null: false, default: ""
      t.boolean :castration_flag,       null: false, default: false
      t.boolean :vaccine_flag,          null: false, default: false
      t.string :postal_code,            null: false, default: ""
      t.string :prefecture,             null: false, default: ""
      t.string :municipalitie,          null: false, default: ""
      t.text :background
      t.text :personality
      t.text :health
      t.text :delivery_place
      t.text :remarks
      t.datetime :publication_date,     null: false
      t.datetime :publication_deadline, null: false
      t.integer :publication_status,    null: false

      t.timestamps
    end
  end
end
