class User < ApplicationRecord
  before_save :generate_token
  after_save :create_cart
  
  has_one :cart
  has_many :cart_items

  has_secure_password
  
  validates :email, presence: true, uniqueness: true

  def generate_token
    self.token ||= SecureRandom.urlsafe_base64
  end

  def reset_token
    generate_token
  end

  def create_cart
    Cart.create(user_id: self.id) unless self.cart.present?
  end


end
