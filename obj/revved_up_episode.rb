class RevvedUpEpisode < OpenStruct
  # TODO: whitelist attrs that can be passed in
  def initialize(hsh={})
    super
    hsh.keys.each {|key| self.send("#{key}=", hsh[key])}
  end

  def released?
    !blip_embed_id.blank?
  end

  def full_title
    "Revved Up Episode #{self.number}: #{self.title}"
  end

  def description_for_meta_tags
    self.description.to_s.gsub(/<\/?[^>]*>/, "").gsub(/\s+/, " ").gsub("\"", "")
  end

  def thumbnail_url
    "/images/revved-up/thumbs/#{abbr}.png"
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
