module Bpl
  module InstitutionManagement
    class UserInstitutionsController < ApplicationController

=begin
  #FIXME: Done to satisfy CanCan. See: http://stackoverflow.com/questions/12756469/cancan-load-and-authorize-resource-triggers-forbidden-attributes or http://stackoverflow.com/questions/20150322/rails-4-strong-params-forbiddenattributeserror
  before_filter :fixCanCan, only: [:create, :edit]

  def fixCanCan
    params[:institution] = institution_params
  end


  def institution_params
    params.require(:institution).permit(:name, :pid)
  end
=end

      include Bpl::InstitutionManagement::UserInstitutionsBehavior
    end
  end
end