class Gen
  @@conf = "inspircd.conf"
  def self.conf
    STDERR.puts "You have selected the #{@@conf} generator"
  end
  def self.opers.conf
    STDERR.puts "You have selected the #{@@conf} #{__method__.to_s} generator"
  end
  def self.connect
    STDERR.puts "You have selected the #{@@conf} #{__method__.to_s} generator"
  end
  def self.links.conf
    STDERR.puts "You have selected the #{@@conf} #{__method__.to_s} generator"
  end
  def self.listen.conf
    STDERR.puts "You have selected the #{@@conf} #{__method__.to_s} generator"
  end
end
