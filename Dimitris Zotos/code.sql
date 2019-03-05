SELECT 
COUNT(DISTINCT(utm_campaign))  AS "Num of Campaigns"
FROM page_visits;


SELECT 
COUNT(DISTINCT(utm_source))  AS "Num of Sources"
FROM page_visits;


SELECT 
utm_source, utm_campaign
FROM page_visits
GROUP BY 2;

SELECT 
DISTINCT(page_name) AS Pages
FROM page_visits;

 WITH first_touch AS (
  SELECT
    user_id,
    MIN(timestamp) AS first_touch_at
  FROM
    page_visits
  GROUP BY
    user_id),
  ft_attr AS (
  SELECT
    ft.user_id,
    ft.first_touch_at,
    pv.utm_source,
    pv.utm_campaign
  FROM
    first_touch ft
  JOIN
    page_visits pv
  ON
    ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp )
SELECT
  ft_attr.utm_campaign AS "Campaigns",
  COUNT(*) AS "Num of First Touches"
FROM
  ft_attr
GROUP BY
  1
ORDER BY
  2 DESC;

  SELECT
    user_id,
    MAX(timestamp) AS last_touch_at
  FROM
    page_visits
  GROUP BY
    user_id),
  lt_attr AS (
  SELECT
    lt.user_id,
    lt.last_touch_at,
    pv.utm_source,
    pv.utm_campaign
  FROM
    last_touch lt
  JOIN
    page_visits pv
  ON
    lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp )
SELECT
  lt_attr.utm_campaign AS "Campaigns",
  COUNT(*) AS "Num of Last Touches"
FROM
  lt_attr
GROUP BY
  1
ORDER BY
  2 DESC;

SELECT
  COUNT(DISTINCT(user_id)) AS "Users who Purchased"
FROM
  page_visits
WHERE
  page_name = "4 - purchase";

 WITH last_touch AS (
  SELECT
    user_id,
    MAX(timestamp) AS last_touch_at
  FROM
    page_visits
  WHERE
    page_name = "4 - purchase"
  GROUP BY
    user_id),
  lt_attr AS (
  SELECT
    lt.user_id,
    lt.last_touch_at,
    pv.utm_source,
    pv.utm_campaign
  FROM
    last_touch lt
  JOIN
    page_visits pv
  ON
    lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp )
SELECT
  lt_attr.utm_campaign AS "Campaigns",
  COUNT(*) AS "Num of Last Touches"
FROM
  lt_attr
GROUP BY
  1
ORDER BY
  2 DESC;


SELECT
  DISTINCT page_name
FROM
  page_visits
ORDER BY
  timestamp ASC;


SELECT
  DISTINCT utm_campaign AS "Top 5 Campaigns"
FROM
  page_visits
WHERE
  page_name = "4 - purchase"
ORDER BY
  1 DESC
LIMIT
  5;

