module Bpl
  module InstitutionManagement
    module InstitutionsBehavior
      extend ActiveSupport::Concern

      included do
        load_and_authorize_resource 
      end

      def index
      end

      def show
        redirect_to institution_management.edit_institution_path(@institution) if can? :edit, @institution
      end

      def new
      end

      def edit
      end

      def create
        @institution.name = params[:insitution][:name]

        institution = Bplmodels::Institution.find(:label_ssim=>@institution.name)
        if institution.size == 0
          @localid = @institution.name
          @localid_type = "Physical Location From UI"

          response = Typhoeus::Request.post(ARK_CONFIG_GLOBAL['url'] + "/arks.json", :params => {:ark=>{:namespace_ark => ARK_CONFIG_GLOBAL['namespace_commonwealth_ark'], :namespace_id=>ARK_CONFIG_GLOBAL['namespace_commonwealth_pid'], :url_base => ARK_CONFIG_GLOBAL['ark_commonwealth_base'], :model_type => Bplmodels::Institution.name, :local_original_identifier=>@localid, :local_original_identifier_type=>@localid_type}})

          as_json = JSON.parse(response.body)

          institution = Bplmodels::Institution.new(:pid=>as_json["pid"])
          institution.label =  @institution.name
          title = getProperTitle(@institution.name)
          institution.descMetadata.insert_title(title[0], title[1])

          institution.save!
        end

        @institution.pid = institution.pid

        if (@institution.save)
          redirect_to institution_management.edit_institution_path(@institution), notice: 'Institution was successfully created.'
        else
          render action: "new"
        end
      end

      def update
        @institution.name = params[:institution][:name]

        institution = Bplmodels::Institution.find(:label_ssim=>@institution.name)
        institution.label = @institution.name
        institution.save!

        if (@institution.save)
          redirect_to institution_management.edit_institution_path(@institution), notice: 'Institution was successfully updated.'
        else
          render action: "edit"
        end
      end

      def destroy
        institution = Bplmodels::Institution.find(:label_ssim=>@institution.name)
        institution.label = @institution.name
        institution.delete

        if (@institution.destroy)
          redirect_to institution_management.institutions_path, notice: 'Institution was successfully deleted.'
        else
          redirect_to institution_management.institutions_path
        end
      end

    end
  end
end
