class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.float :zhiri
      t.float :belki
      t.float :uglevodi
      t.float :calorynost
      t.text :picture
      t.references :kategory, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
