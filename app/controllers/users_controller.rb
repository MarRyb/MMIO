class UsersController < ApplicationController
	
	def profile
	end

	def update
		current_user.update permitted_params
		redirect_to profile_users_path
	end

	def edit
	end

private

	def permitted_params
		params.require(:user).permit!
	end

end