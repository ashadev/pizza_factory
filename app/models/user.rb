class User < ApplicationRecord
  has_secure_password  # Secure password handling
  
  # Validation for uniqueness of email
  validates :email, presence: true, uniqueness: true
  has_many :orders, dependent: :destroy
  has_many :inventories, dependent: :destroy
end
