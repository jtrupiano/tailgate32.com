require './obj/contest'
require './obj/episode'
require './obj/event'

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
    @episodes ||= 
      data.episodes.keys.reject {|key| 
        !data.episodes[key].video_id 
      }.map {|abbr| 
        contest = data.contests.has_key?(abbr) ? Contest.new(data.contests[abbr]) : nil
        Episode.new(data.episodes[abbr].merge({abbr: abbr, contest: contest}))
      }
  end

  def bsides
    _as_ostructs(data.bsides).reject {|bside| !bside.video_id }
  end

  def events
    @events ||= 
      data.events.keys.map {|key| 
        episode = episodes.detect {|ep| ep.abbr == key }
        Event.new(data.events[key].merge({abbr: key, episode: episode}))
      }
  end
  
  def upcoming_events
    [events.last]
    # events.reject {|event| Date.today > Date.parse(event.date)}
  end

  def contests
    data.contests.keys.map {|contest_key|
      abbr = data.contests[contest_key].episode
      episode = data.episodes.has_key?(abbr) ?
        Episode.new(data.episodes[abbr].merge({abbr: abbr})) :
        nil
      Contest.new(data.contests[contest_key].merge({key: contest_key, episode: episode}))
    }
  end

  def active_contests
    contests.select {|c| c.active? }
  end
end

###
# Page options, layouts, aliases and proxies
###

page "/index.html" do 
  @episode = episodes.first
  @afc_episodes = [3,23,19,9].map {|i| episodes.reverse[i]}
  @nfc_episodes = [16,6,4,20].map {|i| episodes.reverse[i]}
end

page "/episodes.html"
episodes.each do |episode|
  page "/play/#{episode.abbr}.html", :proxy => "/play.html", :ignore => true do
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

page "/contests.html" do
  @contest = active_contests.first
  @episode = @contest.episode
end

contests.each do |contest|
  page "/contests/#{contest.key}.html", :proxy => "/contests.html" do
    @contest = contest
    @episode = @contest.episode
  end
end

page "/schedule.html"

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
