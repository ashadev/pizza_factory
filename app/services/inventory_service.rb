class InventoryService
  def check_and_reserve_stock(order)
    # ActiveRecord::Base.transaction do
      order.order_pizzas.each do |order_pizza|
        update_inventory(:pizza, order_pizza.pizza.id)
        update_inventory(:crust, order_pizza.crust.id)
      end

      order.order_toppings.each do |order_topping|
        update_inventory(:topping, order_topping.topping.id)
      end

      order.order_sides.each do |order_side|
        update_inventory(:side, order_side.side.id)
      end
    # end
    true
  rescue StandardError
    false
  end

  private

  def update_inventory(item_type, item_id)
    inventory = Inventory.find_by(item_type: item_type, item_id: item_id)
    raise "Out of stock: #{item_type} #{item_id}" if inventory.nil? || inventory.quantity <= 0
    inventory.decrement!(:quantity)
  end
end
