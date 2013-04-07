class String
  def number?
    Integer(self) != nil rescue false
  end
end