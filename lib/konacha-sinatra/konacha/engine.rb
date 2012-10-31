module Konacha
  class Engine

    def self.application(app = nil)
      Rack::Builder.app do
        use Rack::ShowExceptions

        map '/assets' do
          options = Konacha::Engine.config.konacha
          environment = Sprockets::Environment.new
          environment.append_path File.join(options.app_root, options.assets_path, 'javascripts')
          environment.append_path File.join(options.app_root, 'vendor', 'assets', 'javascripts')
          environment.append_path File.join(options.app_root, options.spec_dir)
          environment.append_path File.join($konacha_lib_path, 'assets', 'javascripts')
          environment.append_path File.join($konacha_lib_path, 'assets', 'stylesheets')
          environment.append_path File.join($konacha_lib_path, '..', 'vendor', 'assets', 'javascripts')
          environment.append_path File.join($konacha_lib_path, '..', 'vendor', 'assets', 'stylesheets')
          run environment
        end

        map "/" do
          run ::Konacha::SpecsController
        end
      end
    end

  end
end