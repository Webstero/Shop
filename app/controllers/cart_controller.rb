# frozen_string_literal: true

class CartController < ApplicationController
  def show
    @cart = current_cart
  end

  def edit
    @cart = current_cart
    @cart.build_address if @cart.address.blank?
  end

  def update
    @cart = current_cart
    if @cart.update(cart_attributes)
      @cart.update_attribute(:shipping_cost, @cart.shipping_type.cost)
      redirect_to confirmation_cart_path
    else
      render action: :edit
    end
  end

  def confirmation
    @cart = current_cart
  end

  def finish
    @cart = current_cart
    @cart.transition_to :confirmed
    session.delete(:order_id)
    flash[:notice] = 'Dziękujemy za zamówienie!'
    redirect_to root_path
  end

  def add_product
    order = current_cart_or_create
    product = Product.find(params[:product_id])
    if item = order.line_items.where(product:).first
      item.quantity += 1
      item.save
    else
      order.line_items.create product:,
                              quantity: 1,
                              unit_price: product.price,
                              item_name: product.name
    end
    redirect_back(fallback_location: root_path, notice: 'Dodano produkt do koszyka')
  end

  def remove_product
    order = current_cart

    product = Product.find(params[:product_id])
    item = order.line_items.where(product:).first
    item&.destroy
    redirect_back(fallback_location: root_path, notice: 'Usunięto produkt z koszyka')
  end

  private

  def cart_attributes
    params.require(:order).permit(
      :shipping_type_id,
      :comment,
      address_attributes: %i[
        first_name
        last_name
        city
        zip_code
        street
        email
      ]
    )
  end
end
