class OrdersController < ApplicationController
#   def new
#   	require 'rubygems'
# require 'active_merchant'
# require "active_merchant/billing/rails"

# ActiveMerchant::Billing::Base.mode = :test
# gateway = ActiveMerchant::Billing::PaypalGateway.new(
#   :login => "eganpg_api1.gmail.com",
#   :password => "3BRXKD6R4MK4KQLW",
#   :signature => "AIEApycvgcTn0acObJPeknexuSk6Aybh81rryWT.9PWcMNb4KolaOw45"
# )

# credit_card = ActiveMerchant::Billing::CreditCard.new(
#   :brand               => "visa",
#   :number             => "4356400015907573",
#   :verification_value => "360",
#   :month              => 3,
#   :year               => 2018,
#   :first_name         => "Peter",
#   :last_name          => "Egan"
# )

# if credit_card.valid?
#   # or gateway.purchase to do both authorize and capture
#   response = gateway.authorize(1000, credit_card, :ip => "127.0.0.1")
#   if response.success?
#     gateway.capture(1000, response.authorization)
#     puts "Purchase complete!"
#   else
#     puts "Error: #{response.message}"
#   end
# else
#   puts "Error: credit card is not valid. #{credit_card.errors.full_messages.join('. ')}"
# end
#   end
def new
	@order = Order.new
end

def create
  @order = current_cart.build_order(params[:order])
  @order.ip_address = request.remote_ip
  if @order.save
    if @order.purchase
      render :action => "success"
    else
      render :action => "failure"
    end
  else
    render :action => 'new'
  end
end
end
