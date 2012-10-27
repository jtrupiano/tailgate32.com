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
    if haiku?
      "Tailgate32 Haiku Contest"
    elsif prize_is_crate?
      "Tailgate32 Man Crates Supply Drop Giveaway"
    else
      "Tailgate32 T-Shirt Giveaway"
    end
  end

  def description
    if haiku?
      "Tailgate32 is running a haiku contest!  Use 17 syllables to tell us why you love to tailgate and you could win a Tailgate32 Man Crate."
    elsif prize_is_crate?
      "Tailgate32 and Man Crates have teamed up to run several contests over the next few weeks where you can win a Tailgate32 Man Crate."
    else
      "Want one of those cool Tailgate32 t-shirts you see us rocking in all of the episodes?  Well we're giving a bunch of them away now.  Follow this link to enter!"
    end
  end

  def title_for_contest_list
    if haiku?
      "Haiku Contest"
    else
      "Win #{prize} (#{episode.title})"
    end
  end

  def active?
    self.active
  end

  def rafflecopter?
    self.contest_type == "rafflecopter"
  end

  def haiku?
    self.contest_type == "haiku"
  end

  def prize_is_crate?
    prize_image == "crate.jpg"
  end

  def relative_url
    "/contests/#{self.key}"
  end
end
