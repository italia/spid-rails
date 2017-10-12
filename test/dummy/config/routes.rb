Rails.application.routes.draw do
  mount Spid::Rails::Engine => "/spid"
  resource :welcome, controller: 'welcome'
  root to: 'welcome#show'
end
