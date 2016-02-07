class Bside < OpenStruct
  # TODO: whitelist attrs that can be passed in
  def initialize(hsh={})
    super
    hsh.keys.each {|key| self.send("#{key}=", hsh[key])}
  end

  def full_title
    "The B-Sides &mdash; #{self.title}"
  end

  def title_for_meta_tags
    "The B-Sides - #{self.title}"
  end

  def description_for_meta_tags
    self.description.to_s.gsub(/<\/?[^>]*>/, "").gsub(/\s+/, " ").gsub("\"", "")
  end

  def image_url
    "http://tailgate32.com/images/b-sides/#{abbr}.png"
  end

  def thumbnail_url
    "/images/b-sides/thumbs/#{abbr}.png"
  end

  def relative_url
    "/b-sides/#{self.abbr}"
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

  def archive_url
    "/b-sides"
  end
end
