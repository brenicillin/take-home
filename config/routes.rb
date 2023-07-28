Rails.application.routes.draw do
  post 'subscriptions/subscribe', to: 'subscriptions#create'
  put 'subscriptions/cancel/:id', to: 'subscriptions#cancel'
  get 'customers/:customer_id/subscriptions', to: 'subscriptions#index'
  # mount SwaggerUiEngine::Engine, at: '/api_docs'
end
