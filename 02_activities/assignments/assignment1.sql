/* ASSIGNMENT 1 */

/* COMMENTS
In my responses to the questions, I include 
- some additional lines of code that are commented out to help you see my approach to answering the questions.
- my interpretation of the question where I was unsure as to what exactly you were seeking as a response
- some questions that I am hoping you can answer to assist me in my learning
- I answered all the questions, though in one instance I needed a creative workaround!
*/

/* SECTION 1*/

SELECT * FROM vendor_booth_assignments
ORDER BY market_date, vendor_id ASC

--the above used to explore this table to determine the relationship with the vendor table for preparing the logical data model


/* SECTION 2 */

--SELECT
/* 1. Write a query that returns everything in the customer table. */

SELECT * FROM customer

/* 2. Write a query that displays all of the columns and 10 rows from the customer table, 
sorted by customer_last_name, then customer_first_ name. */
-- The question does not indicate which 10 rows, so I will display the first 10 rows prior to sorting (another different set of customers could have been selected by changing the range limit on customer_id
-- The question is also somewhat unclear as to the desired outcome of the name ordering (whether ultimately by first then last or last then first)

SELECT
customer_id, customer_first_name, customer_last_name, customer_postal_code
FROM customer
WHERE customer_id <= 10 -- selects the first 10 rows based on customer ID
ORDER BY customer_last_name, customer_first_name


--WHERE
/* 1. Write a query that returns all customer purchases of product IDs 4 and 9. */
-- option 1
SELECT product_id
FROM  customer_purchases
WHERE product_id = 4 OR product_id = 9

-- option 2
-- SELECT *FROM customer_purchases\
 -- there do not appear to be any products with ID 9, so could just remove that
SELECT product_id
FROM  customer_purchases
WHERE product_id = 4


--option 3
-- another option is to use the BETWEEN operator with decimals
SELECT product_id
FROM  customer_purchases
WHERE product_id BETWEEN 3.9 and 4.1 OR product_id BETWEEN 8.9 AND 9.1


/*2. Write a query that returns all customer purchases and a new calculated column 'price' (quantity * cost_to_customer_per_qty), 
filtered by vendor IDs between 8 and 10 (inclusive) using either:
	1.  two conditions using AND
	2.  one condition using BETWEEN
*/
-- option 1
--SELECT *FROM customer_purchases

SELECT *,
quantity*cost_to_customer_per_qty as price   -- quantity * cost per quantity
FROM customer_purchases
WHERE vendor_id >= 8 AND vendor_ID <= 10

-- option 2
SELECT *,
quantity*cost_to_customer_per_qty as price   -- quantity * cost per quantity
FROM customer_purchases
WHERE vendor_id BETWEEN 8 AND 10


--CASE
/* 1. Products can be sold by the individual unit or by bulk measures like lbs. or oz. 
Using the product table, write a query that outputs the product_id and product_name
columns and add a column called prod_qty_type_condensed that displays the word “unit” 
if the product_qty_type is “unit,” and otherwise displays the word “bulk.” */

--SELECT *FROM product

SELECT product_id, product_name,
CASE WHEN product_qty_type = 'unit'
	THEN 'unit'
	ELSE 'bulk'
	END as prod_qty_type_condensed
FROM product


/* 2. We want to flag all of the different types of pepper products that are sold at the market. 
add a column to the previous query called pepper_flag that outputs a 1 if the product_name 
contains the word “pepper” (regardless of capitalization), and otherwise outputs 0. */

SELECT product_id, product_name,
CASE WHEN product_qty_type = 'unit'
	THEN 'unit'
	ELSE 'bulk'
	END as prod_qty_type_condensed
FROM product
WHERE product_name LIKE '%pepper%'

--JOIN
/* 1. Write a query that INNER JOINs the vendor table to the vendor_booth_assignments table on the 
vendor_id field they both have in common, and sort the result by vendor_name, then market_date. */

--I was not clear which direction the question implies that these should be joined; both versions are below

--SELECT * FROM vendor
--SELECT * FROM vendor_booth_assignments

--Direction 1
SELECT *
FROM vendor AS v -- on the left
INNER JOIN vendor_booth_assignments AS vb -- on the right
	ON v.vendor_id = vb.vendor_id 
ORDER BY vendor_name, market_date ASC;

--Direction 2
SELECT *
FROM vendor_booth_assignments AS vb -- on the left
INNER JOIN vendor AS v -- on the right
ON vb.vendor_id = v.vendor_id 
ORDER BY vendor_name, market_date ASC;


/* SECTION 3 */

-- AGGREGATE
/* 1. Write a query that determines how many times each vendor has rented a booth 
at the farmer’s market by counting the vendor booth assignments per vendor_id. */

-- The question does not appear to require use to specify the vendor booth assignments by booth just the total number of booth rentals


--SELECT * FROM vendor_booth_assignments
--SELECT * FROM vendor

SELECT 
vendor_id,
count(booth_number)
FROM vendor_booth_assignments
WHERE booth_number IS NOT NULL -- remove the NULL rows
GROUP BY vendor_id;


/* 2. The Farmer’s Market Customer Appreciation Committee wants to give a bumper 
sticker to everyone who has ever spent more than $2000 at the market. Write a query that generates a list 
of customers for them to give stickers to, sorted by last name, then first name. 

HINT: This query requires you to join two tables, use an aggregate function, and use the HAVING keyword. */

--SELECT * FROM customer

--SELECT * FROM customer_purchases
--ORDER BY customer_id

-- The common attribute (column) between the above tables is customer_id, so I will join the tables based on that attribute

SELECT *
FROM customer AS c -- on the left
INNER JOIN customer_purchases AS cp -- on the right
	ON c.customer_id = cp.customer_id
ORDER BY customer_last_name, customer_first_name ASC;

-- the above completes the join 
--now, we need to sum the cost_to_customer_per_qty by customer_id
--so, building on the above code...

SELECT *
,SUM(CAST(quantity AS decimal(5,2))*cost_to_customer_per_qty) as total_spent
FROM customer AS c -- on the left
INNER JOIN customer_purchases AS cp -- on the right
	ON c.customer_id = cp.customer_id
GROUP BY cp.customer_id
HAVING (total_spent) > 2000
ORDER BY customer_last_name, customer_first_name ASC



--Temp Table
/* 1. Insert the original vendor table into a temp.new_vendor and then add a 10th vendor: 
Thomass Superfood Store, a Fresh Focused store, owned by Thomas Rosenthal
*/
--SELECT * FROM vendor

-- put a temp table into another one
DROP TABLE IF EXISTS new_vendor;
CREATE TEMP TABLE new_vendor AS
SELECT *
,vendor_id+1 as new_vendor_id --oddly, it will not accept just the comma, so I put in this dummy column and remove it below
FROM vendor;
SELECT * FROM new_vendor

INSERT INTO new_vendor
VALUES (10,'Thomass Superfood Store', 'Fresh Focused', 'Thomas', 'Rosenthal',20);
ALTER TABLE new_vendor
DROP COLUMN new_vendor_id;
SELECT * FROM new_vendor

-- I have no idea why the above does not work without adding in the extra column and then later deleting it!! Some silly syntax error that I cannot decipher.

/*
HINT: This is two total queries -- first create the table from the original, then insert the new 10th vendor. 
When inserting the new vendor, you need to appropriately align the columns to be inserted 
(there are five columns to be inserted, I've given you the details, but not the syntax) 

-> To insert the new row use VALUES, specifying the value you want for each column:
VALUES(col1,col2,col3,col4,col5) 
*/



-- Date
/*1. Get the customer_id, month, and year (in separate columns) of every purchase in the customer_purchases table.
*/
SELECT * FROM customer_purchases

SELECT *,
strftime('%Y', market_date) as year,
strftime('%m', market_date) as month,
strftime('%d', market_date) as day

FROM customer_purchases

-- Wow. The year is not case sensitive (can use Y or y) but the month and day are - what's with that?!?!
--https://stackoverflow.com/questions/650480/get-month-from-datetime-in-sqlite/16395295
--How would I show only those three columns?

/*
HINT: you might need to search for strfrtime modifers sqlite on the web to know what the modifers for month 
and year are! */


/* 2. Using the previous query as a base, determine how much money each customer spent in April 2022. 
Remember that money spent is quantity*cost_to_customer_per_qty. 
*/

SELECT *,
strftime('%Y', market_date) as year,
strftime('%m', market_date) as month
,SUM(CAST(quantity AS decimal(5,2))*cost_to_customer_per_qty) as total_spent
FROM customer_purchases AS cp --on the left
INNER JOIN customer AS c -- on the right
	ON cp.customer_id = c.customer_id
WHERE year = '2022'
AND month = '04'
GROUP BY cp.customer_id, year, month

--I think I got it... 

/*
HINTS: you will need to AGGREGATE, GROUP BY, and filter...
but remember, STRFTIME returns a STRING for your WHERE statement!! */