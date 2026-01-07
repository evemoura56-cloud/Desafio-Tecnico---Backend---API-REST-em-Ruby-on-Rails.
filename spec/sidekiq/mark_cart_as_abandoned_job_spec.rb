require 'rails_helper'

RSpec.describe MarkCartAsAbandonedJob, type: :job do
  describe '#perform' do
    it 'marks carts as abandoned' do
      old_cart = create(:cart, last_interaction_at: 4.hours.ago, abandoned: false)
      recent_cart = create(:cart, last_interaction_at: 2.hours.ago, abandoned: false)
      
      MarkCartAsAbandonedJob.new.perform
      
      expect(old_cart.reload.abandoned).to be true
      expect(recent_cart.reload.abandoned).to be false
    end
  end
end
