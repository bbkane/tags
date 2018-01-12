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

-- Lets see if we can use the new view to simplify tag queries
SELECT *
FROM item_tag_list;

-- Okay, start the real work

.exit
-- To make this simple, lets just get one tag at a time then use UNION ALL (|)
-- and EXCEPT (-) and INTERSECTION (&) to combine them

-- country & rock

    SELECT DISTINCT item.name
    FROM item
        JOIN item_tag ON item.id = item_tag.item_id
        JOIN tag ON item_tag.tag_id = tag.id
    WHERE
        tag.name = 'country'
INTERSECT
    SELECT DISTINCT item.name
    FROM item
        JOIN item_tag ON item.id = item_tag.item_id
        JOIN tag ON item_tag.tag_id = tag.id
    WHERE
        tag.name = 'rock'
;

-- ~ rap
SELECT DISTINCT item.name
FROM item
    JOIN item_tag ON item.id = item_tag.item_id
    JOIN tag ON item_tag.tag_id = tag.id
WHERE
    tag.name != 'rap'
;

-- I'm going to need nested subqueries for this, which meas I need to put them in the WHERE clause
-- ~ (rap | country)
    SELECT DISTINCT item.name
    FROM item
EXCEPT
    SELECT item.name
    FROM item
        JOIN item_tag ON item.id = item_tag.item_id
        JOIN tag ON item_tag.tag_id = tag.id
    WHERE
        tag.name = 'rap' OR tag.name = 'country'
;

-- country - rock == country ^ ~ rock
    SELECT DISTINCT item.name
    FROM item
        JOIN item_tag ON item.id = item_tag.item_id
        JOIN tag ON item_tag.tag_id = tag.id
    WHERE
        tag.name = 'country'
EXCEPT
    SELECT DISTINCT item.name
    FROM item
        JOIN item_tag ON item.id = item_tag.item_id
        JOIN tag ON item_tag.tag_id = tag.id
    WHERE
        tag.name = 'rock'
;


-- These are the optimized but not really combinable ones

-- Not sure if this is the best way to do this
-- Collect everythign with one of those tags and the count of tags collected
-- filter by the count of tags collected == the count of tags searched

-- country & rock
SELECT item.name
FROM item
    JOIN item_tag ON item.id = item_tag.item_id
    JOIN tag ON item_tag.tag_id = tag.id
WHERE
    tag.name = 'country' OR tag.name = 'rock'
GROUP BY item.name
HAVING count(item.name) = 2
;

-- country | rock
SELECT DISTINCT item.name
FROM item
    JOIN item_tag ON item.id = item_tag.item_id
    JOIN tag ON item_tag.tag_id = tag.id
WHERE
    tag.name = 'country' OR tag.name = 'rock'
;

-- ~ (rap | country)
    SELECT DISTINCT item.name
    FROM item
EXCEPT
    SELECT item.name
    FROM item
        JOIN item_tag ON item.id = item_tag.item_id
        JOIN tag ON item_tag.tag_id = tag.id
    WHERE
        tag.name = 'rap' OR tag.name = 'country'
;

-- country | rock

    SELECT DISTINCT item.name
    FROM item
        JOIN item_tag ON item.id = item_tag.item_id
        JOIN tag ON item_tag.tag_id = tag.id
    WHERE
        tag.name = 'country'
UNION ALL
    SELECT DISTINCT item.name
    FROM item
        JOIN item_tag ON item.id = item_tag.item_id
        JOIN tag ON item_tag.tag_id = tag.id
    WHERE
        tag.name = 'rock'
;
