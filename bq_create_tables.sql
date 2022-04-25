CREATE SCHEMA IF NOT EXISTS raw_mapping;
CREATE SCHEMA IF NOT EXISTS raw_sales;
CREATE SCHEMA IF NOT EXISTS raw_users;

DROP TABLE IF EXISTS raw_mapping.product;
DROP TABLE IF EXISTS raw_mapping.country;
DROP TABLE IF EXISTS raw_mapping.city;
DROP TABLE IF EXISTS raw_mapping.store;
DROP TABLE IF EXISTS raw_users.users;
DROP TABLE IF EXISTS raw_mapping.status_name;
DROP TABLE IF EXISTS raw_sales.sale;
DROP TABLE IF EXISTS raw_sales.order_status;

-- Creation of product table
CREATE TABLE IF NOT EXISTS raw_mapping.product (
  product_id INT NOT NULL,
  name string(250) NOT NULL,
);

-- Creation of country table
CREATE TABLE IF NOT EXISTS raw_mapping.country (
  country_id INT NOT NULL,
  country_name string(450) NOT NULL,
);

-- Creation of city table
CREATE TABLE IF NOT EXISTS raw_mapping.city (
  city_id INT NOT NULL,
  city_name string(450) NOT NULL,
  country_id INT NOT NULL,
);

-- Creation of store table
CREATE TABLE IF NOT EXISTS raw_mapping.store (
  store_id INT NOT NULL,
  name string(250) NOT NULL,
  city_id INT NOT NULL,
);

-- Creation of user table
CREATE TABLE IF NOT EXISTS raw_users.users (
  user_id INT NOT NULL,
  name string(250) NOT NULL,
);

-- Creation of status_name table
CREATE TABLE IF NOT EXISTS raw_mapping.status_name (
  status_name_id INT NOT NULL,
  status_name string(450) NOT NULL,
);

-- Creation of sale table
CREATE TABLE IF NOT EXISTS raw_sales.sale (
  sale_id string(200) NOT NULL,
  amount DECIMAL(20,3) NOT NULL,
  date_sale TIMESTAMP,
  product_id INT NOT NULL,
  user_id INT NOT NULL,
  store_id INT NOT NULL,
);

-- Creation of order_status table
CREATE TABLE IF NOT EXISTS raw_sales.order_status (
  order_status_id string(200) NOT NULL,
  update_at TIMESTAMP,
  sale_id string(200) NOT NULL,
  status_name_id INT NOT NULL,
);