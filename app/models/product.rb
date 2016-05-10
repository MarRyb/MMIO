class Product < ActiveRecord::Base
	paginates_per 50

  belongs_to :kategory

  mount_uploader :picture, ProductPictureUploader

  scope :by_category, ->(category_id){ where kategory_id: category_id }

end