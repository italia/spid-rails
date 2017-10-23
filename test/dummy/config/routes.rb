Rails.application.routes.draw do
  resource :welcome, controller: 'welcome'
  root to: 'welcome#show'
end
