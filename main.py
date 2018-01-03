#!/usr/bin/env python
# -*- coding: utf-8 -*-

__author__ = "Benjamin Kane"
__version__ = "0.1.0"

import tags

__doc__ = """
Just playin with tags

This is a thin Python wrapper over a tags database
with a custom set-based query language for fun.

Help:

Please see Benjamin Kane for help.
Code at https://github.com/bbkane/tags
"""


def main():

    # right now this is a theoretical API

    # We could make a fancy staticmethod to create this and connect, but oh well...
    # Also not worrying about idempotence here
    tags.create_library('tags.db')

    library = tags.connect_to_library('tags.db')

    # create some items
    for i in range(3):
        library.add_item(f'item-{i}')

    # Add some tags
    for i in (0, 2, 3):
        item = library.get_item(f'item-{i}')
        item.add_tag('country')

    for i in (1, 3):
        item = library.get_item(f'item-{i}')
        item.add_tag('rock')

    # Now let's query it for some tags!
    for item in library.query_items_by_tag('country ^ rock'):
        print(item)  # should return item-3 cause that's the only one with both tags


if __name__ == "__main__":
    main()
