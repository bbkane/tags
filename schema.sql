
-- https://sqlite.org/autoinc.html says I don't need autoincrement
CREATE TABLE item (
    id integer PRIMARY KEY,
    name text NOT NULL,
    UNIQUE (name)
);


CREATE TABLE tag (
    id integer PRIMARY KEY,
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

CREATE VIEW item_tag_list AS
SELECT
    item.id as item_id,
    item.name as item_name,
    tag.id as tag_id,
    tag.name as tag_name
FROM item
    JOIN item_tag ON item.id = item_tag.item_id
    JOIN tag ON item_tag.tag_id = tag.id;
