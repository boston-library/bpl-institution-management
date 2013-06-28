module Bpl
  module InstitutionManagement
    module UserInstitutionsBehavior
      extend ActiveSupport::Concern

      included do
        load_and_authorize_resource :role
      end

      def create
        authorize! :add_user, @institution
        u = ::User.find_by_user_key(params[:user_key])
        if u
          u.institutions << @institution
          u.save!
          redirect_to institution_management.institution_path(@institution)
        else
          redirect_to institution_management.institution_path(@institution), :flash=> {:error=>"Unable to find the user #{params[:user_key]}"}
        end
      end

      def destroy
        authorize! :remove_user, @institution
        @institution.users.delete(::User.find(params[:id]))
        redirect_to institution_management.institution_path(@institution)
      end
    end
  end
end

