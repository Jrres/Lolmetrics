Rails.application.routes.draw do
  root to: 'league#index'
  get '/search' => 'league#search', as: 'search'
  get '/champion' => 'league#champion', as: 'champion'
  get '/champion/:selected' => 'league#champion', as: 'selected'
end
