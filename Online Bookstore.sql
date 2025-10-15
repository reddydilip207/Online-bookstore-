-- Create Database
CREATE DATABASE online_bookstore;

USE online_bookstore;
-- --------------------------------------------------------------------------------------------------------------------
-- Create Tables

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


-- --------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------- Business Questions -------------------------------------------------

-- Retrieve all books in the "Fiction" genre?
SELECT * 
FROM books
WHERE genre='Fiction';

-- Find books published after the year 1950?
SELECT *
FROM books
WHERE Published_year >'1950';

-- List all customers from the canada?
SELECT * 
FROM customers
WHERE country ='Canada';

-- Show orders placed in November 2023;
SELECT *
FROM orders
WHERE order_date BETWEEN '2023-11-1' AND '2023-11-30';

-- Retrieve the total stock of books available?
SELECT 
	 SUM(stock) AS total_stock
FROM books;

-- Find the details of the most expensive book?
SELECT *
FROM books
ORDER BY price DESC
LIMIT 1;

-- Show all customers who ordered more than 1 quantity of book?
SELECt *
FROM orders
WHERE quantity >1;

-- Retrieve all orders where the total amount exceeds $20?
SELECT * 
FROM orders
WHERE total_amount >20;

-- List all genres available in the Books table?
SELECT DISTINCT Genre
FROM books;

-- Find the book with the lowest stock
SELECT *
FROM books
ORDER BY stock
LIMIT 1;

-- Calculate the total revenue generated from all orders?
SELECT SUM(Total_Amount) revenue
FROM orders;

-- --------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------ Advance Questions -------------------------------------------------

-- Retrieve the total of books sold for each genre?
SELECT 
     b.genre,
     SUM(o.quantity) AS total_books_sold
FROM books b
JOIN orders o ON o.book_id=b.book_id
GROUP BY b.genre;

-- Find the average price of books in the "Fantasy" genre?
SELECT AVG(price) AS avg_price
FROM books
WHERE genre = 'Fantasy';

-- List customers who have placed at least 2 orders?
SELECT 
     o.customer_id, 
     c.name,
     COUNT(o.order_id) AS order_Count
FROM orders o
JOIN customers c
GROUP BY o.customer_id,c.name
HAVING COUNT(order_id)>=2;

-- Find the most frequently ordered books?
select 
	 o.Book_ID,
     b.title,
     COUNT(o.order_id) AS order_count
FROM orders o
JOIN books b ON b.book_id=o.Book_ID
GROUP BY o.Book_ID
ORDER BY order_count desc
LIMIT 1;

-- show the top 3 most expensive books of 'Fantasy' Genre;
SELECT *
FROM books
WHERE genre ='Fantasy'
ORDER BY genre DESC
LIMIT 3;

-- Retrive the total quantity of books sold by each author?
SELECT 
     b.Author,
     SUM(o.quantity) AS total_books_sold
FROM orders o
JOIN books b ON o.Book_ID=b.book_id
GROUP BY b.Author;

-- List the cities where customers who spent over $30 are located?
SELECT 
     DISTINCT c.city,
     o.Total_Amount 
FROM customers c
LEFT JOIN orders o ON o.customer_id=c.customer_id
WHERE o.Total_Amount >30;

-- Find the customer who spent the most on orders?
SELECT 
     c.customer_id,
     c.name,
     SUM(o.Total_Amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id=o.customer_id
GROUP BY c.customer_id,c.name
ORDER BY total_spent DESC
LIMIT 1;

-- Calculate the stock remaining after fulfilling all orders?
SELECT 
     b.book_id, b.title, b.stock,
	COALESCE(SUM(o.quantity),0) AS order_quantity,
    b.stock - COALESCE(SUM(o.quantity),0) AS remaining_quantity
FROM books b
LEFT JOIN orders o ON o.book_id = b.book_id
GROUP BY b.book_id,b.title,b.stock;

-- ------------------------------------------------------------------------------------------