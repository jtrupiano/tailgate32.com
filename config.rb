require './obj/contest'
require './obj/episode'
require './obj/revved_up_episode'
require './obj/bside'
require './obj/event'

##
# Helpers
###
helpers do
  def episodes
    @episodes ||= 
      data.episodes.keys.reject {|key| 
        !data.episodes[key].video_id 
      }.map {|abbr| 
        contest = data.contests.has_key?(abbr) ? Contest.new(data.contests[abbr]) : nil
        Episode.new(data.episodes[abbr].merge({abbr: abbr, contest: contest}))
      }
  end

  def bsides
    @bsides ||= data.bsides.keys.map {|abbr| Bside.new(data.bsides[abbr].merge({abbr: abbr}))}
  end

  def revvedup_episodes
    @revvedup_episodes ||= data.revvedup.keys.map {|abbr| RevvedUpEpisode.new(data.revvedup[abbr].merge({abbr: abbr}))}
  end

  def released_revvedup_episodes
    @released_revvedup_episodes ||= revvedup_episodes.select {|ep| ep.released?}
  end
end

###
# Page options, layouts, aliases and proxies
###

page "/index.html" do 
  @featured_episodes = [22,20,19,31].map {|i| episodes.reverse[i]}
  @featured_bsides   = [1,0,2,3].map {|i| bsides[i]}
end

page "/episodes.html"
episodes.each_with_index do |episode, i|
  page "/play/#{episode.abbr}.html", :proxy => "/play.html", :ignore => true do
    @episode = episode
    @next_episode = episodes[i-1]
  end
end

page "/b-sides.html"
bsides.each do |bside|
  page "/b-sides/#{bside.abbr}.html", :proxy => "/b-side.html", :ignore => true do
    @bside = bside
  end
end

page "/revved-up.html"
released_revvedup_episodes.each_with_index do |episode, i|
  page "#{episode.relative_url}.html", :proxy => "/revved-up-episode.html", :ignore => true do
    @episode = episode
    @next_episode = released_revvedup_episodes[(i+1) % released_revvedup_episodes.size]
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
