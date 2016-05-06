class CreateRacions < ActiveRecord::Migration
  def change
    create_table :racions do |t|
      t.date :date
      t.float :gramm		
      t.references :user
      t.references :product

      t.timestamps null: false
    end
  end
end
