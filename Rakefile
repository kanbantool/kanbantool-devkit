begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

ROOT = Pathname.new(File.dirname(__FILE__))

def sprockets
  require 'sprockets'
  require 'uglifier'

  @sprockets ||= Sprockets::Environment.new(ROOT) do |env|
    env.logger = Logger.new(STDOUT)
    env.append_path(File.join(ROOT, 'devkit'))
    env.context_class.class_eval do
      def asset_path(path, options = {})
        # File.join('/assets/', path)
        path
      end
    end

    # env.version         = '1.0'
    # env.compress       = true
    env.js_compressor  = Uglifier.new(:output=> {:comments=> :copyright})
    env.css_compressor = :scss
  end
end

namespace :devkit do
  desc 'Compile production version of kanbantool-devkit JS and CSS files'
  task :build do
    OUTPUT_DIR = ROOT.join('devkit.build')
    FileUtils.mkdir_p(OUTPUT_DIR)

    %w(kanbantool-devkit.js kanbantool-devkit.css).each do |a|
      outfile = Pathname.new(OUTPUT_DIR).join(a)
      FileUtils.mkdir_p outfile.dirname
      asset = sprockets[a]
      asset.write_to(outfile)
      puts "Compiled #{a} => #{outfile}"
    end
  end
end
