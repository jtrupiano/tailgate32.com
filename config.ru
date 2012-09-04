# require 'rubygems'
# require 'middleman'

# run Middleman.server

# require 'bundler/setup'
# require 'rack/contrib'
# require 'rack/rewrite'

use Rack::Static, :urls => ["/stylesheets", "/images", "/javascripts", "/about.html", "press.html"], :root => 'build'
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
