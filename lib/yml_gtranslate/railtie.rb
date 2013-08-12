require 'yml_gtranslate'
require 'rails'
module YmlGtranslate
  class Railtie < Rails::Railtie
    railtie_name :yml_gtranslate

    rake_tasks do
      load "tasks/yml_gtranslate.rake"
    end
  end
end
