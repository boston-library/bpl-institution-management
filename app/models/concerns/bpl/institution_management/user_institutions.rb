module Bpl
  module InstitutionManagement
    module UserInstitutions
      extend ActiveSupport::Concern
      included do
        has_and_belongs_to_many :institutions
      end


      def institution_objects
        Bplmodels::Institution.find(self.list_institution_pids)
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

      def list_institution_names
        if superuser?
          #return all pids if superuser
          Institution.pluck(:name)
        else
          #return only associated pids if normal user
          institutions.pluck(:name)
        end

      end

      def list_collection_pids
        collection_list = []
        if superuser?
          #return all pids if superuser
          Bplmodels::Collection.find_in_batches("has_model_ssim"=>"info:fedora/afmodel:Bplmodels_Collection") do |collection_group|
            collection_group.each { |solr_objects|
              pid = solr_objects['id']
              collection_list << pid
            }
          end

        else
          #return only associated pids if normal user
          self.institution_objects.each do |institution|
            institution.collections.each do |collection|
              collection_list << collection.pid
            end
          end
        end
        collection_list
      end

      def list_collection_names
        collection_list = []
        if superuser?
          #return all pids if superuser

          Bplmodels::Collection.all.each do |collection|
            collection_list << collection.label
          end

        else
          #return only associated pids if normal user
          self.institution_objects.collections.each do |collection|
            collection_list << collection.label
          end

        end
        collection_list
      end
      
    end
  end
end
