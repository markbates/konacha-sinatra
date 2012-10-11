module Konacha
  class << self

    def spec_root
      File.join(Konacha::Engine.config.konacha.app_root, Konacha::Engine.config.konacha.spec_dir)
    end

    def spec_paths
      paths = Dir.glob(File.join(spec_root, '**', '*.*')).select do |pathname|
        File.basename(pathname).to_s =~ /_spec\.|_test\./ &&
        (File.extname(pathname) == '.js' || Tilt[pathname])       
      end.map { |pathname|
        pathname.to_s.gsub(File.join(spec_root, ''), '')
      }.flatten.uniq.sort
      return paths
    end

  end
end