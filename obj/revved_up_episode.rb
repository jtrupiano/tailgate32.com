class RevvedUpEpisode < OpenStruct
  # TODO: whitelist attrs that can be passed in
  def initialize(hsh={})
    super
    hsh.keys.each {|key| self.send("#{key}=", hsh[key])}
  end

  def released?
    self.released
  end

  def full_title
    "Revved Up &mdash; Episode #{self.number}: #{self.title}"
  end

  def title_for_meta_tags
    "Revved Up - Episode #{self.number}: #{self.title}"
  end

  def description_for_meta_tags
    self.description.to_s.gsub(/<\/?[^>]*>/, "").gsub(/\s+/, " ").gsub("\"", "")
  end

  def image_url
    "http://tailgate32.com/images/revved-up/#{abbr}.png"
  end

  def thumbnail_url
    self.released? ?
      "/images/revved-up/thumbs/#{abbr}.png" :
      "/images/revved-up/thumbs/#{abbr}-unreleased.png"
  end

  def relative_url
    "/revved-up/#{self.abbr}"
  end

  def canonical_url
    "http://tailgate32.com#{relative_url}"
  end

  def og_url
    "http://blip.tv/revvedup/#{self.blip_og_id}"
  end

  def embed_url
    "http://blip.tv/play/#{self.blip_embed_id}.x?p=1"
  end

  def embed_code
    %Q{<iframe src="#{self.embed_url}" width="720" height="433" frameborder="0" allowfullscreen></iframe><embed type="application/x-shockwave-flash" src="http://a.blip.tv/api.swf##{self.blip_embed_id}" style="display:none"></embed>}
  end
end
