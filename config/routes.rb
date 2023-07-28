Rails.application.routes.draw do
  get 'teas', to: 'teas#index'
  get 'customers', to: 'customers#index'
  post 'subscriptions/subscribe', to: 'subscriptions#create'
  put 'subscriptions/cancel/:id', to: 'subscriptions#cancel'
  get 'customers/:customer_id/subscriptions', to: 'subscriptions#index'
  # mount SwaggerUiEngine::Engine, at: '/api_docs'
end
