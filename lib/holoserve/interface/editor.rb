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
      "/javascripts/lib/interface/*.js",
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
    erb :index, :layout => false
  end

  get "/favicon.ico" do
    nil
  end

end
