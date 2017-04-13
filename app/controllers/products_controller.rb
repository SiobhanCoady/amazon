class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def new
    @product = Product.new
  end

  def create
    @product = Product.new product_params
    @product.user = current_user

    if @product.save
      redirect_to product_path(@product), notice: 'Product created'
    else
      render :new
    end
  end

  def index
    @products = Product.last(20)
  end

  def show
    @review = Review.new
  end

  def edit
    redirect_to root_path, alert: 'Access denied' unless can? :edit, @product
  end

  def update
    if !(can? :edit, @product)
      redirect_to root_path, alert: 'Access denied'
    elsif @product.update(product_params)
      redirect_to product_path(@product), notice: 'Product Updated'
    else
      render :edit
    end
  end

  def destroy
    if can? :destroy, @product
      @product.destroy
      redirect_to products_path, notice: 'Product Deleted'
    else
      redirect_to root_path, alert: 'Access denied'
    end
  end

  private

  def find_product
    @product = Product.find params[:id]
  end

  def product_params
    params.require(:product).permit([:title, :description, :price, :category_id])
  end
end
