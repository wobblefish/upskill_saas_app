class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :plan
  has_one :profile
  
  attr_accessor :stripe_card_token
  # if Pro user passes validations (email, password, etc) call Stripe
  # and create a record of the user, then  set up 
  # a subscription upon charging the card 
  # Stripe responds back with customer data
  # Store customer.id as customer token and finally, save the user
  def save_with_subscription
    if valid?
      customer = Stripe::Customer.create(description: email, plan: plan_id, card: stripe_card_token)
      self.stripe_customer_token = customer.id
      save!
    end
  end
end
