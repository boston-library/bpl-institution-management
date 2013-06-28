require 'spec_helper'

describe InstitutionController do
  let(:ability) do
    ability = Object.new
    ability.extend(CanCan::Ability)
    controller.stub(:current_ability).and_return(ability)
    ability
  end

  let(:institution) do
    Institution.create(name: 'foo')
  end


  describe "with a user who cannot edit institutions" do
    it "should not be able to view institution index" do
      lambda { get :index }.should raise_error CanCan::AccessDenied
    end
    it "should not be able to view institution" do
      lambda { get :show, id: institution }.should raise_error CanCan::AccessDenied
    end
    it "should not be able to view new institution form" do
      lambda { get :new }.should raise_error CanCan::AccessDenied
    end
    it "should not be able to create a institution" do
      lambda { post :create, :institution=>{name: 'my_institution'}}.should raise_error CanCan::AccessDenied
    end
    it "should not be able to update a institution" do
      lambda { put :update, id: institution}.should raise_error CanCan::AccessDenied
    end
    it "should not be able to remove a institution" do
      lambda { delete :destroy, id: institution}.should raise_error CanCan::AccessDenied
    end
  end

  describe "with a user who can read institutions" do
    before do
      ability.can :read, Institution
    end
    it "should be able to see the list of institutions" do
      get :index
      response.should be_successful
      assigns[:institutions].should == [institution]
    end

    it "should be able to see a single institution" do
      get :show, id: institution
      response.should be_successful
      assigns[:institution].should == institution
    end
  end

  describe "with a user who can only update institution 'foo'" do
    it "should be redirected to edit" do
      ability.can :read, Institution
      ability.can :update, Institution, id: institution.id
      get :show, id: institution
      response.should redirect_to @routes.url_helpers.edit_institution_path(assigns[:institution])
    end
  end
  
  describe "with a user who can create institutions" do
    before do
      ability.can :create, Institution
    end
    it "should be able to make a new institution" do
      get :new
      response.should be_successful
      assigns[:institution].should be_kind_of Institution
    end

    it "should be able to create a new institution" do
      post :create, :institution=>{name: 'my_institution'} 
      response.should redirect_to @routes.url_helpers.edit_institution_path(assigns[:institution])
      assigns[:institution].should_not be_new_record
      assigns[:institution].name.should == 'my_institution'
    end
    it "should not create institution with an error" do
      post :create, :institution=>{name: 'my institution'} 
      assigns[:institution].name.should == 'my institution'
      assigns[:institution].errors[:name].should == ['Only letters, numbers, hyphens, underscores and periods are allowed']
      response.should be_successful
    end
  end

  describe "with a user who can update institutions" do
    before do
      ability.can :update, Institution
    end

    it "should be able to update a institution" do
      put :update, id: institution, :institution=>{name: 'my_institution'} 
      response.should redirect_to @routes.url_helpers.edit_institution_path(assigns[:institution])
      assigns[:institution].should_not be_new_record
      assigns[:institution].name.should == 'my_institution'
    end
    it "should not update institution with an error" do
      put :update,  id: institution, :institution=>{name: 'my institution'} 
      assigns[:institution].name.should == 'my institution'
      assigns[:institution].errors[:name].should == ['Only letters, numbers, hyphens, underscores and periods are allowed']
      response.should be_successful
    end
  end

  describe "with a user who can remove institutions" do
    before do
      ability.can :destroy, Institution
    end

    it "should be able to destroy a institution" do
      delete :destroy, id: institution 
      response.should redirect_to @routes.url_helpers.institutions_path
    end
  end

end
