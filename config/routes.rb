Bpl::InstitutionManagement::Engine.routes.draw do
  scope module: 'bpl' do
    scope module: 'institution_management' do
      resources :institutions do
        resources :users, :only=>[:create, :destroy], :controller => "bpl/institutions_management/user_institutions"
      end
    end
  end

  get 'populate_all', :to => 'bpl/institutions_management/institutions#populate_all', :as => 'populate_all'
end

