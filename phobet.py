#! /usr/bin/python
# -*- coding: utf-8 -*-
#
#  phobet
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

from __future__ import print_function
import sys
import string
bet = {
    'A': 'Alpha',
    'C': 'Charlie',
    'B': 'Bravo',
    'E': 'Echo',
    'D': 'Delta',
    'G': 'Gulf',
    'F': 'Foxtrot',
    'I': 'India',
    'H': 'Hotel',
    'K': 'Kilo',
    'J': 'Juliet',
    'M': 'Mike',
    'L': 'Lima',
    'O': 'Oscar',
    'N': 'November',
    'Q': 'Quebec',
    'P': 'Papa',
    'S': 'Sierra',
    'R': 'Romeo',
    'U': 'Uniform',
    'T': 'Tango',
    'W': 'Whiskey',
    'V': 'Victor',
    'Y': 'Yankee',
    'X': 'X-Ray',
    'Z': 'Zulu',
}
#print sys.argv[1]
words = sys.argv[1:]
characters = ' '.join(words)
print(characters)
for i, c in enumerate(characters):
    if c == ' ':
        print('/', end='')
    elif c in string.letters:
        if characters[i+1] == ',':
            print(bet[c.upper()], end='')
        else:
            print(bet[c.upper()]+'', sep=" ", end="")
    elif c in string.punctuation:
        print(c, end='')
