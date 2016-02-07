class Episode < OpenStruct
  # TODO: whitelist attrs that can be passed in
  def initialize(hsh={})
    super
    hsh.keys.each {|key| self.send("#{key}=", hsh[key])}
  end

  def full_title
    "Episode #{self.number}: #{self.title}"
  end

  def title_for_meta_tags
    "Tailgate32 - Episode #{self.number}: #{self.title}"
  end

  def description_for_meta_tags
    self.description.to_s.gsub(/<\/?[^>]*>/, "").gsub(/\s+/, " ").gsub("\"", "")
  end

  def image_url
    "http://www.tailgate32.com/images/episodes/#{abbr}.png"
  end

  def thumbnail_url
    "/images/episodes/thumbs/#{abbr}.png"
  end

  def relative_url
    "/play/#{self.abbr}"
  end

  def canonical_url
    "http://www.tailgate32.com#{relative_url}"
  end

  def youtube_embed_url
    "https://www.youtube.com/embed/#{self.video_id}?vq=hd720&showinfo=0&rel=0"
  end
  
  def youtube_og_url
    "http://www.youtube.com/v/#{self.video_id}?version=3&amp;list=SPA41D72FECDA1002A"
  end

  def youtube_watch_url
    "https://www.youtube.com/watch?v=#{self.video_id}&feature=channel&list=UL"
  end

  def yt_embed_code
    %Q{<iframe id="ytplayer" width="720" height="405" src="#{self.youtube_embed_url}" frameborder="0" allowFullScreen></iframe>}
  end
  
  def og_url
    "https://player.vimeo.com/video/#{self.vimeo_id}?autoplay=1"
  end

  def twitter_url
    "https://player.vimeo.com/video/#{self.vimeo_id}"
  end

  def vimeo_embed_code
    %Q{<iframe src="https://player.vimeo.com/video/#{self.vimeo_id}?title=0&byline=0&portrait=0" width="720" height="405" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>}
  end

  def embed_code
    vimeo_embed_code
  end

  def on_itunes?
    !self.itunes.nil?
  end

  def itunes_url
    # default to show's home page
    self.itunes || "http://itunes.com/tailgate32"
  end

  def has_contest?
    !self.contest.nil?
  end

  def archive_url
    "/episodes"
  end
end
