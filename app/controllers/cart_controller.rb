class CartController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def remove
      id = params[:id]
      
      cart = session[:cart] || {}
 
      cart.delete(id)
      
      session[:cart] = cart
	  
      redirect_to :action => :index
  end

  def change
      id = params[:id]
      quantity = params[:quantity].to_i
      
      if quantity == 0 # if there is no item, then remove the item from the cart

          remove
          
      else #otherwise update its quantity

          cart = session[:cart] || {}

          cart[id] = quantity

          session[:cart] = cart
	
          redirect_to :action => :index
      end
  end
    
  def add
      id = params[:id]
      
      cart = session[:cart] || {}
      
      cart[id] = (cart[id] || 0) + 1
      
      session[:cart] = cart
	  
      redirect_to :action => :index
  end

  def index
      @cart = session[:cart] || {}
	  
  end

  def empty
      #empty the session
      session[:cart] = nil
      
      #redirect_to :action => :index
  end

end
