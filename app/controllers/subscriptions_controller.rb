class SubscriptionsController < ApplicationController
  # POST /customers/:customer_id/subscriptions
  # swagger_controller :subscriptions, 'Subscriptions'

  # POST /customers/:customer_id/subscriptions
  # swagger_api :create do
  #   summary 'Creates a new subscription'
  #   notes 'This endpoint takes in a customer_id, tea_id, title, price, and frequency and creates a new subscription'
  #   param :form, :customer_id, :integer, :required, 'Customer ID'
  #   param :form, :tea_id, :integer, :required, 'Tea ID'
  #   param :form, :title, :string, :required, 'Title'
  #   param :form, :price, :float, :required, 'Price'
  #   param :form, :frequency, :string, :required, 'Frequency'
  #   response :created, 'Subscription created successfully'
  #   response :unprocessable_entity, 'Customer or Tea does not exist'
  # end

  def create
    customer = Customer.find_by(id: params[:customer_id])
    tea = Tea.find_by(id: params[:tea_id])

    if customer.nil? || tea.nil?
      render json: { errors: ['Customer or Tea does not exist'] }, status: :unprocessable_entity
    else
      subscription = Subscription.create!(subscription_params)
      render json: { message: 'Subscription created successfully' }, status: :created
    end
  end

  # PUT /subscriptions/cancel/:id
  # swagger_api :cancel do
  #   summary 'Cancels a subscription'
  #   notes 'This endpoint takes in a subscription id and cancels the subscription'
  #   param :path, :id, :integer, :required, 'Subscription ID'
  #   repsonse :ok, 'Subscription cancelled successfully'
  #   response  :unprocessable_entity, 'Subscription does not exist'
  # end

  def cancel
    subscription = Subscription.find_by(id: params[:id], status: 'active')

    if subscription
      subscription.update!(status: 'cancelled')
      render json: { message: 'Subscription cancelled successfully' }, status: :ok
    else
      render json: { errors: ['Subscription does not exist'] }, status: :unprocessable_entity
    end
  end

  #GET /customers/:customer_id/subscriptions
  # swagger_api :index do
  #   summary 'Returns all subscriptions for a customer'
  #   notes 'This endpoint takes in a customer id and returns all subscriptions for that customer'
  #   param :path, :customer_id, :integer, :required, 'Customer ID'
  #   response :ok, 'Subscriptions returned successfully'
  # end

  def index
    customer = Customer.find(params[:customer_id])
    subscriptions = customer.subscriptions

    render json: serialize_subscriptions(subscriptions), status: :ok
  end

  private

  def subscription_params
    {
      customer_id: Customer.find_by(id: params[:customer_id]).id,
      tea_id: Tea.find_by(id: params[:tea_id]).id,
      title: params[:title],
      price: params[:price],
      status: "active",
      frequency: params[:frequency]
    }
  end

  def serialize_subscriptions(subscriptions)
    subscriptions.map do |subscription|
      SubscriptionSerializer.new(subscription).as_json
    end
  end
end
