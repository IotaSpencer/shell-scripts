#!/usr/bin/env python2.7
# PYTHON_ARGCOMPLETE_OK
# Script to start up and maintain the reddit_irc bot
# -*- coding: utf-8 -*-
#
#  pyrirc
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
##Config
desc = '''
    Reddit_IRC Bot maintainer script
    '''
ver = '%(prog)s 0.1'
##Imports
import os, sys, argcomplete, shlex, re
from subprocess import *
from argparse import *
##Code

def makeArguments():
    global p
    p = ArgumentParser(formatter_class=RawDescriptionHelpFormatter, description=desc)
    commands = p.add_subparsers(title='Commands', dest='command', description=
    '''
    Commands to change the state of the bot
    ''')
    parser_start = commands.add_parser('start', help=
    '''
    Start the Bot.
    ''')
    p.add_argument('-f', '--file', default=os.path.expanduser('~/reddit_irc.ini'), help=
    '''
    File to read the configuration from. (default: %(default)s)
    ''')
    p.add_argument('--pid-file', default=os.path.expanduser('~/reddit_irc.pid'), dest='pidfile' help=
    '''
    File to write the reddit_irc pid to. (default: %(default)s)
    ''')
    parser_stop = commands.add_parser('stop', help=
    '''
    Stop the Bot.
    ''')
    parser_restart = commands.add_parser('restart', help=
    '''
    Restart the Bot.
    ''')
    parser_edit = commands.add_parser('edit', help=
    '''
    Edit the program.
    ''')
    parser_edit.add_argument('-e', '--editor', dest='editor', default='vi', help=
    '''
    Pick editor to use. (default: %(default)s)
    ''')
    p.add_argument('-v', '--version', action='version', version=ver)
    argcomplete.autocomplete(p)
    global args
    args = p.parse_args()
def main():
    if args.command == 'edit':
        if args.editor:
            print args
    if args.command == 'start':
        if args.file:
            file = args.file
            os.system('screen -dmS reddit_irc-screen reddit_irc %s' % (file))
            a = shlex.split('pidof -x reddit_irc')
            p = Popen(a, stdout=PIPE, stderr=PIPE, stdin=open(os.devnull))
            result = p.communicate()
            print result
            os.system('echo "%s" > ~/reddit_irc.pid' % (result))
    if args.command == 'stop':
        a = shlex.split('pidof -x reddit_irc')
        p = Popen(a, stdout=PIPE, stderr=PIPE, stdin=open(os.devnull))
        pid = p.communicate()
        os.system('kill %s' % (pid))
        try:
            os.system('rm ~/reddit_irc.pid')
        except IOError:
            pass

    if args.command == 'restart':
        if os.path.exists('~/reddit_irc.pid') or os.system('pidof -x reddit_irc'):
            pid = os.system('pidof -x reddit_irc')
            os.system('kill %s' % (pid))
        pidfile = args.pidfile
        os.system('screen -dmS reddit_irc-screen reddit_irc %s' % (file))
        pid = os.system('pidof -x reddit_irc')
        os.system('echo "%s" > %s' % (pid, pidfile))
if __name__ == '__main__':
    makeArguments()
    main()
