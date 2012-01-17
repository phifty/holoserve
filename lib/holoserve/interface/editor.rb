require 'sinatra'
require 'sinatra/assetpack'

class Holoserve::Interface::Editor < Sinatra::Base

  set :root, File.expand_path(File.join(File.dirname(__FILE__), "..", "..", ".."))

  enable :inline_templates

  register Sinatra::AssetPack
  assets {
    serve "/javascripts", :from => "/javascripts"
    serve "/stylesheets", :from => "/stylesheets"
    serve "/images", :from => "/images"

    js :application, "/javascripts/application.js", [
      "/javascripts/lib/common/*.js",
      "/javascripts/lib/transport/*.js",
      "/javascripts/lib/application.js",
    ]

    css :application, "/stylesheets/application.css", [
      "/stylesheets/*.css"
    ]

    js_compression :jsmin
    css_compression :sass
  }

  attr_reader :javascript_includes
  attr_reader :stylesheet_includes

  before do
    @javascript_includes = js :application
    @stylesheet_includes = css :application, :media => "screen"
  end

  get "/_control" do
    erb :main, :layout => false
  end

end

__END__

@@ main
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>Holoserve layout editor</title>
    <%= stylesheet_includes %>
    <script src="http://ajax.googleapis.com/ajax/libs/dojo/1.7/dojo/dojo.js"></script>
    <%= javascript_includes %>
  </head>
  <body onload="Application.run();">
  </body>
</html>
