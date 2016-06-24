module Bpl
  module InstitutionManagement
    class InstitutionsController < ApplicationController
      include Bpl::InstitutionManagement::InstitutionsBehavior
    end
  end
end

