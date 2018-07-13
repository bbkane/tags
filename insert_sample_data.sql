-- Enforce foreign keys
PRAGMA foreign_keys = 1;


-- So I get a name and a list of tags.
-- Idempotently upsert into name (updating updated_at)
-- idempotenly insert into tags
-- link them together

-- DATA:
-- ia - ta
-- iac - ta tc
-- iabc - ta tb tc

-- TODO: Worry about mutating tags later...

BEGIN TRANSACTION;

-- file:///Users/bbkane/Documents/sqlite-doc-3240000/lang_datefunc.html - now is always utc
UPDATE item SET updated_at=datetime('now') WHERE name='ia';
INSERT OR IGNORE INTO item(name, created_at, updated_at) VALUES ('ia', datetime('now'), datetime('now'));

-- Not sure about last_inserted_rowid (especially idempotently) so I'm going to just do inline selects.

INSERT OR IGNORE INTO tag(name) VALUES ('ta');

INSERT OR IGNORE INTO item_tag(item_id, tag_id) VALUES (
    (SELECT id FROM item WHERE name = 'ia'),
    (SELECT id FROM tag WHERE name = 'ta')
);

END TRANSACTION;

