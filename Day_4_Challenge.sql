CREATE DATABASE ABC_DATA;

USE ABC_DATA;

CREATE TABLE CUSTOMERS(
CustomerId INT AUTO_INCREMENT PRIMARY KEY,
First_Name VARCHAR (100),
Last_Name VARCHAR (100),
Email VARCHAR(250) UNIQUE NOT NULL
);


INSERT INTO CUSTOMERS(First_Name,Last_Name,Email)
VALUES
('Joe','Doe','Joe.doe@gmail.com'),
('Jane', 'Smith', 'janesmith@email.com'),
('Bob', 'Johnson', 'bobjohnson@email.com'),
('Alice', 'Brown', 'alicebrown@email.com'),
('Charlie', 'Davis', 'charliedavis@email.com'),
('Eva', 'Fisher', 'evafisher@email.com'),
('George', 'Harris', 'georgeharris@email.com'),
('Ivy', 'Jones', 'ivyjones@email.com'),
('Kevin', 'Miller', 'kevinmiller@email.com'),
('Lily', 'Nelson', 'lilynelson@email.com'),
('Oliver', 'Patterson', 'oliverpatterson@email.com'),
('Quinn', 'Roberts', 'quinnroberts@email.com'),
('Sophia', 'Thomas', 'sophiathomas@email.com');

SELECT * FROM CUSTOMERS;

CREATE TABLE PRODUCTS(
Product_Id INT AUTO_INCREMENT PRIMARY KEY,
Product_Name VARCHAR(100),
Price INT );

INSERT INTO PRODUCTS(Product_Name, Price)
VALUES
('Product A', 10.00),
('Product B', 15.00),
('Product C', 20.00),
('Product D', 25.00),
('Product E', 30.00),
('Product F', 35.00),
('Product G', 40.00),
('Product H', 45.00),
('Product I', 50.00),
('Product J', 55.00),
('Product K', 60.00),
('Product L', 65.00),
('Product M', 70.00);

SELECT * FROM PRODUCTS;

CREATE TABLE ORDERS(
Order_Id INT PRIMARY KEY,
CustomerId INT ,
Order_Date DATE,
FOREIGN KEY (CustomerId) REFERENCES CUSTOMERS(CustomerId));

INSERT INTO ORDERS(Order_Id,CustomerID,Order_Date)
VALUES
(1, 1, '2023-05-01'),
(2, 2, '2023-05-02'),
(3, 3, '2023-05-03'),
(4, 1, '2023-05-04'),
(5, 2, '2023-05-05'),
(6, 3, '2023-05-06'),
(7, 4, '2023-05-07'),
(8, 5, '2023-05-08'),
(9, 6, '2023-05-09'),
(10, 7, '2023-05-10'),
(11, 8, '2023-05-11'),
(12, 9, '2023-05-12'),
(13, 10, '2023-05-13'),
(14, 11, '2023-05-14'),
(15, 12, '2023-05-15'),
(16, 13, '2023-05-16');

SELECT * FROM ORDERS;

CREATE TABLE ORDER_ITEMS(
Order_Id INT ,
Product_Id INT ,
Quantity INT ,
FOREIGN KEY (Order_Id) REFERENCES ORDERS(Order_Id),
FOREIGN KEY (Product_Id) REFERENCES PRODUCTS(Product_Id));

INSERT INTO ORDER_ITEMS(Order_Id,Product_Id,Quantity)
VALUES
(1, 1, 2),
(1, 2, 1),
(2, 2, 1),
(2, 3, 3),
(3, 1, 1),
(3, 3, 2),
(4, 2, 4),
(4, 3, 1),
(5, 1, 1),
(5, 3, 2),
(6, 2, 3),
(6, 1, 1),
(7, 4, 1),
(7, 5, 2),
(8, 6, 3),
(8, 7, 1),
(9, 8, 2),
(9, 9, 1),
(10, 10, 3),
(10, 11, 2),
(11, 12, 1),
(11, 13, 3),
(12, 4, 2),
(12, 5, 1),
(13, 6, 3),
(13, 7, 2),
(14, 8, 1),
(14, 9, 2),
(15, 10, 3),
(15, 11, 1),
(16, 12, 2),
(16, 13, 3);    

SELECT* FROM ORDER_ITEMS;
#Returns Product With the highest price
SELECT Product_Name
FROM PRODUCTS
ORDER BY Price DESC
LIMIT 1;

#Returns Order_Id With the Highest Quantity
SELECT Order_Id ,Quantity
FROM ORDER_ITEMS
ORDER BY Quantity DESC
LIMIT 1;

#The Customer that made a lot of orders
SELECT c.First_Name, c.Last_Name, Order_Counts
FROM CUSTOMERS c
JOIN ( SELECT CustomerId , COUNT(Order_Id) AS Order_Counts
		FROM ORDERS
        GROUP BY CustomerId
        ORDER BY Order_Counts DESC
        LIMIT 1
	) AS oc ON c.CustomerId= oc.CustomerId;
    
#Total Revenue per product
  SELECT p.Product_Name,
    p.Price * sum(oi.Quantity) AS Total_revenue
    FROM PRODUCTS p
    JOIN ORDER_ITEMS oi ON oi.Product_Id = p.Product_Id
    GROUP BY p.Product_Name,p.Product_Id
    ORDER BY 2 DESC;








