-- get the titles of columns
.header on
-- see cleaner results
.mode column
-- see execution time
.timer on
-- enforce foreign keys
PRAGMA foreign_keys = ON;
-- print command along with result. Too bad this prints comments too...
.echo on

-- See everything
SELECT item.name, tag.name
FROM item
    JOIN item_tag ON item.id = item_tag.item_id
    JOIN tag ON item_tag.tag_id = tag.id
;

-- Not sure if this is the best way to do this
-- Collect everythign with one of those tags and the count of tags collected
-- filter by the count of tags collected == the count of tags searched

-- country ^ rock
SELECT item.name
FROM item
    JOIN item_tag ON item.id = item_tag.item_id
    JOIN tag ON item_tag.tag_id = tag.id
WHERE
    tag.name = 'country' OR tag.name = 'rock'
GROUP BY item.name
HAVING count(item.name) = 2
;

