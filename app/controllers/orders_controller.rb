class OrdersController < ApplicationController
	before_action :set_order, only: [:cancel]

	def create
	    ActiveRecord::Base.transaction do
	      order = OrderService.new(params[:order]).place_order
	      render json: { message: "Order placed successfully", order_id: order.id }, status: :ok
	    rescue StandardError => e
	      render json: { error: e.message }, status: :unprocessable_entity
	    end
  	end

	def cancel
		if @order.pending?
		  @order.update(status: :canceled)  # Mark the order as canceled
		  render json: { message: 'Order has been canceled successfully.' }
		else
		  render json: { error: 'Cannot cancel a confirmed or delivered order.' }, status: :unprocessable_entity
		end
	end

	private

	def set_order
		user = User.find_by(params[:user_id])

		if user.nil?
		  render json: { error: 'User not found' }, status: :not_found
		  return
		end
		p user.orders
		@order = user.orders.find_by(id: params[:id])
		if @order.nil?
		  render json: { error: 'Order not found' }, status: :not_found
		  return
		end
	end

	def order_params
		params.require(:order).permit(:id, :user_id, :side_ids, pizzas: [:pizza_id, :size, :crust_id, :topping_ids])
	end
end