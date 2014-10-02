ALTER TABLE my_tables.anh_gov_to_dis
ADD INDEX (event_id),
ADD INDEX (event_date),
ADD INDEX (goldstein),
ADD INDEX (source_country_id),
ADD INDEX (target_actor_id);

DROP TABLE IF EXISTS my_tables.anh_gov_to_dis_count;
CREATE TABLE IF NOT EXISTS my_tables.anh_gov_to_dis_count AS (
SELECT i.*
  , aTargetInfo.name AS target_actor_name
  , cSourceInfo.Name AS source_country_name
  , cSourceInfo.ISOA3Code AS source_country_ISOA3Code
  , csourceInfo.COWCode AS source_country_COWCode
  , cSourcedd.democracy AS source_country_democracy
FROM
(SELECT target_actor_id
  , target_sector_id
  , source_country_id
  , YEAR(event_date) as year
  , AVG(goldstein) as goldstein_avg
FROM
  my_tables.anh_gov_to_dis
GROUP BY YEAR(event_date), source_country_id, target_actor_id) i
JOIN event_data.countries AS cSourceInfo
  ON i.source_country_id = cSourceInfo.id
JOIN event_data.dict_actors AS aTargetInfo
  ON i.target_actor_id = aTargetInfo.actor_id
JOIN my_tables.anh_dd_revisited AS cSourcedd
  ON cSourceInfo.COWCode = cSourcedd.cowcode AND
     i.year = YEAR(cSourcedd.year)
);