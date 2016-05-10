class Kategory < ActiveRecord::Base
	has_many :products
	mount_uploader :picture, CategoryPictureUploader
end
