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

      def list_institution_names_correct
        if superuser?
          #return all pids if superuser
          Institution.pluck(:name)
        else
          #return only associated pids if normal user
          institutions.pluck(:name)
        end

      end

      #def list_collection_names
      def list_institution_names
        if superuser?
          #return all pids if superuser
          collection_list = []
          Bplmodels::Collection.all.each do |collection|
            collection_list << collection.label
          end

        else
          #return only associated pids if normal user
          collection_list = []
          institution_objects =  Bplmodels::Institution.find(self.list_institution_pids[0])
          institution_objects.collections.each do |collection|
              collection_list << collection.label
          end

        end

      end
      
    end
  end
end
