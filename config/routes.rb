Rails.application.routes.draw do
  resources module: 'api' do
    resources module: 'v1' do
      post '/event', to: 'payload#github_event'
    end
  end
end
