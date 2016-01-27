#!/usr/bin/env python2.7
# PYTHON_ARGCOMPLETE_OK
# -*- coding: utf-8 -*-
#
#  pygit
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
###################################################################


# TODO:
# Possibly make a subparser..
import subprocess, os, sys
from argcomplete import *
from GitPython import *
from github import *
from argparse import *
from configparser import *

def makeArguments():
    p = ArgumentParser(formatter_class=RawDescriptionHelpFormatter, description=
    """
    Python Git script. I'll think of a better description later
    """)
    git = p.add_argument_group('Git',
    """
    Command line usage of Git
    """)
    github = p.add_argument_group('GitHub',
    """
    Command line usage of GitHub
    """)
    usual = p.add_argument_group('Usual',
    """
    Usual commands that I add when I make scripts.
    """)
    indie = p.add_argument_group('Independent',
    """
    Commands that are independent of the rest of the groups.
    """)
    git.add_argument('-a', action='store_true', dest='add', help=
    """
    Add a file to the index.
    """)
    git.add_argument('-c', action='store_true', dest='commit', help=
    """
    Commit changes to branch
    """)
    git.add_argument('-p', action='store_true', dest='push', help=
    """
    Push your changes to your git server (github/bb/'w/e')
    """)
    usual.add_argument('-v', '--version', action='version', version="0.0.1")
    usual.add_argument('-e', '--edit', action='store_true', dest='edit' help=
    """
    Edit the script.
    """)
    indie.add_argument('-cp', '--config-path', action='store', default=os.path.expanduser(~/git.ini), dest='config_path', help=
    """
    Configuration Path to use
    (default: %(default)s)
    """)
def makeConfig():
    global config
    config = ConfigParser()
    config.read('%s' % (args.config_path))
def main():

if __name__ == "__main__":
    makeArguments()
    makeConfig()
    main()


