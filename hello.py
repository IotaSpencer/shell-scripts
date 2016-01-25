#! /usr/bin/env python3
#Title: hello.py
import argparse
import sys

def arguments():
    global p
    p = argparse.ArgumentParser(description="Small script for saying hello in different languages")
    p.add_argument('--lang', action="store", dest="LANG", help="Language in which you want to receive \"Hello World!\"")
    global args
    args = p.parse_args()
def main():
    if not args.LANG:
        p.print_help()
    if args.LANG:
        dict = {
        "en": "Hello World!",
        "sr-la": "zdravo svet",
        "sr-cy": "ждраво свет!",
        "es": "¡Hola Mundo!",
        "jp-ro": "Sekai kon'nichiwa!",
        "jp": "世界こんにちは！",
    }
        print(dict.get(args.LANG))

if __name__ == "__main__":
    arguments()
    main()

