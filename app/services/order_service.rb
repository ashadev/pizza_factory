class OrderService
  def initialize(order_params)
    @order_params = order_params
    @inventory_service = InventoryService.new
  end

  def place_order(order_params = @order_params)
    user = User.find_by(id: order_params[:user_id])
    order = Order.new(status: 'pending', total_price: 0, user_id: user&.id)

    # Validate each pizza in the order
    validate_pizza(order, order_params)

    # Add sides
    order_params[:side_ids].each do |side_id|
      side = Side.find(side_id)
      order.order_sides.build(side: side, price: side.price)
    end

    # Calculate total price
    order.total_price = calculate_total_price(order)

    # Check inventory
    if @inventory_service.check_and_reserve_stock(order)
      order.status = 'confirmed'
      order.save!
      return order
    else
      raise "Insufficient inventory to place the order"
    end
  end

  private
  def validate_pizza(order, order_params)
    order_params[:pizzas].each do |pizza_data|
      pizza = Pizza.find(pizza_data[:pizza_id])
      crust = Crust.find(pizza_data[:crust_id])
      size = pizza_data[:size]

      raise "Invalid crust selection" if crust.nil?

      order_pizza = order.order_pizzas.build(pizza: pizza, crust: crust, size: size, price: pizza_price(pizza, size))

      # Validate and add toppings
      added_toppings = []
      pizza_data[:topping_ids].each do |topping_id|
        topping = Topping.find(topping_id)

        validate_topping(pizza, topping, added_toppings)

        order_pizza.order_toppings.build(topping: topping, price: topping_price(order_pizza, topping, added_toppings))
        added_toppings << topping
      end
    end
  end

  def pizza_price(pizza, size)
    case size
    when 'regular' then pizza.regular_price
    when 'medium' then pizza.medium_price
    when 'large' then pizza.large_price
    else
      raise "Invalid pizza size"
    end
  end

  def validate_topping(pizza, topping, added_toppings)
    if pizza.vegetarian? && topping.non_veg?
      raise "Vegetarian pizzas cannot have non-vegetarian toppings"
    elsif pizza.non_vegetarian? && topping.name == 'Paneer'
      raise "Non-vegetarian pizzas cannot have paneer topping"
    elsif topping.non_veg? && added_toppings.any?(&:non_veg?)
      raise "Only one non-veg topping allowed per non-vegetarian pizza"
    end
  end

  def topping_price(order_pizza, topping, added_toppings)
    return 0 if order_pizza.size == 'large' && added_toppings.size < 2
    topping.price
  end

  def calculate_total_price(order)
    order.order_pizzas.sum(&:price) + order.order_toppings.sum(&:price) + order.order_sides.sum(&:price)
  end
end
