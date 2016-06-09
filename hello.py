#! /usr/bin/env python3
#Title: hello.py
import argparse
import sys

langs = {
    "en": ["English", "Hello World!"],
    "sr-la": ["Serbian - Latin", "zdravo svet"],
    "sr-cy": ["Serbian - Cyrillic", "ждраво свет!"],
    "es": ["Spanish", "¡Hola Mundo!"],
    "jp-ro": ["Romanized Japanese", "Sekai kon'nichiwa!"],
    "jp": ["Japanese", "世界こんにちは！"],
    "fr": ["French", "Bonjour Monde!"],
    "nl": ["Dutch", "Hallo Wereld!"],
    "de": ["German", "Hallo Welt!"],
}
def arguments():
    global p
    p = argparse.ArgumentParser(description="Small script for saying hello in different languages")
    p.add_argument('--lang', action="store", dest="LANG", help="Language in which you want to receive \"Hello World!\"")
    global args
    args = p.parse_args()
def main():
    if not args.LANG:
        p.print_help()
        print("Languages:")
        print("    Code:     Language:")
        for (k,v) in iter(langs.items()):
            if len(k) == 5:
                print("    %s     %s" % (k,v[0]))
            elif len(k) == 2:
                print("    %s        %s" % (k,v[0]))
    if args.LANG:
        print(langs.get(args.LANG)[1])

if __name__ == "__main__":
    arguments()
    main()
