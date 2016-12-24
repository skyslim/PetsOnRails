class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:admin]
    
  def home
  end

  def contactus
  end

  def aboutus
  end

  def petguide
  end

  def admin
  end
end
