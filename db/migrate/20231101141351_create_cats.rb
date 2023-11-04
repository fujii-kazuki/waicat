class CreateCats < ActiveRecord::Migration[6.1]
  def change
    create_table :cats do |t|
      t.integer :user_id,               null: false
      t.string :publication_title
      t.string :name
      t.float :age
      t.integer :gender                
      t.float :weight
      t.string :breed
      t.string :animal_print
      t.integer :hair_length
      t.boolean :castration_flag,       default: false
      t.boolean :vaccine_flag,          default: false
      t.string :postal_code
      t.string :prefecture
      t.string :municipalitie
      t.text :background
      t.text :personality
      t.text :health
      t.text :delivery_place
      t.text :remarks
      t.date :publication_date
      t.date :publication_deadline
      t.integer :publication_status,    null: false

      t.timestamps
    end
  end
end
