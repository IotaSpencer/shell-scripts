$:.unshift File.dirname($0)
require "highline"


class Gen
  @@conf = "Inspircd"
  def self.conf
    STDERR.puts "You have selected the #{@@conf.downcase}.conf generator"
    a = HighLine.new($stdin, $stderr)
    # Conf generation
    # <server>
    a.say "Alright, first off"
    a.say \
      "1. Lets get the irc.server.name
      2. Your server info/server description/sdesc
      3. Your numeric. (If ElectroCode, ask Iota, otherwise talk to your network's routing team or whoever manages linking)"
    a.say "This will be your <server> block"
    me_name = a.ask "Server Name? "
    me_info = a.ask "Server Description? "
    me_id = a.ask("SID? ") do |q|
      q.validate = /\d[0-9A-Z][0-9A-Z]/
    end
    me_net = a.ask "What Network Name? "
    # <admin>
    a.say "Your <admin> lines.."
    admin_name = a.ask "Admin Real Name? "
    admin_nick = a.ask "Admin Nick? "
    admin_email = a.ask("Admin Email? ") do |q|
      q.validate = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/
    end
    # <connect> in Inspircd doesn't configure servers
    # so this is all client related options
    a.say "Alright, the next bit will get your settings for your <connect> block"
    a.say "First thing, since conf generation usually means you're starting out, we're going to default to allow."
    a.say "You can generate more <connect> blocks using the the '-t connect' options when starting the script."
    a.say "We also default to allow=\"*\""

    a.say \
      "Ping Frequency: The number of seconds between pings from the server (90-240 recommended)
      This is the frequency at which the server pings you.
      You want to set this low enough that you have accurate/real connections,
      but also high enough for some laggy or 'stupid' clients"
    connect_pingfreq = a.ask("? ", Integer) do |q|
      q.default = 240
      q.in = 0..300
      q.answer_or_default
    end
    a.say \
      "TimeOut: This is the amount of seconds the server will wait before disconnecting a
      user when doing registration (the auth aka. /nick /user, /pass)"
    connect_timeout = a.ask("? ", Integer) do |q|
      q.default = 240
      q.in = 0..300
      q.answer_or_default
    end

    a.say "Max Local Clients: Specifies the maximum amount of clients <%= color(\"per IP\", :red, :bold) %> on this server
    Note: 3-5 recommended "
    connect_localmax = a.ask("? ", Integer) do |q|
      q.default = 5
      q.in = 1..1000
      q.answer_or_default
    end

    a.say "Max Global Clients: Specifies the maximum amount of clients <%= color(\"per IP\", :red, :bold) %> network-wide
    Note: 3-5 recommended "
    connect_globalmax = a.ask("? ", Integer) do |q|
      q.default = 5
      q.in = 1..1000
      q.answer_or_default
    end
    a.say \
      "Max Channels: Specifies the maximum number of channels users in this block can join.
      This overrides every other maxchans setting.
      Note: The validation range goes to 1000, if you want to increase it, enter a random
      number or accept the default. "
    connect_maxchans = a.ask("? ", Integer) do |q|
      q.default = 100
      q.in = 20..1000
      q.answer_or_default
    end
    a.say "Send Quota(SendQ): Amount of data that can be in the send queue
    Note: ~100000+ recommended "
    connect_sendq = a.ask("? ", Integer) do |q|
      q.default = 131074
      q.in = 0..1000000
      q.answer_or_default
    end
    a.say "Receive Quota(RecvQ): Amount of data that can be in the receive queue
    Note: 3000-8000 recommended "
    connect_recvq = a.ask("? ", Integer) do |q|
      q.default = 4096
      q.in = 3000..10000
      q.answer_or_default
    end
    a.say "<%= color(\"-----------------------------------\", :red, :bold) %>"

    # print_conf

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
  name=\"#{admin_name}\"
  nick=\"#{admin_nick}\"
  email=\"#{admin_email}\">"
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

=begin
    #Class {}

    checkInt(server_sendq)
    print(colored("---------------------------------------------------------", "red", attrs=["bold"]))
    print("Printing/Writing...")
    # Conf printing
    ##Default text
    print("""
/*
# - Regular comment
// - Another comment
/*text*/
# and /* */ can be inline comments
and as you can see /**/ can also be multiline comments
*/
""")
    #   me {}
    print(
"""
me {
    name "%s";
    info "%s";
    numeric %s;
};
"""% (me_name, me_info, me_numeric))
#   admin {}
    print("""admin {""")
    for text in admin_block:
        print("""    \"%s\";"""% text)
    print("""};""")
# Class {}
    for classes in ("clients", "servers"):
        print(
"""
class %s {"""% classes)
        if classes == "servers":
            print(
"""    pingfreq %s;
    connfreq %s;
    maxclients %s;
    sendq %s;
};
"""% (server_pingfreq, server_connfreq, server_max, server_sendq))
        if classes == "clients":
            print(
"""    pingfreq %s;
    maxclients %s;
    sendq %s;
    recvq %s;
};
"""% (client_pingfreq, client_max, client_sendq, client_recvq))
def allow():
    print("""The next few questions will ask you for directives for an allow block""")
    print("""Alright, what user@ip will be allowed? Use '.' as an entry for this to enter *@*""")
    allow_ip = input()
    print("""What user@host will be allowed? Use '.' to enter *@*""")
    allow_host = input()
    print("""What connection class does this allow {} belong in""")
    allow_class = input()
    print(
"""
Do you want a connection password for this allow {} ?
If you want to use a different encryption mechanism then enter in this fashion
    %s
    %s
If you don't want a password, enter "." for both entries, if you don't want encryption on your password, enter "-"(minus/hyphen/em dash) for your method
    PASSWORD
    -
"""% (colored("password", "red", attrs=["bold"]), colored("method", "red", attrs=["bold"])))
    allow_passwd = input()
    allow_passwd_method = input()
    print(
"""
How many clients can connect via this block?
If you chose '.'/*@* as host and ip then make sure to set this pretty high
Otherwise 5 is a good default, as that is the default connection limit for clones
If you're making Session Limit Increases through this then set this to as high as you need it.
""")
    allow_max = input()
    checkInt(allow_max)
    print(
"""
How many bits of an IPV6 address do consider unique?
128 means any variation of an IPV6 address is unique.
If you allow znc users on IPV6 then you should set this to 128
Otherwise, due to current address allocation policies to residents, 64 is the
recommended clone mask.
Enter "." to leave this directive out of the block.
""")
    allow_clone_mask = input()
# Allow printing
    print("Printing/Redirecting to file")
    print(colored("""-------------------------------------------------------""", "red", attrs=["bold"]))
    print("""allow {""")
    if allow_ip:
        if allow_ip == ".":
            print("""    ip *@*;""")
        if allow_ip != ".":
            print("""    ip %s;"""% allow_ip)
    if allow_host:
        if allow_host == ".":
            print("""    hostname *@*;""")
        if allow_host != ".":
            print("""    hostname %s;"""% allow_host)
    print("""    class %s;"""% allow_class)
    if allow_passwd:
        if allow_passwd and allow_passwd_method == ".":
            pass
        elif allow_passwd != "." and allow_passwd_method == "-":
            print("""    password "%s";"""% allow_passwd)
        elif allow_passwd != "." and allow_passwd_method == ".":
            print_pass = genPass("ripemd160", allow_passwd)
            print("""    password "%s" { ripemd160; };"""% print_pass)
        elif allow_passwd != "." and allow_passwd_method != ".":
            if allow_passwd_method in ("ripemd160", "sha1", "md5"):
                print_pass = genPass(allow_passwd_method, allow_passwd)
                print("""    password "%s" { %s; };"""% (print_pass, allow_passwd_method))
    if allow_max:
        print("""    maxperip %s;"""% allow_max)
    if allow_clone_mask:
        if allow_clone_mask == ".":
            pass
        else:
            print("""    ipv6-clone-mask %s;"""% allow_clone_mask)
    print("""};""")
def oper():
    print(
"""Here's the oper block generator
""")
    print(
colored("""---------------------------------""", "red", attrs=["bold"]))
    print(
"""
Name of the oper.. 'bob' 'Iota' as an example.
Case does count, so 'iota' 'IOTA' 'Iota' 'IoTa' are all different
""")
    oper_name = input()
    print(
"""
What hosts will this oper be connecting from.
Your input should be
user1@host1
user2@host2
user3@host3
...
To end, enter a blank newline.
""")
    while True:
        line = input()
        if not line:
            break
        hosts.append(line)
    print(
"""
Now I need the password you want.
If you want to encrypt it then I need you to enter like this
'''
password
method
'''
Methods are ripemd160, sha1, and md5
Use
'''
password
.
'''
to use the default method 'ripemd160'
""")
    oper_pass = input()
    oper_method = input()
    if oper_method != "-" and oper_method not in ("ripemd160", "sha1", "md5"):
        raise CustomError("Error: Method not supported -> %s"% oper_method)
    print(
"""
Want the user to need any modes before being able to oper?
If you use z then the user will need to be connected via SSL to oper
If you use r then the user needs to be identified before opering.
etc.
Enter "." if you don't need this directive.
""")
    oper_rmodes = input()
    print(
"""
What connection class should this oper fall under?
A good default is clients, or an 'oper' class.
""")
    oper_class = input()
    print(
"""
What flags should this oper get?
At the present time only short flags are implemented.
THERE IS NO VALIDATION FOR THIS YET
""")
    oper_flags = input()
    print(
"""
Should this oper get a swhois?
If you want:
Oper is a dinosaur
Then enter 'is a dinosaur'
If you don't want a swhois in this block, enter '.'
""")
    oper_swhois = input()
    print("""If the oper or you want to give any default snotices, put their letters here.""")
    oper_snomask = input()
    print("""If you want the oper to get any other default modes, put them here.""")
    oper_modes = input()
    print("""How many clients can use this oper block at the same time?""")
    oper_max = input()
    checkInt(oper_max)
    print("""Printing/Writing""")
    print(colored("""-----------------------------------""", "red", attrs=["bold"]))
    print("""oper %s {"""% oper_name)
    print("""    from {""")
    for host in hosts:
        print("""        userhost %s;"""% host)
    print("""    };""")
    if oper_pass:
        if oper_method == ".":
            print_pass = genPass("ripemd160", oper_pass)
            print("   password \"%s\" { \"ripemd160\"; };"% oper_pass)
        if oper_method == "-":
            print("""    password "%s";"""% oper_pass)
        if oper_method != "-":
            print_pass = genPass(oper_method, oper_pass)
            print("""    password "%s" { %s; };"""% (print_pass, oper_method))
    if oper_rmodes:
        if oper_rmodes == ".":
            pass
        if oper_rmodes != ".":
            print("""    require-modes "%s";"""% oper_rmodes)
    if oper_class:
        if oper_class == ".":
            print("""    class clients;""")
        if oper_class != ".":
            print("""    class %s;"""% oper_class)
    if oper_flags:
        print("""    flags "%s";"""% oper_flags)
    if oper_swhois:
        if oper_swhois == ".":
            pass
        if oper_swhois != ".":
            print("""    swhois "%s";"""% oper_swhois)
    if oper_snomask:
        if oper_snomask == ".":
            pass
        if oper_snomask != ".":
            print("""    snomask %s;"""% oper_snomask)
    if oper_modes:
        if oper_modes == ".":
            pass
        if oper_modes != ".":
            print("""    modes %s;"""% oper_modes)
    if oper_max:
        if oper_max == ".":
            pass
        if oper_max != ".":
            print("""    maxlogins %s;"""% oper_max)
    print("""};""")
def link():
    print(
"""
What is the irc.server.name of the server we're connecting to?
""")
    link_name = input()
    print("""Username of the account on the remote server.
If you aren't using ident for identification you can enter '*' here.""")
    link_username = input()
    print("""Hostname/IP of the remote server""")
    link_hostname = input()
    print("""What IP on the local box should we bind to before connecting.
If you are on shared hosting or whathaveyou and your hosting provider
told you to use a specific ip when using network services, then use it.
Otherwise it should be safe to enter '*' here.""")
    link_bindip = input()
    print("""What port on the remote machine should we connect to?""")
    link_port = input()
    checkInt(link_port)
    print("""What password should we use to connect to the remote server?
And what password should we get back?
And what method should we use for the recvpass?
Enter "." for default encryption
Enter "-" for no encryption
These will be switched on the other side of the link""")
    link_connpass = input()
    link_recvpass = input()
    link_method = input()

    print("""What class will this link block be in?
    A good default is 'servers'""")
    link_class = input()
    print("""What options will we use?""")
    link_options = []
    while True:
        line = input()
        if not line:
            break
        link_options.append(line)
    print("""Printing/Redirecting to file""")
    print(colored("""-------------------------------------""", "red", attrs=["bold"]))
    print("""link %s {"""% link_name)
    print("""    username %s;"""% link_username)
    print("""    hostname %s;"""% link_hostname)
    print("""    bind-ip %s;"""% link_bindip)
    print("""    port %s;"""% link_port)
    print("""    password-connect "%s";"""% link_connpass)
    if link_recvpass:
        if link_method == ".":
            print_pass = genPass("ripemd160", link_recvpass)
            print("""    password-receive "%s" { ripemd160; };"""% print_pass)
        if link_method != ".":
            print_pass = genPass(link_method, link_recvpass)
            print("""    password-receive "%s" { %s; };"""% (print_pass, link_method))
    if link_class:
        print("""    class %s;"""% link_class)
    print("""    options {""")
    for option in link_options:
        print("""        %s;"""% option)
    print("""    };""")
    print("""};""")
def listen():
    print("""Here's listen blocks""")
    print("""What is the IP we're going to listen on?""")
    listen_ip = input()
    print("""What port are we listening on?""")
    listen_port = input()
    print("""What options will these blocks have?""")
    listen_options = []
    while True:
        line = input()
        if not line:
            break
        listen_options.append(line)
    print("""Printing/Redirecting to file""")
    print("""---------------------------------------""")
    print("""listen %s:%s {"""% (listen_ip, listen_port))
    print("""    options {""")
    for option in listen_options:
        print("""        %s;"""% option)
    print("""    };""")
    print("""};""")
=end
