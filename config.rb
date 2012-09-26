### 
# Compass
###

# Susy grids in Compass
# First: gem install compass-susy-plugin
# require 'susy'

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

##
# Helpers
###
helpers do
  def _as_ostructs(hsh)
    hsh.keys.map {|key|
      OpenStruct.new(hsh[key].merge({abbr: key}))
    }
  end

  def episodes
    _as_ostructs(data.episodes).reject {|ep| !ep.video_id }
  end

  def bsides
    _as_ostructs(data.bsides).reject {|bside| !bside.video_id }
  end

  def events
    _as_ostructs(data.events)
  end

  def upcoming_events
    events.reject {|event| Date.today - 1 > Date.parse(event.date)}
  end
end

###
# Page options, layouts, aliases and proxies
###

page "/index.html" do 
  @episode = episodes.first
end

page "/play.html" do
  @episode = episodes.first
end

episodes.each do |episode|
  page "/play/#{episode.abbr}.html", :proxy => "/play.html" do
    @episode = episode
  end
end

page "/b-sides.html" do
  @bside = bsides.first
end

bsides.each do |bside|
  page "/b-sides/#{bside.abbr}.html", :proxy => "/b-sides.html" do
    @bside = bside
  end
end

page "/events.html" do
  @event   = upcoming_events.first
end

events.each do |event|
  page "/events/#{event.abbr}.html", :proxy => "/events.html" do
    @event  = event
  end
end

# Per-page layout changes:
# 
# With no layout
# page "/path/to/file.html", :layout => false
# 
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
# 
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy (fake) files
# page "/this-page-has-no-template.html", :proxy => "/template-file.html" do
#   @which_fake_page = "Rendering a fake page with a variable"
# end

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css
  
  # Minify Javascript on build
  # activate :minify_javascript
  
  # Enable cache buster
  activate :cache_buster
  
  # Use relative URLs
  # activate :relative_assets
  
  # Compress PNGs after build
  # First: gem install middleman-smusher
  # require "middleman-smusher"
  # activate :smusher
  
  # Or use a different image path
  # set :http_path, "/Content/images/"
end
