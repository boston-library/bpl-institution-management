require 'spec_helper'

describe UserInstitutionsController do
  let(:ability) do
    ability = Object.new
    ability.extend(CanCan::Ability)
    controller.stub(:current_ability).and_return(ability)
    ability
  end

  let(:institution) do
    Institution.create(name: 'foo')
  end

  describe "with a user who cannot edit users" do
    it "should not be able to add a user" do
      lambda { post :create, institution_id: institution, user_key: 'foo@example.com'}.should raise_error CanCan::AccessDenied
    end
    it "should not be able to remove a user" do
      lambda { delete :destroy, institution_id: institution, id: 7}.should raise_error CanCan::AccessDenied
    end
  end

  describe "with a user who can edit users" do
    before do
      ability.can :read, Institution
    end
    describe "adding users" do
      before do
        ability.can :add_user, Institution
      end
      it "should not be able to add a user that doesn't exist" do
        User.should_receive(:find_by_user_key).with('foo@example.com').and_return(nil)
        post :create, institution_id: institution, user_key: 'foo@example.com'
        flash[:error].should == "Unable to find the user foo@example.com"
      end
      it "should be able to add a user" do
        u = User.create!(email: 'foo@example.com', password: 'password', password_confirmation: 'password')
        post :create, institution_id: institution, user_key: 'foo@example.com'
        institution.reload.users.should == [u]
      end
    end
    describe "removing users" do
      before do
        ability.can :remove_user, Institution
      end
      let (:user) do
        u = User.new(email: 'foo@example.com', password: 'password', password_confirmation: 'password')
        u.institutions = [institution]
        u.save!
        u
      end
      it "should be able to remove a user" do
        user.institutions.should == [institution]
        delete :destroy, institution_id: institution, id: user.id
        institution.reload.users.should == []
      end
    end
  end
end

