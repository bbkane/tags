
-- https://sqlite.org/autoinc.html says I don't need autoincrement
CREATE TABLE item (
    id integer PRIMARY KEY NOT NULL,
    name text NOT NULL,
    -- file:///Users/bbkane/Documents/sqlite-doc-3240000/datatype3.html
    -- Why I'm using TEXT for timestamps
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL,
    UNIQUE (name)
);


CREATE TABLE tag (
    id integer PRIMARY KEY NOT NULL,
    name text NOT NULL,
    UNIQUE (name)
);

CREATE TABLE item_tag (
    tag_id integer NOT NULL,
    item_id integer NOT NULL,
    FOREIGN KEY (tag_id) REFERENCES tag(id) ON DELETE CASCADE,
    FOREIGN KEY (item_id) REFERENCES item(id) ON DELETE CASCADE,
    PRIMARY KEY (tag_id, item_id)
);

-- I don't know the best way to do this so here we go!
-- Problems with this:
-- - Probably inefficient (stringly typed)
-- - requires marker character
CREATE VIEW item_joined_tags AS
SELECT
    item.id as item_id,
    item.name as item_name,
    group_concat(tag.name, ",") as tags
FROM item
    JOIN item_tag ON item.id = item_tag.item_id
    JOIN tag ON item_tag.tag_id = tag.id
GROUP BY item_id;
