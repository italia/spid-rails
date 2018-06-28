Rails.application.routes.draw do
  mount Spid::Rails::Engine, at: Spid::Rails.mount_point
end

Spid::Rails::Engine.routes.draw do
  resource :metadata, only: :show,
                      path: Spid::Rails.metadata_path
  resource :sso, only: [:new, :create], controller: :single_sign_ons,
                 path: Spid::Rails.sso_path
  resource :slo, only: [:new, :create], controller: :single_logout_operations,
                 path: Spid::Rails.slo_path
  get Spid::Rails.slo_path, to: "single_logout_operations#create"
end
