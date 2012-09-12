# encoding: utf-8

require File.expand_path("../rack_try_static", __FILE__)
require 'rack/rewrite'

use Rack::Rewrite do 
  r301 %r{.*}, 'http://tailgate32.footballnation.com$&', :if => Proc.new {|rack_env|
    !['tailgate32.footballnation.com', 'tailgate32-staging.herokuapp.com', 'localhost', '127.0.0.1'].include?(rack_env['SERVER_NAME'])
  }

  # links previously distributed to SI.com -- keep around so that those links don't break
  r301 "/tailgate32-ep01",    "http://www.youtube.com/embed/ctxN8gKQ_L8?vq=hd720&rel=0&showinfo=0"
  r301 "/tailgate32-trailer", "http://www.youtube.com/embed/q3eWWvPwXEA?vq=hd720&rel=0&showinfo=0"
end

use ::Rack::TryStatic,
  :root => "build",
  :urls => ["/"],
  :try  => [".html", "index.html", "/index.html"]

run lambda { [404, {"Content-Type" => "text/plain"}, ["File not found!"]] }
