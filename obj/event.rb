class Event < OpenStruct
  # TODO: whitelist attrs that can be passed in
  def initialize(hsh={})
    super
    hsh.keys.each {|key| self.send("#{key}=", hsh[key])}
  end

  def description_for_meta_tags
    self.description.to_s.gsub("\n", " ").gsub("\"", "")
  end
end
