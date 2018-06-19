require 'coffee-script'
require 'sprockets'
require 'rack/cors'

project_root = File.expand_path(File.dirname(__FILE__))

###
# Allow CORS GET requests for anything
###
use Rack::Cors do
  allow do
    origins '*'
    resource '*', :headers => :any, :methods => :get
  end
end

###
# Sprockets for /devkit
# responsible for serving development versions of /devkit/kanbantool-devkit.css and /devkit/kanbantool-devkit.js
###
assets = Sprockets::Environment.new(project_root) do |env|
  env.logger = Logger.new(STDOUT)
  env.append_path(File.join(project_root, 'devkit'))
  env.context_class.class_eval do
    def asset_path(path, options = {})
      File.join('http://localhost:9292/devkit', path)
    end
  end
end

map '/devkit' do
  run assets
end

map '/' do
  # use Rack::AppendTrailingSlash
  use Rack::Static,
    :urls => ['/'], :root => File.expand_path('doc/_site'), :index => 'index.html'
  run lambda {|*|}
end
