require 'spec_helper'

describe "Routes for institution_management" do
  before(:each) do
    @routes = Bpl::InstitutionManagement::Engine.routes
    # so we have to do this instead:
    # engine routes broke in rspec rails 2.12.1, so we had to add this:
    assertion_instance.instance_variable_set(:@routes, @routes)
  end
  it "should route index" do 
    { :get => '/institutions' }.should route_to( :controller => "institutions", :action => "index")
  end
  it "should create institutions" do 
    { :post => '/institutions' }.should route_to( :controller => "institutions", :action => "create")
  end
  it "should show institutions" do 
    { :get => '/institutions/7' }.should route_to( :controller => "institutions", :action => "show", :id => '7')
  end
  it "should add users" do 
    { :post => '/institutions/7/users' }.should route_to( :controller => "user_institutions", :institution_id=>'7', :action => "create")
  end
  it "should remove users" do 
    { :delete => '/institutions/7/users/5' }.should route_to( :controller => "user_institutions", :institution_id=>'7', :id=>'5', :action => "destroy")
  end
end
