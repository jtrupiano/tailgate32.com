class Event < OpenStruct
  # TODO: whitelist attrs that can be passed in
  def initialize(hsh={})
    super
    hsh.keys.each {|key| self.send("#{key}=", hsh[key])}
  end

  def description_for_meta_tags
    self.description.to_s.gsub("\n", " ").gsub("\"", "")
  end

  def matchup
    self.title.split(":")[1]
  end

  def away_team
    self.matchup.split("@")[0]
  end

  def home_team
    self.matchup.split("@")[1]
  end

  def short_date
    Date.parse(self.date).strftime("%b %e")
  end

  def relative_url
    "/events/#{abbr}"
  end

  def canonical_url
    "http://tailgate32.footballnation.com#{relative_url}"
  end

  def has_episode?
    !self.episode.nil?
  end

  def past?
    Date.parse(self.date) <= Date.today
  end
end
