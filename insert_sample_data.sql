-- Enforce foreign keys
PRAGMA foreign_keys = 1;

INSERT INTO item (id, name) VALUES (0, 'item-0');
INSERT INTO item (id, name) VALUES (1, 'item-1');
INSERT INTO item (id, name) VALUES (2, 'item-2');
INSERT INTO item (id, name) VALUES (3, 'item-3');
INSERT INTO item (id, name) VALUES (4, 'item-4');

INSERT INTO tag (id, name) VALUES (0, 'country');
INSERT INTO tag (id, name) VALUES (1, 'rock');
INSERT INTO tag (id, name) VALUES (2, 'rap');

-- Add country tag to some
INSERT INTO item_tag (item_id, tag_id) VALUES (0, 0);
INSERT INTO item_tag (item_id, tag_id) VALUES (2, 0);
INSERT INTO item_tag (item_id, tag_id) VALUES (3, 0);

-- Add rock tag to some
INSERT INTO item_tag (item_id, tag_id) VALUES (1, 1);
INSERT INTO item_tag (item_id, tag_id) VALUES (2, 1);

-- Add the rap tag
INSERT INTO item_tag (item_id, tag_id) VALUES (4, 2);
INSERT INTO item_tag (item_id, tag_id) VALUES (3, 2);
