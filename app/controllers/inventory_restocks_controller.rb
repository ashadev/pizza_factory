class InventoryRestocksController < ApplicationController
  before_action :check_admin

  # POST /inventory/restock
  def restock
    item_type = params[:item_type]
    item_id = params[:item_id]
    quantity = params[:quantity].to_i

    return render json: { error: "Invalid quantity" }, status: :unprocessable_entity if quantity <= 0

    inventory = Inventory.find_or_initialize_by(item_type: item_type, item_id: item_id)
    inventory.quantity += quantity

    if inventory.save
      render json: { message: "Inventory restocked successfully", inventory: inventory }, status: :ok
    else
      render json: { error: "Failed to restock inventory" }, status: :unprocessable_entity
    end
  end

  private

  def check_admin
    user = User.find_by(id: params[:user_id])
    if user.nil?
      render json: { error: "User not found." }, status: :not_found
      return
    end

    unless user.admin?
      render json: { error: "Only admin can able to add Inventory" }, status: :unauthorized
      return
    end
  end

  def order_params
    params.require(:inventory).permit(:user_id, :item_type, :item_id, :quantity)
  end
end

