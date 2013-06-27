# encoding: utf-8

require File.expand_path("../rack_try_static", __FILE__)
require 'rack/rewrite'

use Rack::Rewrite do 
  # return true if request should be treated as going to a production server
  def production_host?(rack_env)
    !['tailgate32.com', 'tailgate32-staging.herokuapp.com', 'localhost', '127.0.0.1'].include?(rack_env['SERVER_NAME'])
  end

  # Redirect everything to tailgate32.footballnation.com
  r301 %r{.*}, 'http://tailgate32.com$&', :if => Proc.new {|rack_env|
    production_host?(rack_env)
  }


  ###########################################
  ############## Legacy Routes ##############
  ###########################################

  # Use /episodes for the episode archive
  r301 "/play", "/episodes"
  r301 "/play.html", "/episodes"

  # fix the querystring URL's for preloading an episode
  # e.g. /play?episode=bal --> /play/bal
  r301 %r{/play[^?]*\?episode=(\w+)}, "/play/$1"

  # links previously distributed to SI.com -- keep around so that those links don't break
  r301 "/tailgate32-ep01",    "http://www.youtube.com/embed/ctxN8gKQ_L8?vq=hd720&rel=0&showinfo=0"
  r301 "/tailgate32-trailer", "http://www.youtube.com/embed/q3eWWvPwXEA?vq=hd720&rel=0&showinfo=0"

  # for a short while we used /upcoming/hou instead of /events/hou
  r301 %r{/upcoming/(\w+)}, "/events/$1"

  # we no longer have event pages, redirect to the episode itself
  r301 %r{/events/(\w+)}, "/play/$1"

  # we don't have contests any longer
  r301 %r{/contests/*}, "/"

  # redirect links to the schedule to the schedule B-Side
  r301 %r{/schedule*}, "/b-sides/schedule"
end

use ::Rack::TryStatic,
  :root => "build",
  :urls => ["/"],
  :try  => [".html", "index.html", "/index.html"]

run lambda { [404, {"Content-Type" => "text/plain"}, ["File not found!"]] }
