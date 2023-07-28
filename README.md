# Tea Subscription API

This project was created as a take home challenge for Turing School of Software and Design's Mod 4. The goal was to create a RESTful API that would allow a customer to subscribe to a tea subscription service. The API was built using Ruby on Rails and PostgreSQL.

## GET `/teas`, to: 'teas#index'

Sending a GET request to localhost:3000/teas will return a JSON object with all teas in the database.

## GET `/customers`, to: 'customers#index'

Sending a GET request to localhost:3000/customers will return a JSON object with all customers in the database.

## POST `/subscriptions/subscribe`, to: 'subscriptions#create'

Sending a POST request to localhost:3000/subscriptions/subscribe with the following JSON object within the body of the request will create a new subscription for the customer and tea specified in the request.

```
{
  "customer_id": <desired customer ID>,
  "tea_id": <desired tea ID>,
  "title": <string>,
  "frequency": <string eg. weekly, monthly>
  "price": <integer>
}
```

## PUT `/subscriptions/cancel/:id`, to: 'subscriptions#cancel'

Sending a PUT request to localhost:3000/subscriptions/cancel/:id will cancel the subscription with the specified ID.

## GET `/customers/:customer_id/subscriptions`, to: 'subscriptions#index'

Sending a GET request to localhost:3000/customers/:customer_id/subscriptions will return a JSON object with all subscriptions for the specified customer.
  

  ## Built With
  
  Ruby on Rails
  
  PostgreSQL
  
  RSpec
  
  FactoryBot
  
  Faker
  
  ShouldaMatchers

  ## Author
  [Brandon Johnson](http://linkedin.com/in/brenicillin)
