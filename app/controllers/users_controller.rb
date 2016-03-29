class UsersController < ApplicationController
	def index
		@users = User.all  
	end

	def show
		@user = User.find(params[:id])
		authorize @user
	end

	def destroy
		@user = User.find(params[:id])

		if user.destroy
			flash[:notice] = "User deleted."
			redirect_to users_path
		else
			flash[:alert] = "Failed to delete user."
		end
	end

end
