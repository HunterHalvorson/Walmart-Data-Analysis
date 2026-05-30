
SELECT * FROM walmart;
SELECT DISTINCT payment_method FROM walmart;

SELECT
	payment_method,
	COUNT(*)
FROM walmart
GROUP BY payment_method;

SELECT COUNT(DISTINCT Branch)
FROM walmart;


-- Business Problems
-- 1. Find each payment method find the number of transactions, number of quantity sold
SELECT
	payment_method, 
	COUNT(*) as no_transactions,
	SUM(quantity) as no_qty_sold
FROM walmart
GROUP BY 1;

-- 2. Identify the highest-rated category in each branch, displaying the branch, category, and AVG rating
SELECT *
FROM
	(
		SELECT
			branch,
			category,
			AVG(rating) as avg_rating,
			RANK() OVER(PARTITION BY branch ORDER BY AVG(rating) DESC) as rank
		FROM
			walmart
		GROUP BY 1, 2
		ORDER BY 1, 3 DESC
	)
WHERE rank = 1;

-- 3. Identify the busiest day for each branch based on the number of transactions
SELECT *
FROM
	(
		SELECT 
			branch,
			TO_CHAR(TO_DATE(date, 'DD/MM/YY'), 'Day') as day_name,
			COUNT(*) as no_transactions,
			RANK() OVER(PARTITION BY branch ORDER BY COUNT(*) DESC) as rank
		FROM walmart
		GROUP BY 1, 2
	)
WHERE rank = 1;

-- 4. Calculate the total quantity of items sold per payment method
SELECT
	payment_method,
	SUM(quantity) as to_quantity
FROM
	walmart
GROUP BY 
	payment_method;

-- 5. What is the average, minimum, and maximum rating for category in each city?
SELECT
	city, 
	category,
	MIN(rating) as min_rating,
	MAX(rating) as max_rating,
	AVG(rating) as avg_rating
FROM walmart
GROUP BY 1, 2;

-- 6. What is the total profit for each category, where total profit is calculated as unit_price × quantity × profit_margin, ordered from highest to lowest?
SELECT
	category,
	SUM(total) as total_revenue,
	SUM(total * profit_margin)
FROM 
	walmart
GROUP BY 1;


-- 7. What is the most common payment method used at each branch?
WITH cte
AS
	(
	SELECT
		branch,
		payment_method,
		COUNT(*) as total_trans,
		RANK() OVER(PARTITION BY branch ORDER BY COUNT(*) DESC) as rank
	FROM 
		walmart
	GROUP BY 1, 2
	)
	
SELECT * 
FROM cte
WHERE rank =1;



