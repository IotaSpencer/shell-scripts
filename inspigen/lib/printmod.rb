require "highline"

module Print
  def conf
    attr_accessor :me_name, :me_info, :me_id, :me_net
    attr_accessor :admin_name, :admin_nick, :admin_email
    attr_accessor :connect_maxchans, :connect_timeout, :connect_pingfreq, :connect_sendq, :connect_recvq, :connect_localmax, :connect_globalmax, :connect_umodes
    puts "\e[31m-----------------------------\e[0m"
    puts \
"/*
# - Regular comment
// - Another comment
/*text*/
# and /* */ can be inline comments
and as you can see /**/ can also be multiline comments
*/
"
#   me {}
    puts \
"<server
  name=\"#{me_name}\"
  description=\"#{me_info}\"
  id=\"#{me_id}\"
  network=\"#{me_net}\">"
#   <admin>
    puts \
"<admin
  name=\"#{admin_line[0]}\"
  nick=\"#{admin_line[1]}\"
  email=\"#{admin_line[2]}\">"
#   <connect>
    puts \
"<connect
  allow=\"*\"
  maxchans=\"#{connect_maxchans}\"
  timeout=\"#{connect_timeout}\"
  pingfreq=\"#{connect_pingfreq}\"
  sendq=\"#{connect_sendq}\"
  recvq=\"#{connect_recvq}\"
  localmax=\"#{connect_localmax}\"
  globalmax=\"#{connect_globalmax}\"
  useident=\"no\"
  limit=\"5000\"
  modes=\"#{connect_umodes}\">"
