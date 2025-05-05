✅ Question 1 – Achieving 1NF (First Normal Form)
Goal: Eliminate multivalued attributes (the Products column has multiple items in one cell).

🎯 Transformed Table (1NF):
Each product must be in its own row.

✅ SQL Query:
Here’s how you could write a SQL query to achieve this transformation using UNION ALL (assuming this is manual input):

sql
Copy
Edit
SELECT 101 AS OrderID, 'John Doe' AS CustomerName, 'Laptop' AS Product
UNION ALL
SELECT 101, 'John Doe', 'Mouse'
UNION ALL
SELECT 102, 'Jane Smith', 'Tablet'
UNION ALL
SELECT 102, 'Jane Smith', 'Keyboard'
UNION ALL
SELECT 102, 'Jane Smith', 'Mouse'
UNION ALL
SELECT 103, 'Emily Clark', 'Phone';
If you're using a database that supports string splitting (like PostgreSQL or SQL Server), you can automate it. For example, in PostgreSQL:

sql
Copy
Edit
SELECT 
    OrderID,
    CustomerName,
    unnest(string_to_array(Products, ', ')) AS Product
FROM ProductDetail;


✅ Question 2 Achieving 2NF (Second Normal Form)
Problem: CustomerName is dependent only on OrderID, not the full composite key (OrderID, Product). This is a partial dependency, violating 2NF.

🎯 Solution: Break into two tables.
Orders Table (stores CustomerName info):

sql
Copy
Edit
-- Customer details per order (no redundancy)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

INSERT INTO Orders (OrderID, CustomerName) VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');
OrderProducts Table (links products to orders):

sql
Copy
Edit
-- Each product in each order
CREATE TABLE OrderProducts (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

INSERT INTO OrderProducts (OrderID, Product, Quantity) VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);
