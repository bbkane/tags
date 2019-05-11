# Tags

NOTE (2019-05-10): see taggedmarks instead.

This is a toy project to experiment with a tag-based system

http://web.archive.org/web/20150813211028/http://tagging.pui.ch/post/37027745720/tags-database-schemas

Basically covers everything I have been trying to do...

# Install

TODO: make this a real python module and such

For now, I'm just using the following command to play with it in SQL form

```
rm tags.db && sqlite3 tags.db < schema.sql && sqlite3 tags.db < insert_sample_data.sql
```

# Usage

No Python stuff now, I'm just trying to get some good SQL here

```
sqlite3 tags.db < sample_queries.sql
```

Rebuild the db and run the test on save with the help of the run script!

```
git ls-files | entr -cs 'bash run.sh'
```

# General Ideas

### Query language:

This is a standard set based query language with the following operators
adapted from C's. The following are assumed to be querying items with tags
(though the reverse could also be true).


### Grammar:

A lot of this is taken from https://docs.python.org/3/library/stdtypes.html#set
Note that I'm special-casing the unary "not in set" operator (~)
because it's the only unary operator. TODO: add parens to this

    <expr> = tag | <expr> <op> <expr> | ~ tag
    <op> = & | \|   # The backslash is to escape the pipe (it's an operator)

- `&` denotes set intersection (i.e. the item has all tags separated by it)
- `|` denotes set union (i.e. the item has at least one tag)

TODO: work on precedence rules...

### Examples (assuming, once again, that we're querying the tags on the items)

I need parens here...

- Query: `country & rock`
- Explanation: find all items with the tags country and rock
- Python list expression:

```
[i for i in items if 'country' in i.tags and 'rock' in i.tags]
```

- Query: `country & ~ rock`
- Explanation: find all items with the tags country but no rock
- Python list expression:

```
[i for i in items if 'country' in i.tags and 'rock' not in i.tags]
```

- Query: `country & (rock | blues)`
- Explanation: find all items with the tags country and either a rock or a blues tag (or both)
- Python list expression:

```
[i for i in items if 'country' in i.tags and ('rock' in i.tags or 'blues' in i.tags)]
```

NOTE: could I get all of this just by using SQLAlchemy?

# Schema

paste into https://app.quickdatabasediagrams.com

```
item
-
id PK int
name text

tag
-
id PK int
name text

item_tag
-
tag_id PK int FK >- tag.id
item_id PK int FK >- item.id
```

