Rails.application.routes.draw do
  post 'authenticate' => 'authentication#authenticate'
  post 'api/v1/event' => 'api/v1/payload#create'
  get 'api/v1/issue' => 'api/v1/issue#index'
  get 'api/v1/issue/:id' => 'api/v1/issue#show'
end
