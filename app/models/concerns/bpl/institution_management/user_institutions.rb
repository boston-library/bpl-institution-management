module Bpl
  module InstitutionManagement
    module UserInstitutions
      extend ActiveSupport::Concern
      included do
        has_and_belongs_to_many :institutions
      end


      def institution_objects
        Bplmodels::Institution.where(self.list_institution_pids)
      end

      def list_institution_pids
        if superuser?
          #return all pids if superuser
          Institution.pluck(:pid)
        else
          #return only associated pids if normal user
          institutions.pluck(:pid)
        end

      end
      
    end
  end
end
