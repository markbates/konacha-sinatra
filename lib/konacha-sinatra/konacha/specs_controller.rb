module Konacha

  class SpecsController < ::Sinatra::Base

    helpers do
      def stylesheet_link_tag(*css)
        html = css.flatten.map do |c|
          %{<link rel='stylesheet' href='/assets/#{c}.css' type='text/css' />}.html_safe
        end.join('\n')
        return html
      end

      def javascript_include_tag(*js)
        html = js.flatten.map do |j|
          %{<script src="/assets/#{j}.js"></script>}.html_safe
        end.join("\n")
        return html
      end

      def spec_include_tag(*specs)
        assets = specs.map do |spec|
          spec.asset_name
        end.flatten.uniq
        javascript_include_tag assets
      end
    end

    get '/*' do
      begin
        @specs = Konacha::Spec.find(params[:splat].first || "")
      rescue Konacha::Spec::NotFound => e
        halt 404, "Oops! - Not Found!"
      end
      erb <<-EOF
<!doctype html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html;charset=utf-8" />
    <title>Konacha Tests</title>
    <%= stylesheet_link_tag "mocha" %>
    <%= stylesheet_link_tag "konacha" %>
    <%= javascript_include_tag "mocha", "chai", "konacha/#{Konacha.mode}" %>
    <%= javascript_include_tag "konacha" %>
    <%= spec_include_tag *@specs %>
  </head>
  <body>
    <div id="mocha"></div>
  </body>
</html>
      EOF
    end

  end
end