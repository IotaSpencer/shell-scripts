class Gen
  @@conf = "Inspircd"
  def self.conf
    STDERR.puts "You have selected the #{@@conf.downcase}.conf generator"
  end
  def self.opers
    STDERR.puts "You have selected the #{@@conf} #{__method__.to_s}.conf generator"
  end
  def self.connect
    STDERR.puts "You have selected the #{@@conf} #{__method__.to_s}.conf generator"
  end
  def self.links
    STDERR.puts "You have selected the #{@@conf} #{__method__.to_s}.conf generator"
  end
  def self.listen
    STDERR.puts "You have selected the #{@@conf} #{__method__.to_s}.conf generator"
  end
end
