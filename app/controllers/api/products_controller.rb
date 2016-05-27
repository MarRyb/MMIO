class Api::ProductsController < ApplicationController
	
	def index
		@category_id = params[:category_id]
  	@products = Product.by_category(params[:category_id]).where("title ILIKE '#{params[:title]}%'").limit(10)
  	render json: @products
	end

end