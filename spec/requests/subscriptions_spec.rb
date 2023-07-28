require 'rails_helper'

RSpec.describe 'Subscriptions API', type: :request do
  let(:customer) { Customer.create(first_name: 'John', last_name: 'Doe', email: 'test@test.com', address: '123 Main St') }
  let(:tea) { Tea.create(title: 'Green Tea', description: 'Green', temperature: '200', brew_time: 5) }
  describe 'POST /subscriptions/subscribe' do
    it 'creates a new subscription' do
     subscription_params = {
      customer_id: customer.id,
      tea_id: tea.id,
      title: 'Green Tea',
      price: 10.00,
      frequency: 'weekly',
      status: 'active'
     }
     post '/subscriptions/subscribe', params: subscription_params

     expect(response).to have_http_status(:created)
     expect(Subscription.count).to eq(1)
     expect(Subscription.first.customer_id).to eq(customer.id)
     expect(Subscription.first.tea_id).to eq(tea.id)
    end

    it 'returns an error if the subscription is invalid' do
      invalid_params = {
        customer_id: customer.id,
        tea_id: 120492,
        title: 'Green Tea',
        price: 10.00,
        status: 'invalid',
        frequency: 'daily'
      }

      post '/subscriptions/subscribe', params: invalid_params

      expect(response).to have_http_status(:unprocessable_entity)
      expect(Subscription.count).to eq(0)
      expect(JSON.parse(response.body)['errors']).to eq(['Customer or Tea does not exist'])
    end
  end

  describe 'PUT /subscriptions/cancel/:id' do
    it 'cancels a subscription' do
      subscription = Subscription.create(
        customer_id: customer.id,
        tea_id: tea.id,
        title: 'Green Tea',
        price: 10.00,
        status: 'active',
        frequency: 'weekly'
      )

      put "/subscriptions/cancel/#{subscription.id}"

      expect(response).to have_http_status(:ok)
      expect(Subscription.first.status).to eq('cancelled')
    end

    it 'returns an error if the subscription is already cancelled' do
      subscription = Subscription.create(
        customer_id: customer.id,
        tea_id: tea.id,
        title: 'Fake Tea',
        price: 10.00,
        status: 'cancelled',
        frequency: 'weekly'
      )

      put "/subscriptions/cancel/#{subscription.id}"

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['errors']).to eq(['Subscription does not exist'])
    end
  end

  describe 'GET /customers/:id/subscriptions' do
    it 'returns all subscriptions for a customer' do
      customer = Customer.create!(first_name: 'John', last_name: 'Doe', email: 'john@doe.com', address: '123 Main St')
      tea = Tea.create!(title: 'Green Tea', description: 'Green', temperature: '200', brew_time: 5)

      active_subscription = Subscription.create(
        customer_id: customer.id,
        tea_id: tea.id,
        title: 'Sample Active Subscription',
        price: 100.00,
        status: 'active',
        frequency: 'monthly'
      )

      cancelled_sub = Subscription.create(
        customer_id: customer.id,
        tea_id: tea.id,
        title: 'Sample Cancelled Subscription',
        price: 10000000.00,
        status: 'cancelled',
        frequency: 'monthly'
      )
      get "/customers/#{customer.id}/subscriptions"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).count).to eq(2)
      expect(JSON.parse(response.body).first['title']).to eq(active_subscription.title)
      expect(JSON.parse(response.body).second['title']).to eq(cancelled_sub.title)
    end
  end
end