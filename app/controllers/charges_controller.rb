class ChargesController < ApplicationController
	def new
		@total_amount = total_amount
	end

	def create
		
		@total_amount = total_amount

	  customer = Stripe::Customer.create(
		:email => params[:stripeEmail],
		:source  => params[:stripeToken]
	  )

	  charge = Stripe::Charge.create(
		:customer    => customer.id,
		:amount      => (@total_amount  * 100).to_i, # amount in cents
		:description => 'Rails Stripe customer',
		:currency    => 'eur'
	  )

	session[:cart] = nil
		
	rescue Stripe::CardError => e
	  flash[:error] = e.message
	  redirect_to new_charge_path
	end
	
	
	
	 def total_amount
	 
		# constants
		deliveryCost = 5.0
		tax = 20
		money = "€"
		# variables
		item_number = 0
		total_price_without_tax = 0.0
		total_price_with_tax = 0.0
		# current cart
		cart = session[:cart] || {}

		# calculate the cart status
		cart.each do |id, quantity|
			product = Product.find_by_id(id)
			item_number = item_number + quantity
			total_price_without_tax = total_price_without_tax + product.price * quantity
		end

		total_price_with_tax =  if item_number == 0 
									0.0
								else
									(deliveryCost + total_price_without_tax) * (100.0 + tax) / 100.0
								end


		total_price_with_tax.round(2)
	end
end
