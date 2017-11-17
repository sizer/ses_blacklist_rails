SesBlacklistRails::Engine.routes.draw do
  namespace :api do
    post '/notification' => 'notification#index'
  end
end
