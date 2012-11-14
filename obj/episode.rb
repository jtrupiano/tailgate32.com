class Episode < OpenStruct
  # TODO: whitelist attrs that can be passed in
  def initialize(hsh={})
    super
    hsh.keys.each {|key| self.send("#{key}=", hsh[key])}
  end

  def full_title
    "Tailgate32 Episode #{self.number}: #{self.title}"
  end

  def description_for_meta_tags
    self.description.to_s.gsub(/<\/?[^>]*>/, "").gsub(/\s+/, " ").gsub("\"", "")
  end

  def image_url
    "http://tailgate32.com/images/episodes/#{abbr}.png"
  end

  def thumbnail_url
    "/images/episodes/thumbs/#{abbr}.png"
  end

  def relative_url
    "/play/#{self.abbr}"
  end

  def canonical_url
    "http://tailgate32.com#{relative_url}"
  end

  def youtube_embed_url
    "https://www.youtube.com/embed/#{self.video_id}?vq=hd720&showinfo=0"
  end
  
  def youtube_og_url
    "http://www.youtube.com/v/#{self.video_id}?version=3&amp;list=SPA41D72FECDA1002A"
  end

  def youtube_watch_url
    "https://www.youtube.com/watch?v=#{self.video_id}&feature=channel&list=UL"
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
end
