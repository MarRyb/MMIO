class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable, :confirmable

	mount_uploader :avatar, UserAvatarUploader

  def age
  	Date.today.year - birthday.year
  end
  
end