BPL::InstitutionManagement::Engine.routes.draw do
  # Generic file routes
  resources :institutions do
    resources :users, :only=>[:create, :destroy], :controller => "user_institutions"
  end
end

