class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.belongs_to :category, null: false
      t.string :description
      t.decimal :price
      t.integer :make
    end
  end
end
