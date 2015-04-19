class String
  def to_b
    self =~ /^(true|t|yes|y|1)$/i ? true : false
  end
end