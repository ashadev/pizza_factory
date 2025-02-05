# db/seeds.rb
puts "Hold on!, started to create seed data"
# Creating Users
admin = User.create!(email: "admin@example.com", password: "password", admin: true)
customer = User.create!(email: "customer@example.com", password: "password", admin: false)

# Crusts
Crust.create([{ name: 'New hand tossed' }, { name: 'Wheat thin crust' }, { name: 'Cheese Burst' }, { name: 'Fresh pan pizza' }])

# Pizzas (Vegetarian)
Pizza.create([
  { name: 'Deluxe Veggie', category: 'vegetarian', regular_price: 150, medium_price: 200, large_price: 325 },
  { name: 'Cheese and corn', category: 'vegetarian', regular_price: 175, medium_price: 375, large_price: 475 },
  { name: 'Paneer Tikka', category: 'vegetarian', regular_price: 160, medium_price: 290, large_price: 340 }
])

# Pizzas (Non-Vegetarian)
Pizza.create([
  { name: 'Non-Veg Supreme', category: 'non_vegetarian', regular_price: 190, medium_price: 325, large_price: 425 },
  { name: 'Chicken Tikka', category: 'non_vegetarian', regular_price: 210, medium_price: 370, large_price: 500 },
  { name: 'Pepper Barbecue Chicken', category: 'non_vegetarian', regular_price: 220, medium_price: 380, large_price: 525 }
])

# Toppings (Veg)
Topping.create([
  { name: 'Black olive', category: 'veg', price: 20 },
  { name: 'Capsicum', category: 'veg', price: 25 },
  { name: 'Paneer', category: 'veg', price: 35 },
  { name: 'Mushroom', category: 'veg', price: 30 },
  { name: 'Fresh tomato', category: 'veg', price: 10 }
])

# Toppings (Non-Veg)
Topping.create([
  { name: 'Chicken tikka', category: 'non_veg', price: 35 },
  { name: 'Barbeque chicken', category: 'non_veg', price: 45 },
  { name: 'Grilled chicken', category: 'non_veg', price: 40 }
])

# Toppings (Extra Cheese)
Topping.create([
  { name: 'Extra cheese', category: 'extra_cheese', price: 35 }
])

# Sides
Side.create([
  { name: 'Cold drink', price: 55 },
  { name: 'Mousse cake', price: 90 }
])

# Inventory: Stock levels for pizzas, toppings, crusts, and sides
Inventory.create([
  { item_type: 'pizza', item_id: 1, quantity: 50, user_id: admin.id }, # Deluxe Veggie
  { item_type: 'pizza', item_id: 2, quantity: 40, user_id: admin.id }, # Cheese and corn
  { item_type: 'pizza', item_id: 3, quantity: 30, user_id: admin.id }, # Paneer Tikka
  { item_type: 'pizza', item_id: 4, quantity: 45, user_id: admin.id }, # Non-Veg Supreme
  { item_type: 'pizza', item_id: 5, quantity: 25, user_id: admin.id }, # Chicken Tikka
  { item_type: 'pizza', item_id: 6, quantity: 20, user_id: admin.id }, # Pepper Barbecue Chicken

  { item_type: 'crust', item_id: 1, quantity: 100, user_id: admin.id }, # New hand tossed
  { item_type: 'crust', item_id: 2, quantity: 80, user_id: admin.id },  # Wheat thin crust
  { item_type: 'crust', item_id: 3, quantity: 60, user_id: admin.id },  # Cheese Burst
  { item_type: 'crust', item_id: 4, quantity: 90, user_id: admin.id },  # Fresh pan pizza

  { item_type: 'topping', item_id: 1, quantity: 100, user_id: admin.id }, # Black olive
  { item_type: 'topping', item_id: 2, quantity: 90, user_id: admin.id },  # Capsicum
  { item_type: 'topping', item_id: 3, quantity: 70, user_id: admin.id },  # Paneer
  { item_type: 'topping', item_id: 4, quantity: 80, user_id: admin.id },  # Mushroom
  { item_type: 'topping', item_id: 5, quantity: 110, user_id: admin.id }, # Fresh tomato
  { item_type: 'topping', item_id: 6, quantity: 60, user_id: admin.id },  # Chicken tikka
  { item_type: 'topping', item_id: 7, quantity: 50, user_id: admin.id },  # Barbeque chicken
  { item_type: 'topping', item_id: 8, quantity: 40, user_id: admin.id },  # Grilled chicken
  { item_type: 'topping', item_id: 9, quantity: 100, user_id: admin.id }, # Extra cheese

  { item_type: 'side', item_id: 1, quantity: 120, user_id: admin.id }, # Cold drink
  { item_type: 'side', item_id: 2, quantity: 90, user_id: admin.id }   # Mousse cake
])


puts "Seed data created successfully!"