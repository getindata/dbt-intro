-- Set params
declare number_of_sales default 100;
declare number_of_users default 100;
declare number_of_products default 100;
declare number_of_stores default 100;
declare number_of_coutries default 100;
declare number_of_cities default 30;
declare status_names default 5;
declare start_date default '2019-01-01 00:00:00';
declare end_date default '2020-02-01 00:00:00';

CREATE TEMP FUNCTION rand_range(min_value INT64, max_value INT64) AS (
  CAST(ROUND(min_value + rand() * (max_value - min_value)) AS INT64)
);

CREATE TEMP FUNCTION rand_date(min_date DATE,max_date DATE) AS (
  TIMESTAMP_SECONDS(
    rand_range(UNIX_SECONDS(CAST(min_date AS TIMESTAMP)), UNIX_SECONDS(CAST(max_date AS TIMESTAMP)))
  )
);

-- Filling of products
INSERT INTO raw_mapping.product
select id, concat('Product ', id)
FROM UNNEST(GENERATE_ARRAY(1, cast(number_of_products as int))) as id;

-- Filling of countries
INSERT INTO raw_mapping.country
select id, concat('Country ', id)
FROM UNNEST(GENERATE_ARRAY(1, number_of_coutries)) as id;

-- Filling of cities
INSERT INTO raw_mapping.city
select id
	, concat('City ', id)
	, cast(floor(cast(rand() as int) * (number_of_coutries) + 1) as int)
FROM UNNEST(GENERATE_ARRAY(1, number_of_cities)) as id;

-- Filling of stores
INSERT INTO raw_mapping.store
select id
	, concat('Store ', id)
	, cast(floor(cast(rand() as int) * (number_of_cities) + 1) as int)
FROM UNNEST(GENERATE_ARRAY(1, number_of_stores)) as id;

-- Filling of users
INSERT INTO raw_users.users
select id
	, concat('User ', id)
FROM UNNEST(GENERATE_ARRAY(1, number_of_users)) as id;

-- Filling of users
INSERT INTO raw_mapping.status_name
select status_name_id
	, concat('Status Name ', status_name_id)
FROM UNNEST(GENERATE_ARRAY(1, status_names)) as status_name_id;

-- Filling of sales
INSERT INTO raw_sales.sale
select GENERATE_UUID()
	, round(CAST((rand() * 10000) as numeric), 3)
	, CAST(rand_date("2020-01-01", "2022-04-26") AS timestamp)
	, cast(floor(rand() * (number_of_products) + 1) as int)
	, cast(floor(rand() * (number_of_users) + 1) as int)
	, cast(floor(rand() * (number_of_stores) + 1) as int)
FROM UNNEST(GENERATE_ARRAY(1, number_of_sales)) as id;

-- Filling of order_status
INSERT INTO raw_sales.order_status
select GENERATE_UUID()
    , timestamp_add(date_sale, INTERVAL 1 DAY)
	, sale_id
	, cast (floor(rand() * (status_names) + 1) as int)
from raw_sales.sale;