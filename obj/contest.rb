class Contest < OpenStruct
  # TODO: whitelist attrs that can be passed in
  def initialize(hsh={})
    super
    hsh.keys.each {|key| self.send("#{key}=", hsh[key])}
  end

  def thumbnail_url
    "http://tailgate32.footballnation.com/images/contest.jpg"
  end

  def canonical_url
    "http://tailgate32.footballnation.com/contests/#{self.key}"
  end
end
