module Bpl
  module InstitutionManagement
    module UserInstitutions
      extend ActiveSupport::Concern
      included do
        has_and_belongs_to_many :institutions
      end


      def institutions
        #insitutions.where(name: 'admin').exists?
        ['bpl-test:v118s530v']
      end
      
    end
  end
end
