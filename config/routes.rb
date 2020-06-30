Rails.application.routes.draw do
  post 'api/v1/event' => 'api/v1/payload#create'
end
