# Online Bookstore SQL Portfolio Project -

# Overview -
-- This project simulates a real-world online bookstore database system using MySQL. It demonstrates my ability to design relational schemas, 
   import and clean data, and write insightful SQL queries to answer business questions.


# The project covers:

-- Database design and normalization
-- Data import using LOAD DATA INFILE
-- Business and analytical SQL queries
-- Aggregations, joins, filtering, and subqueries

# Tech Stack

-- **Database: MySQL 8.0.43
-- **Tools: MySQL Workbench 

## Data Format: CSV files (Books, Customers, Orders)

## Database Schema

-- Tables

CREATE TABLE books (
  book_id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(100) NOT NULL,
  Author VARCHAR(100),
  Genre VARCHAR(50),
  Published_year INT,
  price DECIMAL(10,2),
  stock INT
);

CREATE TABLE customers (
  customer_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL,
  phone VARCHAR(15) NOT NULL,
  city VARCHAR(50),
  country VARCHAR(150)
);

CREATE TABLE orders (
  order_id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL,
  Book_ID INT NOT NULL,
  order_date DATE NOT NULL,
  Quantity INT,
  Total_Amount DECIMAL(10,2),
  FOREIGN KEY (customer_ID) REFERENCES customers(customer_ID),
  FOREIGN KEY (Book_ID) REFERENCES Books(Book_ID)
);
## Relationships:

-- orders.customer_id → customers.customer_id
-- orders.book_id → books.book_id

## Data Import
***Used LOAD DATA INFILE to import CSVs into MySQL**

-- Import Data into Books Table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Books.csv'
INTO TABLE books
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Import Data into customers Table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/customers.csv'
INTO TABLE customers
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Import Data into Orders Table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Orders.csv'
INTO TABLE Orders
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


## Business Questions Answered
**Here are some of the key queries included**

**Question**	                                         **SQL Concept**
List all books in the "Fiction" genre	      ---         WHERE clause
Find books published after 1950             ---       	Filtering with >
Total stock available                       ---       	SUM()
Most expensive book	                        ---         ORDER BY + LIMIT
Customers with >2 orders	                  ---         GROUP BY + HAVING
Revenue by genre                            ---         JOIN + SUM() + GROUP BY
Remaining stock after orders	              ---         LEFT JOIN + COALESCE()


## Key Insights

-- Identified top-selling genres and authors
-- Calculated total revenue and customer spending
-- Analyzed stock depletion post-sales
-- Filtered high-value customers and frequent buyers


##  What I Learned

-- Writing clean, efficient SQL queries
-- Using SELECT, GROUP BY, HAVING, and JOINS, AGGREGATED FUNCTIONS, WHERE,  for analytics
-- Handling real-world data import and cleaning
-- Structuring queries for business storytelling

## See the full list of 20+ queries in the queries.sql file.
LINK


## About Me-
-- I'm Dilip kumar, a data analyst skilled in SQL and data storytelling. I specialize in transforming raw datasets into actionable insights using relational queries, 
aggregations, and joins. My projects focus on solving real-world business problems through clean, optimized SQL.
