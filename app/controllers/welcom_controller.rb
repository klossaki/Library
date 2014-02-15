class WelcomController < ApplicationController
    
  rescue_from CanCan::AccessDenied do |exception|
    flash.keep[:error] = "Access denied."
    redirect_to root_url
  end
  
  def index
  end
  
end
