class String
  def to_camel
    self.split(/_/).map(&:capitalize).join
    # or
    # self.split(/_/).map{ |w| w[0] = w[0].upcase; w }.join
  end

  def to_snake
    puts "String.to_snake"
    self.gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
        .gsub(/([a-z\d])([A-Z])/, '\1_\2')
        .downcase
  end

  def to_table_name
    p "String.to_table_name"
    pattern = /.*[^aiueo]y/
    rep_pattern = /[^aiueo]y_ies/
    p "OK" if self.match(pattern)
    if (self.end_with?("s") ||
        self.end_with?("sh") ||
        self.end_with?("ch") ||
        self.end_with?("o") ||
        self.end_with?("x")) 
      self << "es"
    elsif (self.end_with?("f") || self.end_with?("fe"))
      self.gsub!("fe", "ves")
    elsif (self.match(pattern))
      self << '_ies'
      self.gsub!(rep_pattern, "ies")
    else 
      self << "s"
    end
    self
  end
end
