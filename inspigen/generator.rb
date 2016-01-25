class Gen
  @@conf = "inspircd.conf"
  def self.conf
    STDERR.puts "You have selected the #{@@conf} #{self} generator"
  end
  def self.oper
    STDERR.puts "You have selected the #{@@conf} generator"
  end
  def self.connect
    STDERR.puts "You have selected the #{@@conf} generator"
  end
  def self.link
    STDERR.puts "You have selected the #{@@conf} generator"
  end
  def self.listen
    STDERR.puts "You have selected the #{@@conf} generator"
  end
end
