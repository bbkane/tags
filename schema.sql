
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
