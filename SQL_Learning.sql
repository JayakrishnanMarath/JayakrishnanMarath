						#MYSQL FOR DATA ANALYTICS COURSE

		-- This is the start of learning MySQL within 1 month, from basic core concepts to Advanced concepts, most of the topics in here have proper explanation to what it is and how to use it. some of it doesn't, because i was already familiar with it.

	#Multiple Logical Conditions
    
USE bakery;
SELECT *
FROM customers
WHERE (state="PA" OR birth_date>"1999-01-01") AND (total_money_spent>1000); #(This checks if either of the values in OR is true, if it is both true or one of them true, it checks the AND values and if they are true as well, it returns the O/P)

#NOT Logical Conditions

SELECT *
FROM customers
WHERE NOT (total_money_spent>1000); 

                                      #IN OPERATOR

SELECT *
FROM customers
WHERE state IN ("PA","TX","IL"); # IN Operator(used to reduce multiple OR statements)

                                      # BETWEEN OPERATOR

SELECT *
FROM customers
WHERE total_money_spent BETWEEN 500 AND 1500; # BETWEEN Operator
#(same as this syntax) WHERE total_money_spent <= 1500 AND total_money_spent >= 500;(used to  retrieve values in a particular range, to increase code efficiency as well, which should be in a lower to higher ORDER, else won't return the output.)

#BETWEEN Examples for different Data types like (INT, STR, Date)

# 1:DATE
SELECT *
FROM customers
WHERE birth_date BETWEEN "1998-01-01" AND "2020-01-01";

# 2:STR
SELECT *
FROM customers
WHERE city BETWEEN "Austin" AND "Sarasota"; # Full Strings

# 3:Alphabets(LEXICAL/ASCII ORDER)

SELECT *
FROM customers
WHERE city BETWEEN "D" AND "S"; # Alphabets are exported by USING ASCII/Lexical order rather than the letter order, in this example NewYork is displayed because N starts at 78 ASCII and its between (68 AND 83) of ("D" AND "S"). To get values based on thier first letter, you can use LEFT method.

#FOR Alphabets based retrieval
SELECT *
FROM customers
WHERE LEFT(city,1) BETWEEN "D" AND "S"; #LEFT method this exports the values with Alphabet starting with letters (D AND S).

                                          #LIKE Operator

# "_" for single character and "%" for Multiple characters before or after the letter.
# LIKE Operator is used for letter based retrievel, even if its a digit. If the % is before the letter it means the letter is the last word, if the % is after, then the letter is the first, if there are % before and after the letter, it means the word is in the middle or somewhere not first or last.

#Examples

SELECT *
FROM customers
WHERE first_name LIKE "c%"; 

SELECT *
FROM customers
WHERE phone LIKE "%357%";

SELECT *
FROM customers
WHERE last_name LIKE "__n___";

                                            # ORDER BY Clause

SELECT *
FROM customers
ORDER BY total_money_spent;#(ORDER BY clause is used to sort the values in ASCENDING or DESCENDING order, it can also be sorted by 2 columns at a time(Remember the first column being sorted will have the priority and the rest of the columns will be sorted depending up on first columns.))

SELECT *
FROM customers
ORDER BY total_money_spent DESC ;

SELECT *
FROM customers
ORDER BY first_name ASC, city ASC;

SELECT *
FROM customers
ORDER BY 8 DESC, 9 ASC; # "8" and "9" are column indexes, but it is always better to use column names because if in the future any of the columns are removed then the Indexing will change for the rest of the columns.

                                            # LIMIT Clause

SELECT *
FROM customers
WHERE total_money_spent > 500#(LIMIT Clause limits the number of values to be exported, in this case 5(first 5 rows))
LIMIT 5
;

SELECT *
FROM customers
WHERE total_money_spent <1000#(LIMIT Clause can also be written in a way to skip X number of rows and return the next Y rows, in this case 2 is the number of rows skipped and 4 is the number of rows returned after skipping, it returns the next Y Amount of rows right after the skipped rows.)
LIMIT 2,4
;

											# ALIASING
# Its the way of changing column name wether it is a normal column name or a result of operation with multiple column, represented as AS.
SELECT p.units_in_stock AS "u_i_s", p.product_id "id" #(it can be used to change or retrieve column names in different name if you'd like.)
FROM products p;

SELECT units_in_stock * sale_price AS "Total Revenue" #(it can also be used to change the name of the column which is created by doing operations with multiple columns.)
FROM products ;

                                           #Numeric Data Types

# 1: ROUND:(This rounds the numbers with multiple decimal points and you can choose how many decimal points you want.)
# CEILING GOES TO THE NEXT NUMBER THAN ROUNDING UP TO THE CLOSE ONE, FLOOR GOES BACK TO THE NUMBER, EX: CIELING(1.2) is 2, AND FLOOR(1.7) is 1, where as ROUND close to closest figure.

SELECT sale_price,ROUND(sale_price,2)
FROM products
ORDER BY sale_price ASC;

SELECT sale_price,ROUND(sale_price,2),CEILING(sale_price),FLOOR(sale_price)
FROM products
ORDER BY sale_price ASC;

SELECT ABS(-4.6) #(Its called Absolute or ABS, its used to convert any negative values into positive.)

															#STRING FUNCTION

#LENGTH

SELECT product_name, LENGTH(product_name) AS LEN_Product_Name
FROM products
ORDER BY LEN_Product_Name ASC;

#UPPER

SELECT product_name, UPPER(product_name) AS UPPER_Len
FROM products
ORDER BY UPPER_Len ASC;

#LOWER

SELECT product_name, LOWER(product_name) AS Lower_len
FROM products
ORDER BY Lower_len ASC;

SELECT first_name, customer_id, ROUND(total_money_spent * (32/4)) AS Multi_column
FROM customers;

#TRIM

SELECT TRIM("    i love india ")
SELECT RTRIM("    i love india ")
SELECT LTRIM("    i love india ")

#LEFT AND RIGHT

SELECT LEFT(first_name,3)
FROM customers;

SELECT RIGHT(last_name,3)
FROM customers;

#SUBSTRING(Makes both LEFT AND RIGHT obselete)

SELECT SUBSTRING(first_name,2,3)
FROM customers;

SELECT phone,SUBSTRING(phone,1,3) AS FIRST, SUBSTRING(phone,5,3) AS SECOND, SUBSTRING(phone,9,3) AS THIRD
FROM customers;

#REPLACE

SELECT REPLACE(phone,"-"," ") AS replaced
FROM customers;

SELECT REPLACE(first_name,"a","z") AS replaced
FROM customers;

#LOCATE

SELECT first_name,
lOCATE("cha",first_name)
FROM customers;

#CONCATINATE

SELECT first_name,
last_name,
CONCAT(first_name," ",last_name) AS Full_Name
FROM customers;

#Date and Date Format Functions

SELECT NOW();   #Returns current date and time

SELECT YEAR(NOW()),
MONTH(NOW()),
DAY(NOW());

SELECT CURDATE()

SELECT order_date
FROM customer_orders
WHERE YEAR(order_date) + 3 = YEAR(NOW()); #This returns the YEAR which plus 3 is the current year, which is 2025, so it returns all the 2022 Years.


SELECT DATE_FORMAT(order_date," %m-%d-%Y ")  #Capital differs from small case, ex: %m= 02, %M=February
FROM customer_orders;

SELECT *
FROM customer_orders;


# IF Functions

#Syntax :  IF(Condition, If True it does this, If False it does this)

SELECT customer_id,
 product_id,
 order_total,
 tip,
 IF( tip>1 , order_total * 0.75, order_total * 1.1 ) AS Grand_Total
FROM customer_orders;

# Case Statements

SELECT customer_id,
order_date,
CASE
    WHEN YEAR(order_date) = YEAR(NOW()) - 3 THEN "Active"
    WHEN YEAR(order_date) = YEAR(NOW()) - 4 THEN "Last Year"
    ELSE "Inactive"
END AS order_expiration
FROM customer_orders;

#CAST AND CONVERT

SELECT order_date,
CAST(order_date AS DATETIME) AS Cast_order_date,
CONVERT(tip, FLOAT) AS Convert_tip
FROM customer_orders;



#GROUP BY

SELECT customer_id,AVG(tip) AS Total_Sum_Tips # Average
FROM customer_orders
GROUP BY customer_id;

#GROUP BY FUNCTIONS

SELECT customer_id, COUNT(tip) AS Count # COUNT, which counts how many times a value has occured 
FROM customer_orders
GROUP BY customer_id
ORDER BY Count;

SELECT customer_id, COUNT(DISTINCT tip) AS Distinct_Count # COUNT(DISTINCT column_name) this removes the duplicates and then retrieve the count info.
FROM customer_orders
GROUP BY customer_id
ORDER BY Distinct_Count;

SELECT customer_id, MAX(tip) AS Maximum_Amount_Tipped # MAX() Maximum amount from a unique column, ex: Customer_id, one customer id with 2001 may have given multiple tips like 20, 10, 5, 50, so it gives back 50 as the highest.
FROM customer_orders
GROUP BY customer_id
ORDER BY Maximum_Amount_Tipped DESC ;

SELECT customer_id, MIN(tip) AS Minimum_Amount_Tipped # MIN() it is quite the opposite of MAX() as this returns the smallest value from a unique value in a column.
FROM customer_orders
GROUP BY customer_id
ORDER BY Minimum_Amount_Tipped;


# Note : IF the value is NULL, and you try to retrieve the count of it, then it will be 0, meaning there is no phone number.

SELECT first_name, last_name, COUNT(phone) AS Phone_Count
FROM customers
GROUP BY first_name, last_name
ORDER BY Phone_Count;

# This returns the values of the Names "DON and Frodo" as 0, even though its null in the original Database.

# HAVING AND WHERE COMPARISON

# When you try to use a condition based on a row which was created by doing aggregration on another row with Group by, the condition won't simply work with WHERE clause, because the WHERE statement is executed first and the row which is used in the WHERE clause hasn't been created yet because the SELECT statement has to be executed in order for it be created and then perfom operations on it, so we use HAVING clause which bypass this issue by executing after SELECT statement and thus solving this issue, look at the example given below for reference. 

SELECT customer_id, SUM(tip) AS Total_Tip # This returns an error named "Unknown column Total_Tip in Where Clause", to fix this we use HAVING.
FROM customer_orders
WHERE Total_Tip > 40
GROUP BY customer_id
ORDER BY Total_Tip ;    

SELECT customer_id, SUM(tip) AS Total_Tip # This fix the issue by executing the HAVING statement after the SELECT statement.
FROM customer_orders
GROUP BY customer_id 
HAVING Total_Tip > 2
ORDER BY Total_Tip ;

#ROLLUP

SELECT customer_id, SUM(tip) AS Total_Tip # This displays the total summation of the column which we aggregated on.
FROM customer_orders
GROUP BY customer_id WITH ROLLUP
ORDER BY Total_Tip ;

SELECT *
FROM customer_orders;


                                                        #JOIN

SELECT *
FROM customers c
INNER JOIN customer_orders co
  ON c.customer_id = co.customer_id
ORDER BY c.customer_id
  ;

SELECT product_name, SUM(order_total) AS Total
FROM products p
	JOIN customer_orders co
ON p.product_id = co.product_id
GROUP BY product_name WITH ROLLUP
ORDER BY 2 
    ;
    

SELECT product_id , supplier_id, name, SUM(quantity) AS Total_Quantity, unit_price  
FROM ordered_items oi
	INNER JOIN suppliers s
    ON oi.shipper_id = s.supplier_id
GROUP BY product_id , name , supplier_id, unit_price
ORDER BY name ASC
    ;
    
-- JOINING MULTIPLE TABLES TOGETHER

SELECT *
FROM products;

SELECT *
FROM customer_orders;

SELECT *
FROM customers;


SELECT first_name, last_name, product_name, order_total
FROM products p
	JOIN customer_orders co
		ON p.product_id = co.product_id
	JOIN customers c
		ON c.customer_id = co.customer_id   -- THIS JOINS 2 COLUMNS WITH SIMILAR PRIMARY KEY, AND THEN CONNECT THE THIRD ONE WITH ANOTHER ID, IN THIS CASE, PRODUCT_ID IS COMMON IN BOTH PRODUCTS AND CUSTOMER_ORDER TABLES, AND CUSTOMER_ID IS COMMON IN CUSTOMERS AND CUSTOMER_ORDERS.
ORDER BY order_total
;

   -- HOW TO JOIN MULTIPLE COLUMNS AND HOW TO DO FIX THE ISSUE WHEN DATA GETS WRONG ENTERED BY THE CUSTOMER.
   

SELECT *
FROM customer_orders co
	JOIN customer_orders_review cor
    ON co.order_id = cor.order_id
    AND co.customer_id = cor.customer_id
    AND co.order_date = cor.order_date
;

-- OUTER LEFT AND RIGHT JOINS

SELECT c.customer_id, 
first_name,
co.order_total
FROM customers c
	LEFT OUTER JOIN customer_orders co
		ON c.customer_id = co.customer_id 
;

SELECT c.customer_id, 
first_name,
co.order_total
FROM customers c
	RIGHT OUTER JOIN customer_orders co
		ON c.customer_id = co.customer_id 
;

-- SELF JOIN             -- JOINING A TABLE TO ITSELF BY CALLING IT WITH DIFFERENT ALIAS

SELECT c1.customer_id, c2.customer_id, c1.first_name  
FROM customers c1
	JOIN customers c2
		ON c1.customer_id = c2.customer_id
;

-- CROSS JOIN             JOINING EVERY ROW OF A TABLE X WITH EVERY ROW OF TABLE Y, IF A=(1,2,3) AND B=(X,Y,Z), THE CROSS JOIN WOULD BE (1,X), (1,Y), (1,Z), (2,X), (2,Y), (2,Z), (3,X), (3,Y), (3,Z). 

SELECT *
FROM customer_orders co
	CROSS JOIN customers c 
    ORDER BY co.customer_id
    ;
    
-- NATURAL JOIN           IT IS USED BY LETTING SQL FIND THE PRIMARY KEY AND FOREIGN KEY ON ITS ON. AND JOIN BOTH TABLES, MIGHT HAVE MISMATCH ISSUES WITH COMPLICATED ROWS AND COLUMNS.

SELECT *
FROM products
	NATURAL JOIN customer_orders
    ;

-- USING                 

-- it is used to short the line on JOIN operation when you have the same name for both columns in both tables,
-- ON p.customer_id = co.customer_id, into USING(customer_id), it will detect on its own.

-- UNION : ITS IS A FUNCTION TO COMBINE DATA INTO ROWS OF ANOTHER ROW.

-- IN THIS PROCESS, WE USE MULTIPLE UNIONS, FIRST WE USE THE CUSTOMER TABLE TO USE BIRTHDATE TO FIND PEOPLE WHO ARE OLD, THEN WE USE THE FIRST UNION AND JOIN THE CUSTOMER TABLE WITH CUSTOMER_ORDER TABLE TO USE THE TIP AND ORDER TOTAL TO USE IN WHERE CONDITION TO FIND OUT WHO SPENDS THE HIGHEST AND WHO SPENDS THE MOST ON TIPS
-- THEN THE DATA IS RETURNED BY ORDER BY ON FIRST_NAME.


-- THERE ARE 2 DIFFERENT UNIONS, UNION BY DEFAULT IS UNION DISTINCT, WHICH REMOVES THE DUPLICATES. ANOTHER ONE IS "UNION ALL", WHICH RETURNS ALL THE DATA WITH DUPLICATES.

SELECT first_name, last_name, address, "OLD" AS Label    
FROM customers
WHERE YEAR(birth_date) < 1970

UNION
SELECT first_name, last_name, address, "Great tipper" 
FROM customers c
	JOIN customer_orders co
		USING(customer_id)
WHERE tip >= 5

UNION
SELECT first_name, last_name, address, "Big spender" 
FROM customers c
	JOIN customer_orders co
		USING(customer_id) -- USE CASE OF "USING" FUNCTION
WHERE order_total > 24
ORDER BY first_name 
;

#   JOIN USE CASE

-- IN THE CODE BELOW, WE CONNECTED 4 TABLES TOGETHER AND RETURNED A DATABASE OF SUPPLIER NAMES WHICH STILL HASN'T SHIPPED NOR DELIVERED THE PRODUCT YET, SO THAT WE CAN CONTACT THEM REGARDING THIS ISSUE, WE USED MULTIPLE JOIN FUNCTIONS TO CONNECT DIFFERENT TABLES TOGETHER WITH PRIMARY AND FORIEGN KEY AND THEN DID A "WHERE" STATEMENT WITH CONDITION THAT THE VALUE IS "PROCESSED". This is a potential use case.

SELECT  oi.order_id, p.product_name, s.name, oi.shipped_date, sds.name AS Order_status
FROM products p
	JOIN ordered_items oi
		USING(product_id)
	JOIN suppliers s
		ON oi.shipper_id = s.supplier_id
	JOIN supplier_delivery_status sds
		ON oi.status = sds.order_status_id
-- WHERE YEAR(shipped_date) = YEAR(NOW()) - 4, YOU CAN ALSO USE THIS AS WELL TO FILTER OUT
HAVING sds.name = "Processed"
ORDER BY order_id
;

-- IN THE CODE BELOW, WE USE MULTIPLE TABLES TO PERFORM AGGREGATION FUNCTIONS USING GROUPBY AND RETURN THE PROFIT MARGIN AND POTENTIAL REVENUE WHICH CAN BE GENERATED FROM EACH PRODUCT.

SELECT p.product_id,
p.product_name,
p.units_in_stock,
oi.unit_price,
p.sale_price,
( p.sale_price - oi.unit_price ) AS Profit_Margin,
( ( p.sale_price - oi.unit_price ) * p.units_in_stock ) AS Potential_Revenue

FROM products p
	JOIN customer_orders co USING(product_id)
	JOIN ordered_items oi   USING(product_id)
    
GROUP BY p.product_id,
p.product_name,
p.units_in_stock,
oi.unit_price,
p.sale_price, Profit_Margin, Potential_Revenue 

ORDER BY product_id 
;

		
-- SUBQUERY

-- It is a nested query which means we write it inside the normal query, it is used when we want to use a single column of another table to retrieve values based on that, else we use JOIN, the loop inside the subquery gets executed first , then the outer/main query will excecuted on the value from the inner query,
-- example :  If innery query says where tip > 5, so if it returns 3 values, the main query will execute on these 3 values.

SELECT first_name, customer_id
FROM customers
WHERE customer_id 
IN (SELECT  customer_id
       FROM customer_orders
       WHERE order_total > 5)
       ;


-- ANY and ALL OPERATORS

-- ANY RETURNS THE VALUE IF AT LEAST ONE CONDITION IS MET

-- In the subquery, we asked to return only the product of unit_price and quantity as a table where shipper_id = 1, and in the main query we asked to compare it with ANY/ ALL of condition (quantity * unit_price). 

SELECT shipper_id, order_id, quantity, unit_price, (quantity * unit_price) AS Total_order_price
FROM ordered_items
WHERE (quantity * unit_price) > ALL (SELECT (quantity * unit_price) AS Total_order_price
FROM ordered_items
WHERE shipper_id = 1 );

SELECT shipper_id, order_id, quantity, unit_price, (quantity * unit_price) AS Total_order_price
FROM ordered_items
WHERE (quantity * unit_price) > ANY (SELECT (quantity * unit_price) AS Total_order_price   
FROM ordered_items
WHERE shipper_id = 1 );

SELECT c.customer_id, c.first_name
FROM customers c
WHERE EXISTS (SELECT 1
FROM customer_orders)
;
-- ALL RETURNS THE VALUE ONLY IF ALL THE CONDITIONS ARE MET.

-- EXISTS
-- RETURNS THE VALUES IF THEY EXIST
-- This checks if the row exist or not

SELECT c.customer_id, c.first_name
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM ordered_items oi
    WHERE oi.product_id = c.customer_id
);


-- SUBQUERY IN SELECT AND FR0M STATEMENT
 
-- adding subquery in select and from is same as adding a normal subquery but in SELECT statement you get it as a new column, and in FROM statement you get that as a new table and must use aliasing with FROM and in WHERE clause, it acts as a condition.

-- WINDOW FUNCTIONS
-- window functions include a lot of functions like row_number(), denserank(), rank(), lag, lead etc, these are functions like sum, avg, max, min, but these do a different purpose. 
-- We use this with OVER() clause, its the base of window function, it tells SQL that we are using Window functions, then we choose which way we want to perfom with our rows, meaning, do we want it to be collapsed into a single row of data ? then we use GROUP BY, and then work on it as usual, but if we want it to be individual rows, then we have to use the PARTITION BY CLAUSE. this doesnt collapse all the rows of data into one but keeps everything individual and turns all of the rows into groups based on another column, like customer_id.
-- We can also use ORDER BY in the end of it inside the OVER() clause.
-- ROW_NUMBER(), this gives a row number for unique values, for example : 

 SELECT 
customer_id, 
order_total,
ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_total DESC) AS rn
FROM customer_orders;

-- This means: “For each customer (PARTITION BY customer_id), order their purchases by order_total DESC, and give each row a unique number starting from 1.”


SELECT *
FROM (SELECT customer_id, 
first_name, 
order_total,
ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY order_total DESC) AS RN
FROM customer_orders co
JOIN customers c USING (customer_id)) AS row_table
WHERE rn < 3; 

-- The above code is a workaround for using WHERE clause in RN, by putting the entire code inside a subquery and running the clause outside.

-- DENSERANK() & RANK()

-- RANK() It is same as row_number, except it gives same values for duplicates, if there are 2 duplicates, like 2,2 in the rank, then the next number will be 4, it skips 3 on the order 1-10, run the code below and see the ranking, it skips the number if there is a duplicate number present, ex: 1,2,2,4 : it skips 3.

SELECT employee_id,
first_name, 
department, 
salary,
RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS Rank_
FROM employees;

-- DENSE_RANK() is the same as rank but it doesn't skip any. Run the code below and see the comparison, rank skips but dense doesnt, no matter how many duplicates are present.

SELECT employee_id,
first_name, 
department, 
salary,
RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS Rank_,
DENSE_RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS Dense_Rank_
FROM employees;

-- Important Note: RANK() doesn't work if you don't put ORDER BY clause. Run the code below for visual repr.

SELECT employee_id,
first_name, 
department, 
salary,
RANK() OVER(PARTITION BY department ) AS Rank_,
DENSE_RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS Dense_Rank_
FROM employees;

-- LAG() & LEAD()

-- The usage of LAG() is it removes one row from a certain column and adds a null there and pushes the row the front, meaning if there are 1,2,3,4,5 in a column, then after lag() it will be: null, 1, 2, 3, 4, (last number gets removed), check and run the below code for reference.

SELECT *,
LAG(salary) OVER(PARTITION BY department ORDER BY employee_id) AS LAG_col
FROM employees;

-- The same for LEAD(), but from the last meaning, if there is a column : 1,2,3,4,5,6, after LEAD(), it will be 2,3,4,5,6,NULL, exact same but opposite ends,check and run the below code for reference.

SELECT *,
LEAD(salary) OVER(PARTITION BY department ORDER BY employee_id) AS LEAD_col
FROM employees;

-- ADVANCED EXAMPLES:

-- This is a code to get the salary difference between a 2 people, either before or after, the salary value is the default salary, then we add the Window functions in a subquery and do perform operation on it by calling it in the outer query, so it gets called, the below are 2 examples for LEAD AND LAG.

SELECT *,
(lag_col - salary) AS Salary_Discrepancy
FROM (SELECT *,
LAG(salary) OVER(PARTITION BY department ORDER BY employee_id) AS Lag_col
FROM employees) AS ROWS_table
;


SELECT *,
(salary- lag_col) AS Salary_Discrepancy
FROM (SELECT *,
LEAD(salary) OVER(PARTITION BY department ORDER BY employee_id) AS Lag_col
FROM employees) AS ROWS_table
;


SELECT employee_id, salary,
LAG(salary) OVER(ORDER BY employee_id) AS lag_col,
LEAD(salary) OVER(ORDER BY employee_id) AS lead_col
FROM employees
;

-- REGULAR EXPRESION OR (REGEXP)

-- REGULAR EXPRESSION is used to retrive, replace and do other operations on the data, its similar to LIKE operator but it has a lot of functions and easy to use,
-- It involves : REGEXP_REPLACE, REGEXP_LIKE, REGEXP_INSTR, REGEXP_SUBSTR AND NEGATIONS OF THIS, NOT REGEXP_LIKE.
-- NOTE: SOME OF THESE EXPRRESSIONS CAN BE USED IN BOTH SELECT AND WHERE STATEMENT, BUT THE OUPUT WILL VARY AS THE SELECT STATEMENT WILL RETURN THE BOOLEAN VALUES AND CHARACTERS, THE WHERE STATEMENT RETURNS THE ROWS WHICH THAT MAKES THE CONDITION TRUE.
-- THE MAIN DIFFERENCE BETWEEN REGEXP AND REGEXP_LIKE IS _LIKE HAS MATCH TYPE[THESE ARE META CHARACTERS WHICH HAS DEFINITE PURPOSES.]

SELECT first_name,
first_name REGEXP "k"  AS Number_of_K,
first_name REGEXP "a"  AS Number_of_a
FROM customers
;

SELECT first_name, REGEXP_LIKE (first_name, "cha", "i") AS REGEXP_LIKE
FROM customers
;

SELECT first_name,  REGEXP_REPLACE(first_name,"a","z") AS Replaced_Z
FROM customers
;

SELECT first_name,  REGEXP_INSTR(first_name,"a") AS Replaced_Z
FROM customers
;

SELECT first_name,  REGEXP_SUBSTR(first_name,"cha") AS Replaced_Z
FROM customers
;


-- REGULAR EXPRESSION METACHARACTERS:

# THERE ARE CATEGORIZED INTO 5 DIFFERENT TYPES, ANCHORS, QUANTIFIERS, CHARACTER CLASSES, GROUPS AND ALTERNATION, ESCAPES AND SHORTHANDS

-- a) ANCHORS: THERE ARE 2 TYPES OF ANCHORS, "^" = CARET AND "$"= DOLLAR.alter

     # 1: ^
    
-- ^ IT RETURNS THE ROWS WITH CHARACTERS STARTING WITH ^, LOOK FOR THE EXAMPLE BELOW, IF PUT ^ INSIDE A BOX [], THEN ITS NEGATION, AS EVERY ROW CONTAINS LETTERS OTHER THAN S,Q AND L, IT RETURNS ALL THE ROWS([^sql]).

SELECT *
FROM z_regular_expression          -- HERE it returns every row with SQL as starting
WHERE email REGEXP "^sql" ; -- OR "^[sql]" both are same

SELECT *
FROM z_regular_expression
WHERE email REGEXP "[^sqlisfun@gmail.com]";          -- HERE it returns every row except the rows with "sqlisfun@gmail.com".

SELECT *
FROM z_regular_expression          -- here it removes everything that starts with SQL.
WHERE email REGEXP "^[^sql]";

     # 2: $
     
-- THIS MATCHES THE PATTERN WITH END OF THE LINE, IT RETURNS THE ROWS WITH CHAR OR LETTERS MATCHING WITH THE END OF THE LINE, $ IS WRITTEN AFTER THE CHARACTER.

SELECT *
FROM z_regular_expression
WHERE phrase REGEXP "fun$";

-- b) QUANTIFIERS: THERE ARE " *, +, ?, {n}, {n,},{n,m}"

-- * it matches with zero or more occurences , + only matches with 1 or more occurences but ? matches with zero or 1 occurences, {n} is for n characters, {n,} means at least n characters, {n,m} means between n & m occurences(note it checks for preceeding element, meaning if its "like", it checks "e". "lik" is required but "e" can appear 0 or more times)


SELECT *
FROM z_regular_expression
WHERE phrase REGEXP "like*"; -- * MEANING it needs "like" but "e" can appear zero or more times.

SELECT *
FROM z_regular_expression
WHERE phone REGEXP "^[1-3]{3}-[0-9]{3,}-[0-9]{3,4}$";  

SELECT *
FROM z_regular_expression
WHERE phrase REGEXP "like+";  -- THIS MEANS it needs to have "lik" and 1 or more of "e", same for just "like", usefull with complex.

SELECT *
FROM customers
WHERE address REGEXP "lane+";  -- Atleast 0 or 1 of "e"

-- b) CHARACTER CLASSES: THERE ARE ".", "[]", "[^]"

-- . is for any single character, [] is for a range, [a-z] or [0-9] and [^] is for negation 



                      #IMPORT DATA INTO MYSQL


-- IMPORTNG DATA INTO MYSQL CAN BE DONE IN 2 WAY, THROUGH IMPORT WIZARD WHICH CREATES A NEW TABLE WITH DATA, OTHER IS TO CODE THE WAY THROUGH BY USING CREATE FUNCTION.
-- IMPORTING DATA MUST BE EITHER CSV OR JSON FILE, MOSTLY USED IS CSV, STANDS FOR COMMA SEPERATED VALUES, WHICH IS EXPORTED FROM EXCEL OR ANY.

-- IMPORTING THROUGH WIZARD
   -- FIRST SELECT THE TABLE YOU WANT, RIGHT CLICK AND THEN CLICK ON TABLE IMPORT WIZARD, THEN SELECT THE CSV YOU WANT, CLICK NEXT, SELECT CREATE A NEW TABLE, CLICK NEXT, THEN THE DATA TYPES ARE SHOWN, CHANGE IT IF YOU NEED (NOTE: IF NOT SELECTED PROPERLY THE TABLE WILL NOT IMPORT ANY ROWS).
   -- CLICK NEXT AND NEXT AND NEXT, YOUR TABLE WILL BE CREATED BUT THE FIRST ROW WILL HAVE A SYMBOL IN THE START : ï»¿, TO REMOVE THIS, USE THE CODE BELOW, ALTER.
   
SELECT * FROM bakery.product_suggestions;
ALTER TABLE product_suggestions RENAME COLUMN `ï»¿product_suggestion_id` TO `product_suggestion_id`;

-- IMPORTING THROUGH CODE
   -- THE CODE BELOW IS USED TO CREATE A TABLE AND THEN USE IMPORT WIZARD, BUT USE EXISTING TABLE TO IMPORT THE DATA, CLICK NEXT AND FINISH THE WIZARD, AND THE DATA WILL BE IMPORTED INTO THE TABLE.
   -- THE CODE USED THE FUNCTION "USE" TO SELECT THE SCHEMA/DATA SET WE WANT OUR TABLE INTO, THEN CREATE TABLE FUNCTION AND A NAME OF THE TABLE, THEN COLUMN NAMES WITH THIER DATATYPE(NO COMMA BETWEEN NAME AND DATA TYPE), IN THE FINAL CODE, SELECT THE PRIMARY KEY().

USE bakery;

CREATE TABLE product_suggestions(
product_suggestion_id INT,
product_suggestion_name TEXT,
date_recieved TEXT,
PRIMARY KEY (product_suggestion_id)
);

						#EXPORT DATA FROM SQL

-- AFTER RUNNING OR CLEANING OR DOING AGGREGATE FUNCTION ON ROWS, YOU CAN EXPORT THE FINAL OUTPUT TABLE BY CLICKING ON THE EXPORT LOGO IN THE OUTPUT NEXT TO "Fiter Rows:"

   -- THE CODE BELOW IS AN EXAMPLE USED TO EXPORT THE TABLE.
SELECT *
FROM (
SELECT c.customer_id,
first_name,
order_total,
DENSE_RANK() OVER(PARTITION BY customer_id ORDER BY order_total DESC)AS row_num
FROM customers c
	JOIN customer_orders co
		USING(customer_id)) AS row_table
WHERE row_num < 3
;

-- BELOW WE USE THE OUTPUT FROM THE CODE TO CREATE A NEW TABLE BY RUNNING THE CODE BELOW, EXPORTING IT AS A CSV AND THEN IMPORTING THE DATA INTO IT.

USE bakery;

CREATE TABLE Partition_values (
customer_id INT,
first_name TEXT,
order_total DECIMAL,
row_num INT,
PRIMARY KEY(customer_id)
);

-- TO RUN THE NEW TABLE :

SELECT *
FROM partition_values
;
-- WE CAN ALSO EXPORT OUR ENTIRE TABLE BY RIGHT CLICKING AND EXPORT TABLE WIZARD.

              #DATA CLEANING
              
--  a) REMOVING DUPLICATES
-- BEFORE REMOVING DUPLICATES ALWAYS MAKE DUPLICATES OF THE TABLE TO NOT DISTRUPT OR REMOVE IMPORTANT ROWS FROM ORIGINAL TABLE BY MISTAKE, THIS IS CALLED STAGING, WHERE WE DUPLICATE A TABLE AND IN THE END WE NAME IT STAGING. WE DUPLICATE IT BY IMPORTING AS A NEW TABLE.
-- NOTE: Before running the remove duplicate function, make sure to turn off the safety pin which is "reject if delete/update" on the bottom part of the preference menu.

-- Here we first import the original table, then duplicate it(import one more time with different ALIAS), then we perform duplicate function within DELETE statement to remove duplicates, it can be done by groupby or Partition by to either find the rownumber > 2 or COUNT in groupby.

SELECT *
FROM customer_sweepstakes; 

-- CHANGE the awkard column name to normal name:
ALTER TABLE customer_sweepstakes RENAME COLUMN `ï»¿sweepstake_id` TO `sweepstake_id`;
SELECT *
FROM customer_sweepstakes; 

-- THE CODE BELOW FIRST SELECTS THE OUTPUT FROM SUBQUERY WHICH IS WITH ROW NUMBER, THEN WE PERFORM "WHERE" CONDITION ON OUTER QUERY TO REMOVE ROWS WITH LESS THAN ONE ROW_NUM, THEN WE USE DELETE FUNCTION WITH WHERE TO REMOVE THE COLUMN.

DELETE FROM customer_sweepstakes
WHERE sweepstake_id IN(

	SELECT sweepstake_id
	FROM (SELECT sweepstake_id,
	ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY sweepstake_id) AS row_num
	FROM bakery.customer_sweepstakes) AS row_table
	WHERE row_num > 1
)
;

SELECT *
FROM customer_sweepstakes
ORDER BY sweepstake_id; 

--  b) STANDARDIZE DATA

--  FIRST WE STANDARDIZE OUR DATA IN THE COLUMN PHONE, BY REMOVING ALL THE NON NUMERIC CHARACTERS AND ADDING BACK THE DASHESH USING CONCAT, REPLACE, SUBSTR AND UPDATE.

SELECT phone
FROM customer_sweepstakes;

-- WE REMOVE ALL THE NON ALPHA NUMERIC CHARACTERS AND THEN UPDATE IT.

SELECT phone, REGEXP_REPLACE(phone, '[-()/]','')
FROM customer_sweepstakes;

UPDATE customer_sweepstakes
SET phone = REGEXP_REPLACE(phone, '[-()/]','');

-- NOW WE ADD HIFEN TO IT BU USING CONCAT AND THEN UPDATE IT.

SELECT phone, CONCAT(SUBSTR(phone,1,3), "-", SUBSTR(phone,4,3), "-", SUBSTR(phone,6,4))
FROM customer_sweepstakes;

UPDATE customer_sweepstakes
SET phone = CONCAT(SUBSTR(phone,1,3), "-", SUBSTR(phone,4,3), "-", SUBSTR(phone,6,4));

-- NEXT WE ARE GOING TO STANDARDIZE birth_date COLUMN, first we change the data type TEXT to DATE-TIME FORMAT

SELECT birth_date, STR_TO_DATE(birth_date, "%m/%d/%Y")
FROM customer_sweepstakes;

-- IN THE ABOVE CASE, IF WE RUN, THERE ARE 2 VALUES WHICH GOES NULL BECAUSE OF THE FORMAT, WE NEED TO CHANGE THE FORMAT, UPDATE IT, THEN CONVERT IT INTO DATE-TIME, WE USE CONCAT AND REVERSE THE STRING TO MAKE THE YEAR AND DATE TO THIER CORRECT POSITION, THEN WE USE THIER PRIMARY KEY TO APPLY UPDATE MODIFIER TO ONLY AFFECT THOSE 2 ROWS. 

SELECT birth_date, CONCAT(SUBSTR(birth_date,9,2),"/",SUBSTR(birth_date,6,2),"/",SUBSTR(birth_date,1,4))
FROM customer_sweepstakes;

-- THEN WE USE THIER PRIMARY KEY TO APPLY UPDATE MODIFIER TO ONLY AFFECT THOSE 2 ROWS. 

UPDATE customer_sweepstakes
SET birth_date = CONCAT(SUBSTR(birth_date,9,2),"/",SUBSTR(birth_date,6,2),"/",SUBSTR(birth_date,1,4))
WHERE sweepstake_id IN (9,11) ;

-- NOW WE USE STR_TO_DATE TO CONVERT STRING TO DATE-FORMAT.

SELECT birth_date, STR_TO_DATE(birth_date, "%m/%d/%Y")
FROM customer_sweepstakes;

UPDATE customer_sweepstakes
SET birth_date = STR_TO_DATE(birth_date, "%m/%d/%Y");

-- IN THIS COLUMN, WE CANNOT USE THE NORMAL SUBSTR OR REPLACE BECAUSE THERE ARE MULTIPLE VALUES LIKE YES, Y, N ,NO, WE NEED ALL TO BE "N" OR "Y", SO WE USE CASE STATEMENT TO GET "Y" IF ITS YES OR "N" IF ITS NO ELSE KEEP IT THE SAME, MEANING IF ITS "N" OR "Y" KEEP IT THE SAME.

SELECT `Are you over 18?`,
CASE WHEN `Are you over 18?` = "YES" THEN "Y"
WHEN `Are you over 18?` = "NO" THEN "N"
ELSE `Are you over 18?`
END
FROM customer_sweepstakes; 

-- NOW WE UPDATE THE VALUES INTO THE COLUMN

UPDATE customer_sweepstakes
SET `Are you over 18?` =  CASE WHEN `Are you over 18?` = "YES" THEN "Y"
WHEN `Are you over 18?` = "NO" THEN "N"
ELSE `Are you over 18?`
END;

-- BREAKING ONE COLUMN INTO MULTIPLE COLUMNS:

-- WE ARE GOING TO BREAK THE ADDRESS INTO MULTIPLE COLUMNS:

SELECT address, SUBSTRING_INDEX(address,",",1)
FROM customer_sweepstakes;

SELECT address, SUBSTRING_INDEX(address,",",-1)
FROM customer_sweepstakes;

SELECT address, SUBSTRING_INDEX(SUBSTRING_INDEX(address,",",2),",",-1)
FROM customer_sweepstakes;

ALTER TABLE customer_sweepstakes
ADD COLUMN street VARCHAR(50) AFTER address,
ADD COLUMN city VARCHAR(50) AFTER street,
ADD COLUMN state VARCHAR(50) AFTER city;

UPDATE customer_sweepstakes
SET street = SUBSTRING_INDEX(address,",",1);

UPDATE customer_sweepstakes
SET city = SUBSTRING_INDEX(SUBSTRING_INDEX(address,",",2),",",-1);

UPDATE customer_sweepstakes
SET state = SUBSTRING_INDEX(address,",",-1)

SELECT state, TRIM(state)
FROM customer_sweepstakes;

UPDATE customer_sweepstakes
SET state = TRIM(state);

SELECT state, UPPER(state)
FROM customer_sweepstakes;

UPDATE customer_sweepstakes
SET state = UPPER(state);

UPDATE customer_sweepstakes
SET state = TRIM(city);

-- REMOVING NULL VALUES

-- There are 2 hifen values in the phone, because we didnt add NOT NULL while standardizing.

UPDATE customer_sweepstakes
SET phone = NULL
WHERE sweepstake_id IN (6,7);

-- WE NEED TO CONVERT SOME OF THE YES OR NO QUESTION BASED ON Birth_date,some of the values in the YES OR NO are not true.

SELECT birth_date, `Are you over 18?`
FROM customer_sweepstakes
WHERE (YEAR(NOW()) - 21) > YEAR(birth_date);

SELECT birth_date, `Are you over 18?`,
CASE 
	WHEN (YEAR(NOW()) - 21) > YEAR(birth_date) THEN "Y"
	WHEN (YEAR(NOW()) - 21) < YEAR(birth_date) THEN "N"
END
FROM customer_sweepstakes;

UPDATE  customer_sweepstakes
SET  `Are you over 18?` = CASE 
	WHEN (YEAR(NOW()) - 21) > YEAR(birth_date) THEN "Y"
	WHEN (YEAR(NOW()) - 21) < YEAR(birth_date) THEN "N"
END ;

-- WE NEED TO ADD NULL VALUES ONTO THE INCOME COLUMN.

UPDATE customer_sweepstakes
SET income = NULL
WHERE income = "";

-- COALESCE() : USED TO POPULATE VALUES WHICH ARE NULL.


SELECT AVG(income)
FROM customer_sweepstakes
;

-- This adds 0 to the null values and add the 0 to the average operation which reduces the average, because there are 2 zero's.

SELECT AVG(COALESCE(income,0)) 
FROM customer_sweepstakes
;

-- DELETING COLUMN

ALTER TABLE customer_sweepstakes
DROP COLUMN address;

ALTER TABLE customer_sweepstakes
DROP COLUMN favorite_color;

-- ROLLING TOTAL:

-- It is to use the SUM() in OVER() to find the total sum of row and its preceeding rows.

-- PROJECTS OF MYSQL FOR DATA ANALYTICS COURSE WILL BE ON SQL FILE NAMED PROJECTS.

-- ADVANCE SQL FOR DATA ANALYSTICS :

#CTEs AND TEMP TABLES:

-- CTE is full form for COMMON TABLE EXPRESSION, in essence its same as SUBQUERY, but some minor facts which makes it different, you can give independent naming in the for the SELECT statement elements in the first hand(if you dont know what that means, check the code below), you can add multiple CTEs to a CTE, but the problem with CTE is they are temporary meaning once you run another query or multiple query below this CTEs which are not related to it, it can't be accessed again, you'd have to run it again in order to access it.

-- USING JOINS you can connect 2 CTE'S together and work on thier data


WITH CTE_Example_1(product_id, Sum_order_total, Sum_of_tip, Number_of_tips) AS
(
	SELECT product_id, SUM(order_total), SUM(tip), COUNT(tip)
    FROM customer_orders
    WHERE tip <> 0
    GROUP BY product_id
),
CTE_Example_2(product_id, AVG_order_total, AVG_of_tip, Number_of_tips) AS
(
SELECT product_id, ROUND(AVG(order_total)), ROUND(AVG(tip)), COUNT(tip)
FROM customer_orders
GROUP BY product_id
)
SELECT *
FROM CTE_Example_1 cte1
	JOIN CTE_Example_2 cte2 USING (product_id)
;

-- RECURSIVE IN CTEs

-- Recurision is the process of calling itself.

WITH RECURSIVE CTE_Example AS(
SELECT 1 AS  X

UNION ALL

SELECT X+1
FROM CTE_Example
WHERE X < 10
)
SELECT X
FROM CTE_Example;


-- Recusrive CTEs example

WITH RECURSIVE company_hierarchy AS (
SELECT employee_id, first_name, last_name, boss_id,
0 AS Hierarchy_Level
FROM employees
WHERE boss_id IS NULL


UNION ALL 

SELECT e.employee_id, e.first_name, e.last_name, e.boss_id,
ch.Hierarchy_Level + 1
FROM employees e
	JOIN company_hierarchy ch
		ON e.boss_id = ch.employee_id
)
SELECT  
ch.first_name AS Employee_First_Name,
ch.last_name AS Employee_Last_Name,
e.first_name AS Boss_First_Name,
e.last_name AS Boss_Last_Name, 
Hierarchy_Level
FROM employees e
	JOIN company_hierarchy ch
		ON ch.boss_id = e.employee_id
;

-- TEMPORARY TABLES:
		-- This are session wise tables, meaning it will last as long as the session is(session meaning once you close the software/mysqlworkbench, it doesn't exist anymore). The below code explains and shows how to use Temp tables.
        -- There are 2 ways to create a temp table, first one is the code way which is CREATE TEMPORARY TABLE table_name, then its columns and thier data types, like normal table creation, and you can add values using INSERT INTO table_name (values).
        -- The second way is much more efficient as you can convert an output of a query or a part of a table into a new temporary table. Check the code below for easy reference.
        
CREATE TEMPORARY TABLE salary_temp
SELECT salary
FROM employees
WHERE salary > 50000
;

		-- This creates a new temporary table with salary above 50,000.
        
SELECT *
FROM salary_temp
;

	-- TEMP TABLES vs CTEs
		-- There are 2 things which differentiate both of these:
        -- * The reuseability of the table
        -- * The complexity of the query
        
WITH RECURSIVE CTE_table AS(
SELECT *,
ROW_NUMBER()OVER(PARTITION BY department ORDER BY salary)AS Row_num
FROM employees )
SELECT *
FROM CTE_TABLE
WHERE Row_num > 2
;


CREATE TEMPORARY TABLE Temp_table 
SELECT *
FROM employees
WHERE salary > 50000
;
		
SELECT *
FROM Temp_table;

		-- The Temporary Table can be used a lot of times but the CTEs can only be used a few times, and mostly the CTEs are used for complex queries and Recursion/Hierarchy.

-- Stored Procedure:

		-- Stored Procedure is the process of storing a complex or an easy query to a box in essence, we can call it later by using CALL stored_procedure_name.
		-- The stored procedure has 2 parameters, INPUT and OUTPUT.
		-- The example code is written below:

CREATE PROCEDURE Salary_Above_50k()
SELECT *
FROM employees
WHERE salary > 50000
;

CALL Salary_Above_50k();

		-- Now for multiple queries, we cannot type like above with each query ending with semicolon, which will only run on query, so for that we use DELIMITER $$ with BEGIN AND END $$ and close the DELIMITER in the end.
        
DELIMITER $$
CREATE PROCEDURE salary_groupby_department_number_of()
BEGIN

SELECT employee_id, first_name, department, SUM(salary) AS Total_Salary
FROM employees
GROUP BY department, employee_id, first_name
ORDER BY employee_id;

SELECT employee_id, first_name, department, MIN(salary) AS Minimum_Salary
FROM employees
GROUP BY department, employee_id, first_name
ORDER BY MIN(salary);

END $$
DELIMITER ;

CALL salary_groupby_department_number_of();


-- Parameters in stored procedures:
		-- The parameters will be initialized inside the table name with (), with the name of the table and prefix p_ or parm_, to differentiate the tables from normal table, then its data type and you can add multiple inputs by using ",". Check the query below for reference.
        
DROP TABLE IF EXISTS order_total
DELIMITER $$
CREATE PROCEDURE order_total(p_product_id INT,p_order_date DATE) 
BEGIN 
	SELECT *
    FROM customer_orders
    WHERE product_id = p_product_id 
    AND order_date = p_order_date;
END $$
DELIMITER ;

CALL order_total(1001,'2020-01-30');

-- DEFAULT VALUES AS PARAMETERS FOR NULL OR BLANK:
		-- The default values comes into place when the input is either NULL or blank(), to solve this we can do this 3 ways:
        -- The first way is adding an IF statement then using THEN SET and END IF.
        -- The second way is using an IF ELSE statement with THEN and adding the entire table as a default value.
        -- The third way is a better way, its by using a function called IFNULL in the end of the WHERE statement IFNULL(input,what to be added incase its NULL).
        
-- METHOD #1 (IF,THEN,ENDIF)

DROP TABLE IF EXISTS order_table1
DELIMITER $$

CREATE PROCEDURE order_table1(p_product_id INT)
BEGIN 
	IF p_product_id IS NULL
    THEN SET p_product_id = 1001;
    END IF;
    SELECT *
    FROM customer_orders
    WHERE product_id = p_product_id;
END $$
DELIMITER ;
    
CALL order_table1(NULL);
CALL order_table1(1006);

-- METHOD #2


DROP TABLE IF EXISTS order_table3

DELIMITER $$

CREATE PROCEDURE order_table3(p_product_id INT)
BEGIN
	IF p_product_id IS NULL THEN 
		SELECT *
		FROM customer_orders;
    ELSE
		SELECT *
		FROM customer_orders
		WHERE product_id = p_product_id;
	END IF;
END $$
DELIMITER ;

CALL order_table3(NULL);
CALL order_table3(1006);

-- METHOD #3(IF NULL)

DROP TABLE IF EXISTS order_table4
DELIMITER $$
CREATE PROCEDURE order_table4(p_product_id INT)
BEGIN 
	SELECT * FROM customer_orders
    WHERE product_id = IFNULL(p_product_id,1001);
END $$
DELIMITER ;

CALL order_table4(NULL);
CALL order_table4(1006);

-- OUTPUT PARAMETERS:

		-- Its the way of storing the output of a stored procedure into a table which we can use later.

DROP TABLE IF EXISTS order_total
DELIMITER $$

CREATE PROCEDURE order_total(p_product_id INT, OUT sum_of_order_total DECIMAL(10))
BEGIN
	SELECT SUM(order_total)
    INTO sum_of_order_total
    FROM customer_orders
    WHERE product_id = p_product_id;
END $$
DELIMITER ;

-- You have to call the below code everytime before using a output variable in stored procedure, first set it to 0, then put the value of procedure into it and then call it, once done, you can use it how ever you want.

SET @sum_of_order_total = 0;
CALL order_total(1001,@sum_of_order_total);
SELECT @sum_of_order_total;

-- The below is just a random operation done with output of procedure and sum of tips:

SELECT ROUND(@sum_of_order_total + SUM(tip),2) AS Totality 
FROM customer_orders;

#SESSION VARIABLE Vs LOCAL VARIABLE

		-- SESSION VARIABLE RUNS CAN BE USED THROUGH THE ENTIRE SESSION MEANING TILL THAT WINDOW IS CLOSED OR SOFTWARE IS CLOSED.
        -- LOCAL VARIABLE ONLY RUNS WITHIN A PROCEDURE OR CTE OR SUBQUERY, LOOK AT THE QUERY BELOW WHICH CALCULATES THE TOTAL PRICE ESITMATION OF AN INDIVIDUAL STOCK FROM PRODUCT_ID

DELIMITER $$
CREATE PROCEDURE quantity_cost_estimation (p_product_id INT, OUT p_quantity DECIMAL(9))
BEGIN
	DECLARE p_total_unit_price DECIMAL(9,2);
    DECLARE total_quantity_cost DECIMAL(9,2);
    
    SELECT SUM(quantity)
    INTO p_quantity
    FROM ordered_items
    WHERE product_id = p_product_id;

    SELECT SUM(unit_price)
	INTO p_total_unit_price
    FROM ordered_items
    WHERE product_id = p_product_id;
    
    SET total_quantity_cost = (p_quantity * p_total_unit_price);
    
    SELECT p_quantity;
    SELECT p_total_unit_price;
    SELECT total_quantity_cost;
END $$
DELIMITER ;

SET quantity = 0;
CALL quantity_cost_estimation(1001,@p_quantity);

-- In this procedure, the local variables are "p_total_unit_price" and "total_quantity_cost" 
-- because they are declared and used only inside the procedure.
-- Local variables: Declared with DECLARE inside a procedure. Scope is limited to that procedure.


-- Start with @ (e.g., @quantity). Persist throughout the session.
-- The "p_quantity" is an OUT parameter, not a session variable. 
-- It passes the value out of the procedure to a session variable (like @quantity), 
-- which can then be used anywhere in the session.

SELECT @p_quantity; -- ie the ∑ of quantity which we used inside the procedure.

            #TRIGGERS AND EVENTS
		
		-- Trigger is an group of code when an event occurs.
		-- The process is simple, we create a TRIGGER and name it, then THE logic is AFTER INSERT ON table_name, then this happens within a BEGIN AND END, with DELIMITERS.
        -- FOR EACH ROW MEANS When multiple rows are inserted (e.g., via a bulk insert), the trigger will run separately for each row.
		-- IF the trigger hits, then run whats inside the BEGIN statement, which is UPDATE this table, then what ever operation you want to occur, NEW. means New inserted rows, and OLD. means old rows.
		-- Then when that even happens, then the trigger runs and then does the operation. from updating the amount payed, to increasing salary, to deleting rows, which we will study later.
        
        -- WHEN DATA IS INSERTED, THE QUERY BELOW WILL WORK.
        
 DELIMITER $$
 CREATE TRIGGER update_client_payment_invoices
 AFTER INSERT ON client_payments
 FOR EACH ROW
 BEGIN
	UPDATE client_invoices
    SET total_paid = total_paid + NEW.amount_paid
    WHERE invoice_id = NEW.invoice_id;
END$$
DELIMITER ;

INSERT INTO client_payments
VALUES('11', '1003', '11', '2018-05-24', '127.01'
);

		-- WHEN DATA IS DELETED, THE QUERY BELOW WILL WORK.
DELIMITER $$
CREATE TRIGGER client_order_delete_invoice
AFTER DELETE ON client_payments              -- Here, we use DELETE instead of INSERT
FOR EACH ROW
BEGIN
	UPDATE client_invoices
    SET total_paid = order_total - OLD.amount_paid
    WHERE invoice_id = OLD.invoice_id;
END $$
DELIMITER ;

DELETE FROM client_payments
where payment_id = "11";

-- Viewing and Deleting Triggers:

SHOW TRIGGERS
WHERE EVENT = "INSERT";

DROP TRIGGER IF EXISTS update_client_payment_invoices;


	#EVENTS:
		-- You can schedule an event for any time, 30sec, 3hour, 3 days- 30 years.

SHOW VARIABLES LIKE 'event%'; -- To check if the EVENT scheduler is ON/OFF
SET event_scheduler = "ON";   -- If its OFF, then you can use this query to turn it ON.


		-- To create an event, check the code below:
        
DELIMITER $$
CREATE EVENT delete_expired_orders
ON SCHEDULE EVERY 30 SECOND
DO
BEGIN
	DELETE 
    FROM customer_orders
    WHERE order_date < NOW() - INTERVAL 7 YEAR;
END $$
DELIMITER ;

		-- To modify an existing event, check the code below:
        
DELIMITER $$
ALTER EVENT delete_expired_orders
ON SCHEDULE EVERY 30 SECOND
DO
BEGIN
	DELETE 
    FROM customer_orders
    WHERE order_date < NOW() - INTERVAL 7 YEAR;
END $$
DELIMITER ;

SHOW EVENTS;
        

	#Indexing for performance:
    
		-- Indexing means assigning each row an individual index so when searching for it, it doesn't have to go through millions of rows but only the indexing rows and find the position of the row.
        
        -- Below we use function/keyword named EXPLAIN, if you execute it then it explains what happens when you do this.
        
		-- If you check the code above it shows that it uses "all" type instead of  it also only filtered 32,292 rows, which is inefficient interms of time and when it comes to millions or billions of rows, it would take a nasty amount of time to read and retrieve, here we use INDEX
        
EXPLAIN SELECT *
FROM ushouseholdincome
WHERE Area_Code = "203";
     
CREATE INDEX idx_area_code
ON ushouseholdincome(Area_Code);

SHOW INDEXES IN ushouseholdincome;

-- If you check the code below, it shows that it uses "ref" type instead of "all" which is default and it also only filtered 177 rows instead of 32,292.

EXPLAIN SELECT *
FROM ushouseholdincome
WHERE Area_Code = "203";

        -- This is the basics of Indexing, to delete the index, syntax is same except use "DROP" instead of "CREATE".
        
DROP INDEX idx_area_code
ON ushouseholdincome;

SHOW INDEXES IN ushouseholdincome;

-- NOTE:It has nothing to do to the original column(The column we initialize in CREATE INDEX.) — it uses the values from that column to create a new sorted structure (the index), and keeps a reference (pointers) to the original row positions.

	#Prefix Indexes:
		
        -- So what the index does is it stores n number of charcters in the stored Index, So it will be easier to store and less space.
        -- If there is column name with values : 'Kerala', 'Karnataka', 'Kashmir', 'Kuwait'
        -- CREATE INDEX idx_state ON income_data(State_Name(3));  o/p: 'Ker', 'Kar', 'Kas', 'Kuw'.
        
CREATE INDEX idx_state_name2
ON ushouseholdincome(State_Name(9));

SHOW INDEX IN ushouseholdincome;
		
EXPLAIN SELECT *
FROM ushouseholdincome
WHERE State_name = 'Alabama';	
        
        #Composite indexing:
		-- It is the process of creating an index with 2 column names, sort of like creating 2 indexes seperately, but you can create upto 16 columns in composite index.
        -- To understand composite indexing, you have to understand what cardinality means, it means the amount of unique values in a column, if you use SHOW INDEXES IN tablename, then you can see the cardinality of the indexes you created.
        -- In the below case state_name has a cardinality of 49, meaning it has 49 unique rows out of 32,292 rows, so it has to do a lot of filtering, but incase of Aland, it has '29941' unique values, so it doesn't have much work to do, except for the 3k rows.
        -- Higher cardinality means, more efficient and so does the order of the columsn in indexing, CREATE INDEX index_name ON table_name(cola(),colb()), it goes through "cola" first then goes to "colb". so it would be better to put the higher cardinality column first, check the query below:        
   
		-- Seperate Indexes and to show thier cardinaltiy.
   
CREATE INDEX idx_Aland
ON ushouseholdincome(Aland);

SHOW INDEXES IN ushouseholdincome;

CREATE INDEX idx_State_Name
ON ushouseholdincome(State_Name(10));

SHOW INDEXES IN ushouseholdincome;
 
		-- Creating Composite INDEXES:
        
SELECT COUNT(DISTINCT city), COUNT(DISTINCT State_ab) 
FROM ushouseholdincome;
 
CREATE INDEX idx_StateAB_city
ON ushouseholdincome(State_ab(2),city(10));

CREATE INDEX idx_city_StateAB
ON ushouseholdincome(city(10),State_ab(2));

SHOW INDEX IN ushouseholdincome;

EXPLAIN SELECT * FROM ushouseholdincome
WHERE State_ab = "NC"
AND city LIKE "A%";

		-- In the above query it uses idx_StateAB_city instead of idx_city_StateAB, even though the city has higher cardinality, this is because of the WHERE clause, always "=" is greater than "LIKE", So it uses State_ab Index first, instead of city.
        
EXPLAIN SELECT * FROM ushouseholdincome
WHERE city = "A"
AND State_ab LIKE "%NC";

		-- The code above uses 'idx_city_StateAB' because "="  has more priority than "LIKE", so what ever column is used with "=", uses the appropriate index.
 
SELECT *
FROM ushouseholdincome;
        
SELECT *
FROM client_invoices; 

SELECT *
FROM client_payments; 

SELECT *
FROM employees; 

SELECT *
FROM ordered_items; 

SELECT *
FROM customer_orders;


-- END OF MYSQL Learning. Started on 01-MAY-2025 and finished on 08-JUNE-2025.





