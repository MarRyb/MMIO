class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def home	
  end

  def result
  end

  def predict
  	session[:selected_products_ids] = []
  	load_categories
  end

  def load_categories
  	@categories = Kategory.all
  end

end
