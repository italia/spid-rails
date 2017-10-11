Spid::Rails::Engine.routes.draw do
  resource :metadata, only: :show
  resource :sso, only: [:new, :create], controller: :single_sign_ons
  resource :slo, only: [:new, :create], controller: :single_logout_operations
end
