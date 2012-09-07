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
  r301 "/tailgate32-ep01",    "http://www.youtube.com/embed/ctxN8gKQ_L8?vq=hd720&rel=0&showinfo=0&autoplay=1"
  r301 "/tailgate32-trailer", "http://www.youtube.com/embed/q3eWWvPwXEA?vq=hd720&rel=0&showinfo=0&autoplay=1"
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
