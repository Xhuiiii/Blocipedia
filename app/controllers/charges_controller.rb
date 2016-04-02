class ChargesController < ApplicationController
	def new
		@stripe_btn_data = {
			key: "#{Rails.configuration.stripe[:publishable_key]}",
			description: "BigMoney Membership - #{current_user.username}",
			amount: Amount.default
		}
	end

	def create
		#creates a stripe customer object for associating with the charge
		customer = Stripe::Customer.create(
			email: current_user.email,
			card: params[:stripeToken]
		)

		charge = Stripe::Charge.create(
			customer: customer.id, #not the user id
			amount: Amount.default,
			description: "Premium Membership - #{current_user.email}",
			currency: 'usd'
		)

		#Update the users role after payment goes through 
		current_user.update_attribute(:role, "premium")

		flash[:notice] = "Thanks for all the money, #{current_user.username}! Feel free to pay me again!"
		redirect_to root_path

		#Catch and display card errors
	rescue Stripe::CardError => e  
		flash[:alert] = e.message
		redirect_to new_charge_path
	end
end


