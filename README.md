# README
Pizza Factory
     
     Overview
          - Refer to schema.rb for the database design.
          - Seed data is provided in seeds.rb.
          - OrderService and InventoryService handle all business requirements.
          - Implemented InventoryRestocksController and OrdersController to provide JSON responses.
          - Defined all necessary validations and associations in models.
          - Wrote comprehensive test cases for services,

     DB migrate
          - rails db:migrate
          - rails db:seed

     API endpoints
          - POST -> /orders -> Place a new order
          - POST -> /orders/:id/cancel -> Cancel an order
          - POST -> /inventory/restock -> Restock inventory

     curl -X POST "http://localhost:3000/inventory_restock/restock" \
          -H "Content-Type: application/json" \
          -d '{ "item_type": "topping", "item_id": 3, "quantity": 50, "user_id": 2 }'


     curl -X POST "http://localhost:3000/orders" -H "Content-Type: application/json" -d "{ \"order\": { \"user_id\": 2, \"side_ids\": [1, 2], \"pizzas\": [ { \"pizza_id\": 3, \"size\": \"large\", \"crust_id\": 1, \"topping_ids\": [4, 5] }, { \"pizza_id\": 1, \"size\": \"medium\", \"crust_id\": 2, \"topping_ids\": [3] } ] } }"


     Rspec(will run all the test case)
          -bundle exec rspec spec

