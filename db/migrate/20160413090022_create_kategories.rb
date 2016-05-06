class CreateKategories < ActiveRecord::Migration
  def change
    create_table :kategories do |t|
      t.string :title
      t.text :description
      t.text :picture

      t.timestamps null: false
    end
  end
end
