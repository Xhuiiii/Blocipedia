class UsersController < ApplicationController
	def edit
		@user = current_user
		@user.update_attributes(role: 'standard')

		if @user.save
			flash[:notice] = "Account downgraded to 'Standard'"
			redirect_to wikis_path

			#make wikis public when user account is downgraded
			@user.wikis.each do |wiki|
				wiki.update_attribute(:private, false)
			end
		else
			flash[:alert] = "Could not downgrade your account."
		end
	end

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
