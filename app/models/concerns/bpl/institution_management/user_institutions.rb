module Bpl
  module InstitutionManagement
    module UserInstitutions
      extend ActiveSupport::Concern
      included do
        has_and_belongs_to_many :institutions
      end


      def list_institutions
        if superuser?
          #return all pids if superuser
          Institution.pluck(:pid)
        else
          #return only associated pids if normal user
          insitutions.pluck(:pid)
        end

      end
      
    end
  end
end
