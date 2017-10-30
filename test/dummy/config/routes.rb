Rails.application.routes.draw do
  resource :welcome, only: :show
  resource :content, only: :show

  root to: 'content#show'
end
