module Bpl
  module InstitutionManagement
    class Engine < ::Rails::Engine
      engine_name 'institution_management'

      # Rails 4 should do this automatically:
      config.paths.add "app/controllers/concerns", eager_load: true
      config.paths.add "app/models/concerns", eager_load: true
    end
  end
end
