class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :destroy, :add_item]

  def show
    render json: @cart.as_json, status: :ok
  end

  def create
    @cart = find_or_create_cart
    product = Product.find_by(id: params[:product_id])

    return render json: { error: 'Product not found' }, status: :not_found unless product
    return render json: { error: 'Quantity must be greater than 0' }, status: :unprocessable_entity if params[:quantity].to_i <= 0

    cart_item = @cart.cart_items.find_or_initialize_by(product: product)
    cart_item.quantity = cart_item.persisted? ? cart_item.quantity + params[:quantity].to_i : params[:quantity].to_i

    if cart_item.save
      @cart.update_last_interaction!
      session[:cart_id] = @cart.id
      render json: @cart.as_json, status: :created
    else
      render json: { errors: cart_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    product = Product.find_by(id: params[:id])

    return render json: { error: 'Product not found' }, status: :not_found unless product

    cart_item = @cart.cart_items.find_by(product: product)

    return render json: { error: 'Product not in cart' }, status: :not_found unless cart_item

    if cart_item.destroy
      @cart.update_last_interaction!
      render json: @cart.as_json, status: :ok
    else
      render json: { error: 'Failed to remove product' }, status: :unprocessable_entity
    end
  end

  def add_item
    product = Product.find_by(id: params[:product_id])

    return render json: { error: 'Product not found' }, status: :not_found unless product
    return render json: { error: 'Quantity must be greater than 0' }, status: :unprocessable_entity if params[:quantity].to_i <= 0

    cart_item = @cart.cart_items.find_or_initialize_by(product: product)
    cart_item.quantity = cart_item.persisted? ? cart_item.quantity + params[:quantity].to_i : params[:quantity].to_i

    if cart_item.save
      @cart.update_last_interaction!
      render json: @cart.as_json, status: :ok
    else
      render json: { errors: cart_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_cart
    @cart = session[:cart_id] ? Cart.find_by(id: session[:cart_id]) : nil
    render json: { error: 'Cart not found' }, status: :not_found unless @cart
  end

  def find_or_create_cart
    cart = session[:cart_id] ? Cart.find_by(id: session[:cart_id]) : nil
    cart ||= Cart.create!(session_id: generate_session_id)
    cart
  end

  def generate_session_id
    SecureRandom.uuid
  end
end
