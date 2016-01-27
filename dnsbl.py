#! /usr/bin/env python2.7
# PYTHON_ARGCOMPLETE_OK
# -*- coding: utf-8 -*-
#
#  pydnsbl
#
#  Copyright 2013 Ken Iota Spencer <ken.spencer20@ymail.com>
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.


##Config
servers = [
    'dnsbl.dronebl.org',
    'dnsbl.proxybl.org',
    'tor.dnsbl.sectoor.de',
    'tor.dan.me.uk',
    'dnsbl.bnc4free.in',
    'dnsbl.jnabl.org',
    'rbl.efnet.org',
    'virbl.dnsbl.bit.nl',
    'dnsbl.ahbl.org',
    'rbl.faynticrbl.org',
    'dnsbl.libirc.so',
    'dnsbl.ipocalypse.net',
    'dnsbl.rizon.net',
    'dnsbl.swiftbl.org'
]


##Imports
from argparse import *
import os, sys, argcomplete, re
from socket import *

##Code

                print "Ok."
                x = .split()
                pattern = r"\b(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b"
                try:
                    i = x[1]
                except IndexError:
                    print "Prefix: %s%s <IP address>" % (prefix, cmd))
                if re.match(pattern, x[1]):
                    print "Scanning IP address..."
                    IP = x[1].split('.')
                    IPV4 = "%s.%s.%s.%s" % (IP[3], IP[2], IP[1], IP[0])
                    det = 0
                    ndet = 0
                    zone = []
                    for server in servers:
                        try:
                            socket.gethostbyname_ex(IPV4 + "." + server)
                            det += 1
                            zone.append(server )
                        except socket.gaierror:
                            ndet += 1
                    if det:
                        print "The IP has been detected %s times by %s BL zones." % (det, len(servers))
                        print "Detected BL zones: %s" % (", ".join(zone))
                    else:
                        print "The IP has not been detected by %s BL zones." % (len(servers))
                elif args.list == True:
                    for server in servers:
                        print server
                else:
                    print "The ip you entered is not valid."
