class SubscriptionSerializer
  def initialize(subscription)
    @subscription = subscription
  end

  def as_json
    {
      id: @subscription.id,
      customer_id: @subscription.customer_id,
      tea_id: @subscription.tea_id,
      title: @subscription.title,
      price: @subscription.price,
      status: @subscription.status,
      frequency: @subscription.frequency
    }
  end
end