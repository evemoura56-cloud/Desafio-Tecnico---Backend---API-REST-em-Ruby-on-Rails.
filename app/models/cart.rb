class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  validates :session_id, presence: true, uniqueness: true
  
  before_create :set_last_interaction

  def total_price
    cart_items.includes(:product).sum { |item| item.quantity * item.product.price }
  end

  def as_json(options = {})
    {
      id: id,
      products: cart_items.includes(:product).map do |item|
        {
          id: item.product.id,
          name: item.product.name,
          quantity: item.quantity,
          unit_price: item.product.price.to_f.round(2),
          total_price: (item.quantity * item.product.price).to_f.round(2)
        }
      end,
      total_price: total_price.to_f.round(2)
    }
  end

  def mark_as_abandoned!
    update(abandoned: true, abandoned_at: Time.current)
  end

  def should_be_abandoned?
    !abandoned && last_interaction_at && last_interaction_at < 3.hours.ago
  end

  def self.delete_abandoned_carts
    where('abandoned = ? AND abandoned_at < ?', true, 7.days.ago).destroy_all
  end

  def update_last_interaction!
    update(last_interaction_at: Time.current)
  end

  private

  def set_last_interaction
    self.last_interaction_at ||= Time.current
  end
end
