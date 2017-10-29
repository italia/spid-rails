Rails.application.routes.draw do
  mount SpidRails::Engine, at: SpidRails.mount_point
end

SpidRails::Engine.routes.draw do
  resource :metadata, only: :show,
            path: SpidRails.metadata_path
  resource :sso, only: [:new, :create], controller: :single_sign_ons,
            path: SpidRails.sso_path
  resource :slo, only: [:new, :create], controller: :single_logout_operations,
            path: SpidRails.slo_path
end
