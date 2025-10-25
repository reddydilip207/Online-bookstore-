# Online Bookstore Analysis SQL Project

## Project Overview

**Project Title**: Online Bookstore Analysis 
**Database**: `Online Bookstore`

This project focuses on analyzing an online bookstore dataset using SQL. It demonstrates how to manage databases, query data, and extract actionable insights about books, customers, orders, and revenue. The project is designed for data analysts to showcase SQL skills, including aggregation, joins, filtering, and advanced analytics.

The database consists of three core tables: Books, Customers, and Orders.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

Project Objectives

1. **Design a Relational Database**: Build tables for books, customers, and orders, and establish relationships between them.
2. **Explore the Dataset**: Understand the structure of the data, identify unique genres, authors, and customer locations.
3. **Analyze Sales Trends**: Track book sales over time, determine popular genres, and identify high-demand books.
4. **Customer Insights**: Find top-spending customers, order patterns, and geographic distribution of buyers.
5. **Inventory Management**: Monitor stock levels, detect low-stock items, and calculate remaining inventory after orders.
6. **Revenue Analysis**: Calculate total revenue, revenue by genre, and revenue contribution per author.
7. **Answer Business Questions with SQL**: Use queries to extract actionable insights that could support business decisions.
## Project Structure

**Schema Diagram**:

```sql
<img width="986" height="423" alt="Screenshot 2025-10-25 133938" src="https://github.com/user-attachments/assets/78f96515-74b1-4864-8dc8-d51b2f0d4cea" />

```


### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `Online Bookstore`.
- **Table Creation**: A table named `Books ,Customers ,Orders` is created to store the sales data.


```sql

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

```

### 2. Data Analysis & Findings

**Basic business questions**:

1. **--Q1: Retrieve all books in the "Fiction" genre?**:
```sql
SELECT * 
FROM books
WHERE genre='Fiction';
```

2. **--Q2: Find books published after the year 1950?**:
```sql
SELECT *
FROM books
WHERE Published_year >'1950';

```

3. **--Q3: List all customers from the canada.**:
```sql
SELECT * 
FROM customers
WHERE country ='Canada';
```

4. **--Q4: Show orders placed in November 2023.**:
```sql
SELECT *
FROM orders
WHERE order_date BETWEEN '2023-11-1' AND '2023-11-30';
```

5. **--Q5: Retrieve the total stock of books available.**:
```sql
SELECT 
	 SUM(stock) AS total_stock
FROM books;
```

6. **--Q6: --Q6: Find the details of the most expensive book.**:
```sql
SELECT *
FROM books
ORDER BY price DESC
LIMIT 1;
```

7. **--Q7: Show all customers who ordered more than 1 quantity of book.**:
```sql
SELECT *
FROM orders
WHERE quantity >1;
```

8. **--Q8: Retrieve all orders where the total amount exceeds $20.**:
```sql
SELECT * 
FROM orders
WHERE total_amount >20;
```

9. **--Q9: List all genres available in the Books table.**:
```sql
SELECT DISTINCT Genre
FROM books;
```

10. **--Q10: Find the book with the lowest stock**:
```sql
SELECT *
FROM books
ORDER BY stock
LIMIT 1;
```

11. **--Q11: Calculate the total revenue generated from all orders.**:
```sql
SELECT SUM(Total_Amount) revenue
FROM orders;
```

**Advance business questions**:

1. **--Q1: Retrieve the total of books sold for each genre.**:
```sql
SELECT 
     b.genre,
     SUM(o.quantity) AS total_books_sold
FROM books b
JOIN orders o ON o.book_id=b.book_id
GROUP BY b.genre;
```


2. **--Q2: Find the average price of books in the "Fantasy" genre.**:
```sql
SELECT AVG(price) AS avg_price
FROM books
WHERE genre = 'Fantasy';
```


3. **--Q3: List customers who have placed at least 2 orders.**:
```sql
SELECT 
     o.customer_id, 
     c.name,
     COUNT(o.order_id) AS order_Count
FROM orders o
JOIN customers c
GROUP BY o.customer_id,c.name
HAVING COUNT(order_id)>=2;
```


4. **--Q4: Find the most frequently ordered books.**:
```sql
select 
	 o.Book_ID,
     b.title,
     COUNT(o.order_id) AS order_count
FROM orders o
JOIN books b ON b.book_id=o.Book_ID
GROUP BY o.Book_ID
ORDER BY order_count desc
LIMIT 1;
```


5. **--Q5: show the top 3 most expensive books of 'Fantasy' Genre.**:
```sql
SELECT *
FROM books
WHERE genre ='Fantasy'
ORDER BY genre DESC
LIMIT 3;
```


6. **--Q6: Retrive the total quantity of books sold by each author**:
```sql
SELECT 
     b.Author,
     SUM(o.quantity) AS total_books_sold
FROM orders o
JOIN books b ON o.Book_ID=b.book_id
GROUP BY b.Author;
```


7. **--Q7: List the cities where customers who spent over $30 are located.**:
```sql
SELECT 
     DISTINCT c.city,
     o.Total_Amount 
FROM customers c
LEFT JOIN orders o ON o.customer_id=c.customer_id
WHERE o.Total_Amount >30;
```


8. **--Q8: Find the customer who spent the most on orders.**:
```sql
SELECT 
     c.customer_id,
     c.name,
     SUM(o.Total_Amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id=o.customer_id
GROUP BY c.customer_id,c.name
ORDER BY total_spent DESC
LIMIT 1;
```


9. **--Q9: Calculate the stock remaining after fulfilling all orders.**:
```sql
SELECT 
     b.book_id, b.title, b.stock,
	COALESCE(SUM(o.quantity),0) AS order_quantity,
    b.stock - COALESCE(SUM(o.quantity),0) AS remaining_quantity
FROM books b
LEFT JOIN orders o ON o.book_id = b.book_id
GROUP BY b.book_id,b.title,b.stock;
```
## Findings

- **Book Inventory Overview**: The dataset includes books across multiple genres such as Fiction, Fantasy, and Non-Fiction, with varying stock levels.
- **High-Value Orders**: Several orders exceeded $20, highlighting purchases of high-priced books or multiple copies.
- **Sales Trends**: Analysis of order dates shows which months had peak sales, helping to identify seasonal demand.
- **Customer Insights**: The data identifies top-spending customers, frequent buyers, and the geographic distribution of book orders.
- **Genre Popularity**: Fiction and Fantasy books appear to be the most frequently purchased genres.
- **Author Performance**: Some authors contribute significantly more to total sales, indicating popularity and demand.

## Reports

- **Book Inventory Report**:
- 1. Summarizes the total stock of books by genre and author.
- 2. Highlights low-stock books that may need restocking.
     
- **Sales & Revenue Report**: Shows total sales and revenue per genre, author, and month. Identifies high-value orders and peak sales periods.
- **Customer Insights Report**:
- 1. Lists top-spending customers and frequent buyers.
- 2. Analyzes customer locations and spending patterns.
     
- **Order Analysis Report**:
- 1. Tracks orders by quantity and total amount.
- 2. Identifies most frequently purchased books and popular genres.
     
- **Advanced Analytics Report**:
- 1. Calculates remaining stock after fulfilling orders.
- 2. Provides genre-wise and author-wise performance metrics.
- 3. Highlights trends to support marketing and inventory decisions.

## Conclusion

- This project demonstrates how SQL can be used to manage and analyze data for an online bookstore. By building a relational database with Books, Customers, and Orders tables, we were able to explore book inventory, customer behavior, and sales trends effectively.
-Overall, this project highlights practical SQL skills for real-world business scenarios and provides a framework to derive meaningful insights from bookstore data.
