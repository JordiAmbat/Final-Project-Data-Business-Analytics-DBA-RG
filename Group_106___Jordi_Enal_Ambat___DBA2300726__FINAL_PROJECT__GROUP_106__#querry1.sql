-- FINAL PROJECT | GROUP 106 | JORDI ENAL AMBAT | 19101106021
--- MAKING NEW TABLE(SUB DATA SET)
--- PRODUCT
SELECT *
FROM public.events 
FULL OUTER JOIN public.users 
ON events.user_id = users.user_id
WHERE id is NULL

SELECT Count(events.traffic_source)
FROM public.events 
FULL OUTER JOIN public.users 
ON events.user_id = users.user_id

SELECT Count(users.traffic_source)
FROM public.events 
FULL OUTER JOIN public.users 
ON events.user_id = users.user_id

SELECT first_name,last_name,events.traffic_source,users.traffic_source
FROM public.events
FULL OUTER JOIN public.users 
ON events.user_id = users.user_id
WHERE events.traffic_source is NULL

Update events 
SET traffic_source = users.traffic_source
FROM users
WHERE events.user_id = users.user_id
AND events.traffic_source is NULL

SELECT * FROM public.distribution_centers 
SELECT * FROM users WHERE street_address is NULL
SELECT * FROM events

--- DigitalProduct
SELECT 
	COUNT((users.user_id, session_id, sequence_number, users.traffic_source, browser, event_type)),
	COUNT(DISTINCT(users.user_id, session_id, sequence_number, users.traffic_source, browser, event_type))
FROM public.users
FULL JOIN public.events
ON users.user_id = events.user_id

CREATE TABLE digitalproduct AS
(
	SELECT users.user_id, session_id, sequence_number, users.traffic_source, browser, event_type, url 
	FROM public.users
	FULL JOIN public.events
	ON users.user_id = events.user_id
)
------ Making new table to show the most feature have used
SELECT users.user_id, session_id, sequence_number, users.traffic_source, browser, event_type
FROM public.users
FULL JOIN public.events
ON users.user_id = events.user_id
--------------------------------------------------------

--------------------------------------------------------



------ Making new table about cost and price
SELECT inventory_items.product_id, products.product_id, inventory_items.cost, products.retail_price,inventory_items.product_retail_price, products.cost
FROM public.inventory_items
FULL JOIN public.products
ON public.inventory_items.product_id = public.products.product_id

CREATE TABLE price AS
(
	SELECT inventory_items.product_id, products.retail_price, products.cost
	FROM public.inventory_items
	FULL JOIN public.products
	ON public.inventory_items.product_id = public.products.product_id
)

SELECT * FROM price

CREATE TABLE _pricecost AS
(
	SELECT price.product_id, price.retail_price, price.cost, order_items.sale_price
	FROM public.price
	FULL JOIN public.order_items
	ON public.price.product_id = public.order_items.product_id
)

SELECT * FROM _pricecost

------ Making new table about product timeline
CREATE TABLE timeline AS
(
	SELECT 
		products.product_id, products.name, products.category, products.brand, products.department,
		order_items.created_at, order_items.shipped_at, order_items.delivered_at, order_items.returned_at
	FROM 
		public.products 
	FULL JOIN
		public.order_items
	ON
		order_items.product_id = products.product_id
)
-------------------2------------------------
CREATE TABLE _prodtl AS 
(
	SELECT
		timeline.*, inventory_items.sold_at
	FROM 
		public.timeline
	FULL JOIN
		public.inventory_items
	ON
		inventory_items.product_id = timeline.product_id
)

------ Making new table about user detail
CREATE TABLE _detailuser AS
(
SELECT 
	users.user_id, users.first_name || ' ' || users.last_name AS fullname, users.age, users.gender,
	users.street_address,users.postal_code,users.city,users.state,users.country,
	order_items.created_at, order_items.delivered_at
FROM
	users
FULL JOIN
	order_items
ON
	users.user_id = order_items.user_id
)

SELECT * FROM detailuser
------------------------------------------------------------------------------
----- Check Missing Value 
SELECT *
FROM public.events 
FULL OUTER JOIN public.users 
ON events.user_id = users.user_id
WHERE id is NULL

SELECT COUNT (*)
FROM public.events 
FULL OUTER JOIN public.users 
ON events.user_id = users.user_id
WHERE id is NULL

SELECT Count(events.traffic_source)
FROM public.events 
FULL OUTER JOIN public.users 
ON events.user_id = users.user_id

SELECT Count(users.traffic_source)
FROM public.events 
FULL OUTER JOIN public.users 
ON events.user_id = users.user_id

SELECT first_name,last_name,events.traffic_source,users.traffic_source
FROM public.events
FULL OUTER JOIN public.users 
ON events.user_id = users.user_id
WHERE events.traffic_source is NULL

Update events 
SET traffic_source = users.traffic_source
FROM users
WHERE events.user_id = users.user_id
AND events.traffic_source is NULL

SELECT * FROM public.distribution_centers 
SELECT * FROM users WHERE street_address is NULL
SELECT * FROM events