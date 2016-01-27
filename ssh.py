#! /usr/bin/env python2.7
# PYTHON_ARGCOMPLETE_OK
# -*- coding: utf-8 -*-
#
#  pyssh
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

# TODO

# FIXME

from argparse import *
from subprocess import *
from configparser import *
from pexpect import *
import argcomplete, sys, os, signal
#usage = 'usage: %prog [options] args'
prog = 'pyssh'
description = 'SSH client somewhat replacementish thing.'
version = '%(prog)s 0.1'
def makeArguments():
    """Makes the arguments object and allows them to be autocompleted"""
    p = ArgumentParser(formatter_class=RawDescriptionHelpFormatter, description=description)
    key = p.add_argument_group('key', 'SSH Key specific commands.')
    usual = p.add_argument_group('usual', 'Usual Commands')
    server = p.add_argument_group('server', 'Server specific Commands')
    pathg = p.add_argument_group('Config',
    '''
    Configuration Arguments
    ''')
    p.add_argument('-v', '--version', action='version', version=version)
    server.add_argument('-r', '--raw', action='store_true', dest='raw', help='Whether or not to use a raw ssh string')
    server.add_argument('-c', '--connect', action='store_true', help='Whether or not you actually want to connect to the server given by -s/--server')
    server.add_argument('-p', '--password', action='store_true', help='Get password for server given by -s/--server')
    server.add_argument('-s', '--server', action='store', dest='host', help='use given server')
    server.add_argument('--port', action='store', dest='port', help='''Port to use to connect''')
    server.add_argument('-u', '--user', action='store', dest='user', help='Used with -s/--server and -c/--connect')
    server.add_argument('-l', '-ls', '--list', action='store_true', dest='list', help=
    """
    Get the list of servers in your ini file
    """)
    server.add_argument('-a', '--auto', action='store_true', dest='auto', help=
    """
    Connect to server given in -s/--server
    """)
    key.add_argument('-k', '--want-key', action='store_true', dest='key', help='''Print public key from ~/.ssh/id_rsa.pub
If -f/--key-path <path> is given, read key from that path''')
    key.add_argument('-f', '--key-path', action='store', default='~/.ssh/id_rsa.pub', dest='keypath', help='Read key from <path>')
    usual.add_argument('-e', '--edit', action='store_true', dest='edit', help='Edit? If --editor not given use, then it uses vi')
    usual.add_argument('--editor', action='store', default='vi', dest='editor', help='Used with -e/--edit, but not needed for most uses')
    pathg.add_argument('--config-path', action='store', default=os.path.expanduser('~/ssh.ini'), dest='config_path', help=
    '''
    Configuration File Path
    (See example config (not made yet))
    (default: %(default)s)
    ''')
    argcomplete.autocomplete(p)
    global args
    args = p.parse_args()
def makeConfig():
    """Makes the configuration object"""
    f = args.config_path
    global config
    config = ConfigParser()
    config.read(f, encoding='cp1250')
def autoconnect():
    """Used for letting the configuration file be read to connect"""
    if not args.port:
        if config.get(args.host, 'port'):
            port = config.get(args.host, 'port')
        elif config.get('DEFAULT', 'port'):
            port = config.get('DEFAULT', 'port')
        else:
            nport = 1

    elif args.port:
        port = args.port
    if not args.user:
        if config.get(args.host, 'user'):
            user = config.get(args.host, 'user')
        elif config.get('DEFAULT', 'user'):
            user = config.get('DEFAULT', 'user')
        else:
            nuser = 1
    elif args.user:
        user = args.user
    else:
        if nuser == 1 and user:
            print "Cannot find user, please add the user of %s to the configuration file @ %s" % (host, config_path)
            sys.exit()
        if nport == 1:
            print "Cannot find %s\'s port, please add the port of %s to the configuration file %s" % (host, config_path)
            sys.exit()
    host = config.get(args.host, 'host')
    password = config.get(args.host, 'password')
    print "connection = spawn('ssh -p %s %s@%s')" % (port, user, host)
    connection = spawn('ssh -p %s %s@%s' % (port, user, host))
    connection.expect('(?i)password')
    #connection.waitnoecho()
    connection.sendline('%s' % (password))
    #connection.expect('[#$]')
    connection.interact()
def rawconnect():
    """Connect 'rawly' to the server"""
    port = args.port
    user = args.user
    host = args.host
    os.system('ssh -p %s %s@%s' % (port, user, host))
def main():
    """Main function of the program that contains all of the other functions and the functionality of the script"""
    print args
    if args.list:
        sections = config.sections()
        print ', '.join([str(item) for item in sections])
    if args.raw:
        rawconnect()
    if args.key:
        os.system('cat %s' % (args.keypath))
    if args.edit:
        if args.editor:
            editor = args.editor
            os.system('screen -dmS %s-edit %s ~/%s' % (prog, editor, prog))
            print "Opened %s in %s" % (prog, editor)
    elif args.auto:
        autoconnect()
if __name__ == "__main__":
    makeArguments()
    makeConfig()
    main()
