class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def home	
  end

  def result
    use_case = Calculate::Result.new(current_user.id, params[:height][0].to_f, params[:weight][0].to_f, params[:activnost_id][:id], session[:selected_products_ids])
    @result = use_case.run
  end

  def predict
  	session[:selected_products_ids] = []
  	load_categories
  end

  def load_categories
  	@categories = Kategory.all
  end

  def beer
    
  end

end
