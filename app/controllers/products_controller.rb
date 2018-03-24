class ProductsController < ApplicationController
	def index
		@products= Product.all.order(:title)
		#@product= @products.find(params[:product_id]).includes(:variants).order(:title)

	end
end
