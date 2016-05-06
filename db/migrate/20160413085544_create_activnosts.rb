class CreateActivnosts < ActiveRecord::Migration
  def change
    create_table :activnosts do |t|
      t.string :title
      t.text :description
      t.text :picture
      t.float :uglevody_percent
      t.float :belky_percent
      t.float :zhiry_percent
      t.float :activity_coef


      t.timestamps null: false
    end
  end
end
