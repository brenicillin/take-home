class SubscriptionsController < ApplicationController
  before_action :find_customer_and_tea, only: [:create]
  before_action :find_subscription, only: [:cancel]

  def create
    subscription = Subscription.create!(subscription_params)
    render json: { message: 'Subscription created successfully' }, status: :created
  end
  
  def cancel
    @subscription.update!(status: 'cancelled')
    render json: { message: 'Subscription cancelled successfully' }, status: :ok
  end

  def index
    customer = Customer.find(params[:customer_id])
    subscriptions = customer.subscriptions

    render json: serialize_subscriptions(subscriptions), status: :ok
  end

  private

  def subscription_params
    {
      customer_id: @customer.id,
      tea_id: @tea.id,
      title: params[:title],
      price: params[:price],
      status: "active",
      frequency: params[:frequency]
    }
  end

  def find_customer_and_tea
    @customer = Customer.find_by(id: params[:customer_id])
    @tea = Tea.find_by(id: params[:tea_id])

    render_not_found(['Customer or Tea does not exist']) if @customer.nil? || @tea.nil?
  end

  def find_subscription
    @subscription = Subscription.find_by(id: params[:id], status: 'active')
    render_not_found(['Subscription does not exist']) unless @subscription
  end

  def serialize_subscriptions(subscriptions)
    subscriptions.map do |subscription|
      SubscriptionSerializer.new(subscription).as_json
    end
  end

  def render_not_found(errors)
    render json: { errors: errors }, status: :unprocessable_entity
  end
end
