$:.unshift File.dirname($0)
require "highline"


class Gen
  @@conf = "Inspircd"
  def self.conf
    STDERR.puts "You have selected the #{@@conf.downcase}.conf generator"
    gen_conf
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
def gen_conf
# Conf generation
    # <server >
    print("Alright, first off", file=sys.stderr)
    print("1. Lets get the irc.server.name", file=sys.stderr)
    print("2. Your server info/server description/sdesc", file=sys.stderr)
    print("3. Your numeric. (If ElectroCode, ask Iota, otherwise talk to your network's routing team or whoever manages linking)", file=sys.stderr)
    print("This is your me {} block", file=sys.stderr)
    me_name = input()
    me_info = input()
    me_numeric = input()
    checkInt(me_numeric)
    # Admin {}
    print("Your admin {} lines.. ", file=sys.stderr)
    while True:
        line = input()
        if not line:
            break
        admin_block.append(line)
    #Class {}
    print("Alright, the next bit will get your settings for your 'clients' class", file=sys.stderr)
    print("Ping Frequency: The number of seconds between pings from the server (90-180 recommended) -- This is your PING/PONG from the server", file=sys.stderr)
    client_pingfreq = input()
    checkInt(client_pingfreq)
    print("Max Clients: Specifies the maximum amount of clients in this class (500 recommended)", file=sys.stderr)
    print(colored("Note", "red", attrs=["bold"]) + ": An example being this, if you maxclients is only 10, then you can only have 10 people on the server " + colored("TOTAL", "red", attrs=["bold"]) + "!", file=sys.stderr)
    client_max = input()
    checkInt(client_max)
    print("Send Quota(SendQ): Amount of data that can be in the send queue (100000 recommended)", file=sys.stderr)
    client_sendq = input()
    checkInt(client_sendq)
    print("Receive Quota(RecvQ): Amount of data that can be in the receive queue (3000-8000 recommended)", file=sys.stderr)
    client_recvq = input()
    checkInt(client_recvq)
    print(colored("-----------------------------------", "red", attrs=["bold"]), file=sys.stderr)
    print("This is your 'server(s)' class", file=sys.stderr)
    print("Ping Frequency: The number of seconds between the server pinging its links (90-180 recommended)", file=sys.stderr)
    server_pingfreq = input()
    checkInt(server_pingfreq)
    print("Connect Frequency: The number of seconds between each connection attempt (100 is recommended", file=sys.stderr)
    server_connfreq = input()
    checkInt(server_connfreq)
    print("Max Clients: For servers this means how many servers can be linked to this one server. (May conflict with leafdepth if set <5.. Recommended is 10)", file=sys.stderr)
    server_max = input()
    checkInt(server_max)
    print("Send Quota(SendQ): Amount of data that can be in the send queue (1000000 recommended)", file=sys.stderr)
    server_sendq = input()
    checkInt(server_sendq)
    print(colored("---------------------------------------------------------", "red", attrs=["bold"]), file=sys.stderr)
    print("Printing/Writing...", file=sys.stderr)
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
    print("""The next few questions will ask you for directives for an allow block""", file=sys.stderr)
    print("""Alright, what user@ip will be allowed? Use '.' as an entry for this to enter *@*""", file=sys.stderr)
    allow_ip = input()
    print("""What user@host will be allowed? Use '.' to enter *@*""", file=sys.stderr)
    allow_host = input()
    print("""What connection class does this allow {} belong in""", file=sys.stderr)
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
"""% (colored("password", "red", attrs=["bold"]), colored("method", "red", attrs=["bold"])), file=sys.stderr)
    allow_passwd = input()
    allow_passwd_method = input()
    print(
"""
How many clients can connect via this block?
If you chose '.'/*@* as host and ip then make sure to set this pretty high
Otherwise 5 is a good default, as that is the default connection limit for clones
If you're making Session Limit Increases through this then set this to as high as you need it.
""", file=sys.stderr)
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
""", file=sys.stderr)
    allow_clone_mask = input()
# Allow printing
    print("Printing/Redirecting to file", file=sys.stderr)
    print(colored("""-------------------------------------------------------""", "red", attrs=["bold"]), file=sys.stderr)
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
""", file=sys.stderr)
    print(
colored("""---------------------------------""", "red", attrs=["bold"]), file=sys.stderr)
    print(
"""
Name of the oper.. 'bob' 'Iota' as an example.
Case does count, so 'iota' 'IOTA' 'Iota' 'IoTa' are all different
""", file=sys.stderr)
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
""", file=sys.stderr)
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
""", file=sys.stderr)
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
""", file=sys.stderr)
    oper_rmodes = input()
    print(
"""
What connection class should this oper fall under?
A good default is clients, or an 'oper' class.
""", file=sys.stderr)
    oper_class = input()
    print(
"""
What flags should this oper get?
At the present time only short flags are implemented.
THERE IS NO VALIDATION FOR THIS YET
""", file=sys.stderr)
    oper_flags = input()
    print(
"""
Should this oper get a swhois?
If you want:
Oper is a dinosaur
Then enter 'is a dinosaur'
If you don't want a swhois in this block, enter '.'
""", file=sys.stderr)
    oper_swhois = input()
    print("""If the oper or you want to give any default snotices, put their letters here.""", file=sys.stderr)
    oper_snomask = input()
    print("""If you want the oper to get any other default modes, put them here.""", file=sys.stderr)
    oper_modes = input()
    print("""How many clients can use this oper block at the same time?""", file=sys.stderr)
    oper_max = input()
    checkInt(oper_max)
    print("""Printing/Writing""", file=sys.stderr)
    print(colored("""-----------------------------------""", "red", attrs=["bold"]), file=sys.stderr)
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
""", file=sys.stderr)
    link_name = input()
    print("""Username of the account on the remote server.
If you aren't using ident for identification you can enter '*' here.""", file=sys.stderr)
    link_username = input()
    print("""Hostname/IP of the remote server""", file=sys.stderr)
    link_hostname = input()
    print("""What IP on the local box should we bind to before connecting.
If you are on shared hosting or whathaveyou and your hosting provider
told you to use a specific ip when using network services, then use it.
Otherwise it should be safe to enter '*' here.""", file=sys.stderr)
    link_bindip = input()
    print("""What port on the remote machine should we connect to?""", file=sys.stderr)
    link_port = input()
    checkInt(link_port)
    print("""What password should we use to connect to the remote server?
And what password should we get back?
And what method should we use for the recvpass?
Enter "." for default encryption
Enter "-" for no encryption
These will be switched on the other side of the link""", file=sys.stderr)
    link_connpass = input()
    link_recvpass = input()
    link_method = input()

    print("""What class will this link block be in?
    A good default is 'servers'""", file=sys.stderr)
    link_class = input()
    print("""What options will we use?""", file=sys.stderr)
    link_options = []
    while True:
        line = input()
        if not line:
            break
        link_options.append(line)
    print("""Printing/Redirecting to file""", file=sys.stderr)
    print(colored("""-------------------------------------""", "red", attrs=["bold"]), file=sys.stderr)
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
    print("""Here's listen blocks""", file=sys.stderr)
    print("""What is the IP we're going to listen on?""", file=sys.stderr)
    listen_ip = input()
    print("""What port are we listening on?""", file=sys.stderr)
    listen_port = input()
    print("""What options will these blocks have?""", file=sys.stderr)
    listen_options = []
    while True:
        line = input()
        if not line:
            break
        listen_options.append(line)
    print("""Printing/Redirecting to file""", file=sys.stderr)
    print("""---------------------------------------""", file=sys.stderr)
    print("""listen %s:%s {"""% (listen_ip, listen_port))
    print("""    options {""")
    for option in listen_options:
        print("""        %s;"""% option)
    print("""    };""")
    print("""};""")
