class Api::V1::ProductsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :authenticate_user

  def index
    @products = Product.all
  end

  def show
    @product = Product.find params[:id]
  end

  def create
    @product = Product.new product_params
    @product.user = @user

    if @product.save
      render json: "Product created!"
    else
      render json: "There was an error"
    end
  end

  private

  def authenticate_user
    @user = User.find_by_api_token params[:api_token]
    head :unauthorized if @user.nil?
  end

  def product_params
    params.require(:product).permit([ :title,
                                      :description,
                                      :price,
                                      :sale_price,
                                      :category_id,
                                      { tag_ids: [] }
                                    ])
  end
end
