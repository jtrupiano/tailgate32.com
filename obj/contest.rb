class Contest < OpenStruct
  # TODO: whitelist attrs that can be passed in
  def initialize(hsh={})
    super
    hsh.keys.each {|key| self.send("#{key}=", hsh[key])}
  end

  def thumbnail_url
    "http://tailgate32.footballnation.com/images/prizes/#{self.prize_image}"
  end

  def canonical_url
    "http://tailgate32.footballnation.com/contests/#{self.key}"
  end

  def title
    if prize_is_crate?
      "Tailgate32 Man Crates Supply Drop Giveaway"
    else
      "Tailgate32 T-Shirt Giveaway"
    end
  end

  def description
    if prize_is_crate?
      "Tailgate32 and Man Crates have teamed up to run several contests over the next few weeks where you can win a Tailgate32 Man Crate."
    else
      "Want one of those cool Tailgate32 t-shirts you see us rocking in all of the episodes?  Well we're giving a bunch of them away now.  Follow this link to enter!"
    end
  end

  def title_for_contest_list
    "Win #{prize} (#{episode.title})"
  end

  def active?
    self.active
  end

  def prize_is_crate?
    prize_image == "crate.jpg"
  end

  def relative_url
    "/contests/#{self.key}"
  end
end
