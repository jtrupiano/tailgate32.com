# require 'rubygems'
# require 'middleman'

# run Middleman.server

require 'bundler/setup'
# require 'rack/contrib'
require 'rack/rewrite'

use Rack::Rewrite do 
  r301 %r{.*}, 'http://tailgate32.footballnation.com$&', :if => Proc.new {|rack_env|
    rack_env['SERVER_NAME'] != 'tailgate32.footballnation.com'
  }
end

use Rack::Static, :urls => ["/stylesheets", "/images", "/javascripts", "/about.html", "/press.html"], :root => 'build'

run lambda { |env| 
  [
    200, 
    { 
      'Content-Type' => 'text/html', 
      'Cache-Control' => 'public, max-age=86400' 
    }, 
    File.open('build/index.html', File::RDONLY)
  ] 
}
