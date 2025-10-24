-- Create Tables

create table Books (
	Book_ID SERIAL PRIMARY KEY,
	Title VARCHAR(100),
	Author VARCHAR(100),
	Genre VARCHAR(50),
	Published_Year INT, 
	Price NUMERIC (10, 2),
	Stock INT
);

DROP TABLE IF EXISTS customers;
create table Customers(
	Customer_ID SERIAL PRIMARY KEY,
	Name VARCHAR(100),
	Email VARCHAR(100),
	Phone VARCHAR(15),
	City VARCHAR(50),
	Country VARCHAR(150)
);

DROP TABLE IF EXISTS orders;
create table Orders(
	Order_ID SERIAL PRIMARY KEY,
	Customer_ID INT REFERENCES Customers(Customer_ID),
	Book_ID INT REFERENCES Books(Book_ID),
	Order_Date DATE,
	Quantity INT,
	Total_Amount NUMERIC(10,2)
);

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;




-- --------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------- Business Questions -------------------------------------------------

--Q1: Retrieve all books in the "Fiction" genre?
SELECT * 
FROM books
WHERE genre='Fiction';


--Q2:  Find books published after the year 1950?
SELECT *
FROM books
WHERE Published_year >'1950';


--Q3: List all customers from the canada?
SELECT * 
FROM customers
WHERE country ='Canada';


--Q4: Show orders placed in November 2023;
SELECT *
FROM orders
WHERE order_date BETWEEN '2023-11-1' AND '2023-11-30';


--Q5:  Retrieve the total stock of books available?
SELECT 
	 SUM(stock) AS total_stock
FROM books;


--Q6: Find the details of the most expensive book?
SELECT *
FROM books
ORDER BY price DESC
LIMIT 1;


--Q7: Show all customers who ordered more than 1 quantity of book?
SELECt *
FROM orders
WHERE quantity >1;


--Q8: Retrieve all orders where the total amount exceeds $20?
SELECT * 
FROM orders
WHERE total_amount >20;


--Q9: List all genres available in the Books table?
SELECT DISTINCT Genre
FROM books;


--Q10: Find the book with the lowest stock
SELECT *
FROM books
ORDER BY stock
LIMIT 1;


--Q11: Calculate the total revenue generated from all orders?
SELECT SUM(Total_Amount) revenue
FROM orders;

-- --------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------ Advance Questions -------------------------------------------------

--Q1: Retrieve the total of books sold for each genre?
SELECT 
     b.genre,
     SUM(o.quantity) AS total_books_sold
FROM books b
JOIN orders o ON o.book_id=b.book_id
GROUP BY b.genre;



--Q2: Find the average price of books in the "Fantasy" genre?
SELECT AVG(price) AS avg_price
FROM books
WHERE genre = 'Fantasy';



--Q3: List customers who have placed at least 2 orders?
SELECT 
     o.customer_id, 
     c.name,
     COUNT(o.order_id) AS order_Count
FROM orders o
JOIN customers c
GROUP BY o.customer_id,c.name
HAVING COUNT(order_id)>=2;



--Q4: Find the most frequently ordered books?
select 
	 o.Book_ID,
     b.title,
     COUNT(o.order_id) AS order_count
FROM orders o
JOIN books b ON b.book_id=o.Book_ID
GROUP BY o.Book_ID
ORDER BY order_count desc
LIMIT 1;



--Q5: show the top 3 most expensive books of 'Fantasy' Genre;
SELECT *
FROM books
WHERE genre ='Fantasy'
ORDER BY genre DESC
LIMIT 3;



--Q6: Retrive the total quantity of books sold by each author?
SELECT 
     b.Author,
     SUM(o.quantity) AS total_books_sold
FROM orders o
JOIN books b ON o.Book_ID=b.book_id
GROUP BY b.Author;



--Q7: List the cities where customers who spent over $30 are located?
SELECT 
     DISTINCT c.city,
     o.Total_Amount 
FROM customers c
LEFT JOIN orders o ON o.customer_id=c.customer_id
WHERE o.Total_Amount >30;



--Q8: Find the customer who spent the most on orders?
SELECT 
     c.customer_id,
     c.name,
     SUM(o.Total_Amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id=o.customer_id
GROUP BY c.customer_id,c.name
ORDER BY total_spent DESC
LIMIT 1;



--Q9: Calculate the stock remaining after fulfilling all orders?
SELECT 
     b.book_id, b.title, b.stock,
	COALESCE(SUM(o.quantity),0) AS order_quantity,
    b.stock - COALESCE(SUM(o.quantity),0) AS remaining_quantity
FROM books b
LEFT JOIN orders o ON o.book_id = b.book_id
GROUP BY b.book_id,b.title,b.stock;
	
--------------------------------------------------------------------------------------------------------------------------------------------------