
-- I don't know the best way to do this so here we go!
-- Problems with this:
-- - Probably inefficient (stringly typed)
-- - requires separating character
CREATE VIEW page_tag_list AS
SELECT
    page.id as page_id,
    page.name as page_name,
    group_concat(tag.name, " ") as tags -- " " isn't allowed in tags
FROM page
    JOIN page_tag ON page.id = page_tag.page_id
    JOIN tag ON page_tag.tag_id = tag.id
GROUP BY page_id;
