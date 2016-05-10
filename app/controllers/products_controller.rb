class ProductsController < ApplicationController
	
	before_filter :find_product, only: [:select, :remove]

	def select
		session[:selected_products_ids] = [] if !session[:selected_products_ids].is_a? Array
		session[:selected_products_ids] << @product.id
		session[:selected_products_ids] = session[:selected_products_ids].uniq
		@products = Product.where id: session[:selected_products_ids]
	end

	def remove
		session[:selected_products_ids] = session[:selected_products_ids] - [@product.id]
		@products = Product.where id: session[:selected_products_ids]
	end

  def load_collection
  	@category_id = params[:category_id]
  	@products = Product.page(params[:page]).per(8).by_category(params[:category_id])
  end

private

	def find_product
		@product = Product.find params[:id]
	end

end