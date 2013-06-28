require 'spec_helper'

describe Bpl::InstitutionManagement::UserInstitutions do
  subject do
    User.create!(email: 'fred@example.com', password: 'password')
  end

  it "should have admin?" do
    subject.should_not be_admin
  end

  it "should have institutions" do
    subject.institutions.should == []
    subject.institutions << Institution.create!(name: 'librarian')
    subject.institutions.first.name.should == 'librarian'

  end

  it "should have groups" do
    subject.institutions.should == []
    subject.institutions << Institution.create!(name: 'librarian')
    subject.save!
    subject.groups.should include('registered', 'librarian')
  end

end
