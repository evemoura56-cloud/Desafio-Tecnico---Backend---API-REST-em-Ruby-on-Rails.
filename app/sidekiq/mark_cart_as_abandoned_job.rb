class MarkCartAsAbandonedJob
  include Sidekiq::Job

  def perform
    mark_abandoned_carts
    delete_old_abandoned_carts
  end

  private

  def mark_abandoned_carts
    Cart.where('last_interaction_at < ? AND abandoned = ?', 3.hours.ago, false)
        .find_each(&:mark_as_abandoned!)
  end

  def delete_old_abandoned_carts
    Cart.delete_abandoned_carts
  end
end
