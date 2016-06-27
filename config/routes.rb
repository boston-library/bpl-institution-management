Bpl::InstitutionManagement::Engine.routes.draw do
  scope module: 'bpl' do
    scope module: 'institution_management' do
      resources :institutions do
        resources :users, :only=>[:create, :destroy], :controller => "user_institutions"
      end
      match 'populate_all', :to => 'institutions#populate_all', :as => 'populate_all', via: [:get]
    end
  end
end

