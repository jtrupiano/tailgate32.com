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

  def description
    "Tailgate32 and Man Crates have teamed up to run several contests over the next few weeks where you can win a Tailgate32 Man Crate."
  end
end
