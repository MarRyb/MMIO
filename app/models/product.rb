class Product < ActiveRecord::Base
  belongs_to :kategory

  mount_uploader :picture, ProductPictureUploader
end
