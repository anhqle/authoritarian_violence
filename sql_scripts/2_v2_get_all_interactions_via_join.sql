DROP TABLE IF EXISTS my_tables.anh_dis_to_gov;
CREATE TABLE IF NOT EXISTS my_tables.anh_dis_to_gov AS (
SELECT e.*
  , d.sector_id AS source_sector_id
  , d.name AS source_sector_name
  , g.sector_id AS target_sector_id
  , g.name AS target_sector_name
FROM event_data.simple_events AS e
  # dissident do something to government
  JOIN my_tables.anh_dissidentList AS d
	ON e.source_actor_id = d.actor_id
  JOIN my_tables.anh_governmentList AS g
	ON e.target_actor_id = g.actor_id
WHERE e.event_date BETWEEN d.start_date AND d.end_date
  AND e.event_date BETWEEN g.start_date AND g.end_date
);
  
DROP TABLE IF EXISTS my_tables.anh_gov_to_dis;
CREATE TABLE IF NOT EXISTS my_tables.anh_gov_to_dis AS (
SELECT e.*
  , g.sector_id AS source_sector_id
  , g.name AS source_sector_name
  , d.sector_id AS target_sector_id
  , d.name AS target_sector_name
FROM event_data.simple_events AS e
  # government does something to the dissident
  JOIN my_tables.anh_governmentList AS g
	ON e.source_actor_id = g.actor_id
  JOIN my_tables.anh_dissidentList AS d
	ON e.source_actor_id = d.actor_id
WHERE e.event_date BETWEEN d.start_date AND d.end_date
  AND e.event_date BETWEEN g.start_date AND g.end_date
);
  
DROP TABLE IF EXISTS my_tables.anh_dis_to_dis;
CREATE TABLE IF NOT EXISTS my_tables.anh_dis_to_dis AS (
SELECT e.*
  , d1.sector_id AS source_sector_id
  , d1.name AS source_sector_name
  , d2.sector_id AS target_sector_id
  , d2.name AS target_sector_name
FROM event_data.simple_events AS e
  # dissident 1 does something to dissident 2
  JOIN my_tables.anh_dissidentList AS d1
	ON e.source_actor_id = d1.actor_id
  JOIN my_tables.anh_dissidentList AS d2
	ON e.target_actor_id = d2.actor_id
WHERE e.event_date BETWEEN d1.start_date AND d1.end_date
  AND e.event_date BETWEEN d2.start_date AND d2.end_date
);

DROP TABLE IF EXISTS my_tables.anh_gov_to_gov;
CREATE TABLE IF NOT EXISTS my_tables.anh_gov_to_gov AS (
SELECT e.*
  , g1.sector_id AS source_sector_id
  , g1.name AS source_sector_name
  , g2.sector_id AS target_sector_id
  , g2.name AS target_sector_name
FROM event_data.simple_events AS e
  # government 1 does something to government 2
  JOIN my_tables.anh_governmentList AS g1
	ON e.source_actor_id = g1.actor_id
  JOIN my_tables.anh_governmentList AS g2
	ON e.target_actor_id = g2.actor_id
WHERE e.event_date BETWEEN g1.start_date AND g1.end_date
  AND e.event_date BETWEEN g2.start_date AND g2.end_date
);
