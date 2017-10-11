Rails.application.routes.draw do
  mount Spid::Rails::Engine => "/spid-rails"
end
