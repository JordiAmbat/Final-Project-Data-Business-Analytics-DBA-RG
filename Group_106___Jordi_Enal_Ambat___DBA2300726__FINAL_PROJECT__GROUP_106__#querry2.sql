-- FINAL PROJECT | GROUP 106 | JORDI ENAL AMBAT | 19101106021
--- IDENTIFY DATASET, MAKING TABEL FOR STATISTICS ANALYTICS
---- PRODUCT
----- CREATED MAIN TABLES
CREATE TABLE public.digitalproduct
(
	user_id varchar
	,session_id varchar
	,sequence_number float
	,traffic_source text
	,browser text
	,event_type text
	,url varchar
)

CREATE TABLE public.productd
(
	user_id varchar
	,session_id varchar
	,sequence_number float
	,traffic_source text
	,browser text
	,event_type text
)

CREATE TABLE public._detailuser
(
	user_id varchar,
	fullname text,
	age smallint,
	gender text,
	street_address varchar,
	postal_code varchar,
	city text,
	state text,
	country text,
	created_at timestamp,
	delivered_at timestamp
)

CREATE TABLE public._pricecost 
(
	product_id varchar,
	retail_price float,
	cost float,
	sale_price float
)

CREATE TABLE public._prodtl
(
	product_id varchar,
	name text,
	category text,
	brand varchar,
	department text,
	created_at timestamp,
	shipped_at timestamp,
	delivered_at timestamp,
	returned_at timestamp,
	sold_at timestamp
);

ALTER TABLE IF EXISTS public.productd
    OWNER to postgres;
-----------------------------------------------------------------------------------------------------------
--_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_---
-------------------------------Creted _detailuser sub table-------------------------------------------------------
SELECT * FROM _detailuser

-------- Check Null Items
SELECT
	* 
FROM 
	_detailuser
WHERE 
		user_id IS NULL
	OR	fullname IS NULL
	OR	age IS NULL
	OR	gender IS NULL
	OR	street_address IS NULL
	OR	postal_code IS NULL
	OR	city IS NULL
	OR	state IS NULL
	OR	country IS NULL
--------------------------------
-----------------------------------------------------------------------------------------------------------
-------------------------------Creted _pricecost sub table-------------------------------------------------------
-------- Check Null Items
SELECT 
	*
FROM 
	_pricecost
WHERE
		product_id IS NULL
	OR	retail_price IS NULL
	OR	cost IS NULL
	OR	sale_price IS NULL
	
DELETE 
FROM 
	_pricecost
WHERE
		product_id IS NULL
	OR	retail_price IS NULL
	OR	cost IS NULL
	OR	sale_price IS NULL
-----------------------------------------------------------------
CREATE TABLE pricecostdesc 
(
	retail_price float,
	cost float,
	sale_price float
)

INSERT INTO pricecostdesc(retail_price, cost, sale_price) 
VALUES
(ROUND(SUM(_pricecost.retail_price)),ROUND(SUM(_pricecost.cost)),ROUND(SUM(_pricecost.sale_price))),
(ROUND(AVG(_pricecost.retail_price)),ROUND(AVG(_pricecost.cost)),ROUND(AVG(_pricecost.sale_price))),
(ROUND(MAX(_pricecost.retail_price)),ROUND(MAX(_pricecost.cost)),ROUND(MAX(_pricecost.sale_price))),
(ROUND(MIN(_pricecost.retail_price)),ROUND(MIN(_pricecost.cost)),ROUND(MIN(_pricecost.sale_price)))
FROM _pricecost
-----------------------------------------------------------------------------------------------------------
--SELECT ROUND(SUM(retail_price)) as RetailPrice, ROUND(SUM(cost)) as Cost, ROUND(SUM(sale_price)) as SalePrice
-------------------------------Creted _prodtl sub table-------------------------------------------------------
-------- Check Null Items
SELECT 
	COUNT(*) 
FROM 
	_prodtl
WHERE
		product_id IS NULL
	OR	name IS NULL
	OR	category IS NULL
	OR	brand IS NULL
	OR	department IS NULL

DELETE 
FROM 
	_prodtl
WHERE
		product_id IS NULL
	OR	name IS NULL
	OR	category IS NULL
	OR	brand IS NULL
	OR	department IS NULL
-----------------------------------------
SELECT * FROM public._productd
-----------------------------------------------------------------------------------------------------------


--------------------------Creted _productd sub table-------------------------------------------------------
CREATE TABLE traffic as
(
	SELECT traffic_source, COUNT(session_id) as session, COUNT(sequence_number)as sequence
	FROM public._productd
	GROUP BY traffic_source
)

SELECT * FROM traffic

CREATE TABLE browser as 
(	
	SELECT browser, COUNT(session_id) as session, COUNT(sequence_number)as sequence
	FROM public._productd
	GROUP BY browser
)
	
CREATE TABLE event_type as
(
	SELECT event_type, COUNT(session_id) as session, COUNT(sequence_number)as sequence
	FROM public._productd
	GROUP BY event_type
)

CREATE TABLE url as
(
	SELECT url, COUNT(session_id) as session, COUNT(sequence_number)as sequence
	FROM public.digitalproduct
	GROUP BY url
)	
	















