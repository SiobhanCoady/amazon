class Api::V1::ProductsController < ApplicationController
  before_action :authenticate_user

  def index
    @products = Product.all
  end

  def show
    @product = Product.find params[:id]
  end

  private

  def authenticate_user
    @user = User.find_by_api_token params[:api_token]
    head :unauthorized if @user.nil?
  end
end
