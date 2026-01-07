require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe 'associations' do
    it { should have_many(:cart_items).dependent(:destroy) }
    it { should have_many(:products).through(:cart_items) }
  end

  describe '#mark_as_abandoned' do
    it 'marks the cart as abandoned' do
      cart = create(:cart, abandoned: false)
      cart.mark_as_abandoned!
      
      expect(cart.reload.abandoned).to be true
      expect(cart.abandoned_at).to be_present
    end
  end

  describe '#delete_abandoned_carts' do
    it 'deletes carts that have been abandoned for more than 7 days' do
      old_cart = create(:cart, abandoned: true, abandoned_at: 8.days.ago)
      recent_cart = create(:cart, abandoned: true, abandoned_at: 6.days.ago)
      
      expect { Cart.delete_abandoned_carts }.to change { Cart.count }.by(-1)
      expect(Cart.exists?(old_cart.id)).to be false
      expect(Cart.exists?(recent_cart.id)).to be true
    end
  end
end
