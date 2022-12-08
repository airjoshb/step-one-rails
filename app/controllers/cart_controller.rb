class CartController < ApplicationController
  def show
    # @render_cart = false
  end

  def add
    @variation = Variation.find_by(id: params[:id])
    quantity = params[:quantity].to_i
    current_orderable = @cart.orderables.find_by(variation_id: @variation.id)
    if quantity <= 0
      current_orderable.destroy
    else
      @cart.orderables.create(variation: @variation, quantity: quantity)
    end

    respond_to do |format|
      format.html { redirect_to cart_path }
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace('cart', partial: 'cart/icon', locals: {cart: @cart})
      end
    end
  end

  def remove
    Orderable.find_by(id: params[:id]).destroy

    respond_to do |format|
      format.html { redirect_to cart_path }
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace('cart', partial: 'cart/prices', locals: {cart: @cart})
      end
    end
  end

end
