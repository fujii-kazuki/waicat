class CreateAnimalPrints < ActiveRecord::Migration[6.1]
  def change
    create_table :animal_prints do |t|
      t.string :name, null: false, default: ""

      t.timestamps
    end
  end
end
