-- Reviews Table
CREATE TABLE Reviews
(
  Review_ID INT NOT NULL AUTO_INCREMENT,
  Customer_ID INT NOT NULL,
  Product_ID INT NOT NULL,
  Rating INT CHECK (Rating >= 1 AND Rating <= 5),
  PRIMARY KEY (Review_ID)
);

-- Customer Table
CREATE TABLE Customer
(
  CustomerID INT NOT NULL AUTO_INCREMENT,
  Email VARCHAR(255) NOT NULL UNIQUE,
  UserName VARCHAR(100) NOT NULL UNIQUE,
  Password VARCHAR(255) NOT NULL,
  Contact_number VARCHAR(15) NOT NULL,
  PRIMARY KEY (CustomerID)
);

-- Address Table
CREATE TABLE Address
(
  AddressID INT NOT NULL AUTO_INCREMENT,
  City VARCHAR(100) NOT NULL,
  State VARCHAR(100) NOT NULL,
  Country VARCHAR(100) NOT NULL,
  CustomerID INT NOT NULL,
  PRIMARY KEY (AddressID)
);

-- Order Table
CREATE TABLE Orders
(
  OrderID INT NOT NULL AUTO_INCREMENT,
  Order_Status VARCHAR(50) NOT NULL,
  Total_Price DECIMAL(10, 2) NOT NULL,
  AddressID INT NOT NULL,
  CustomerID INT NOT NULL,
  PRIMARY KEY (OrderID)
);

-- Products Table
CREATE TABLE Products
(
  ProductID INT NOT NULL AUTO_INCREMENT,
  Product_name VARCHAR(100) NOT NULL,
  Price DECIMAL(10, 2) NOT NULL,
  Description TEXT,
  Stock_quantity INT NOT NULL,
  PRIMARY KEY (ProductID)
);

-- OrderDetails Table (Junction table for Orders and Products)
CREATE TABLE OrderDetails
(
  OrderDetailsID INT NOT NULL AUTO_INCREMENT,
  OrderID INT NOT NULL,
  ProductID INT NOT NULL,
  Quantity INT NOT NULL,
  PRIMARY KEY (OrderDetailsID),
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
  FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

ALTER TABLE Reviews 
ADD FOREIGN KEY (Customer_ID) REFERENCES Customer(CustomerID);

ALTER TABLE Reviews 
ADD FOREIGN KEY (Product_ID) REFERENCES Products(ProductID);
  
ALTER TABLE Address  
ADD FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID); 

ALTER TABLE Orders 
ADD FOREIGN KEY (AddressID) REFERENCES Address(AddressID);

ALTER TABLE Orders 
ADD FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID);

INSERT INTO Customer (Email, UserName, Password, Contact_number)
VALUES
('john.doe@example.com', 'johnny123', 'password123', '1234567890'),
('jane.smith@example.com', 'jane_smith', 'password456', '2345678901'),
('mike.jones@example.com', 'mikejones', 'password789', '3456789012'),
('lucy.davis@example.com', 'lucyd', 'password321', '4567890123'),
('mary.williams@example.com', 'maryw', 'password987', '5678901234'),
('peter.brown@example.com', 'peter_b', 'password654', '6789012345');

-- Inserting data into Address Table
INSERT INTO Address (City, State, Country, CustomerID)
VALUES
('New York', 'New York', 'USA', 1),
('Los Angeles', 'California', 'USA', 2),
('Chicago', 'Illinois', 'USA', 3),
('Houston', 'Texas', 'USA', 4),
('Phoenix', 'Arizona', 'USA', 5),
('Philadelphia', 'Pennsylvania', 'USA', 6);

-- Inserting data into Products Table
INSERT INTO Products (Product_name, Price, Description, Stock_quantity)
VALUES
('Rice Cake A', 5.99, 'Light and crispy rice cake with a sweet flavor.', 100),
('Rice Cake B', 6.99, 'Crispy rice cake with a savory flavor.', 150),
('Rice Cake C', 7.99, 'Crunchy rice cake with a spicy flavor.', 200);
('Granola Bar A', 2.99, 'A healthy granola bar with oats and honey.', 50),
('Granola Bar B', 3.49, 'Granola bar with almonds and dark chocolate.', 80),
('Rice Crackers', 1.99, 'Light, crispy rice crackers with seaweed flavor.', 200),
('Veggie Chips', 3.79, 'Crispy chips made from assorted vegetables.', 120),
('Fruit Snack Mix', 4.49, 'A mix of dried fruits and nuts for a healthy snack.', 150),
('Chia Seed Pudding', 5.99, 'Chia seeds in a creamy coconut milk base with a touch of vanilla.', 90);

-- Inserting data into Orders Table
INSERT INTO Orders (Order_Status, Total_Price, AddressID, CustomerID)
VALUES
('Shipped', 29.99, 1, 1),
('Delivered', 49.99, 2, 2),
('Pending', 19.99, 3, 3),
('Cancelled', 39.99, 4, 4),
('Shipped', 59.99, 5, 5),
('Delivered', 15.99, 6, 6);

-- Inserting data into OrderDetails Table
INSERT INTO OrderDetails (OrderID, ProductID, Quantity)
VALUES
(1, 1, 3),
(2, 2, 5),
(3, 1, 2),
(4, 3, 4),
(5, 2, 6),
(6, 3, 1);

-- Inserting data into Reviews Table
INSERT INTO Reviews (Customer_ID, Product_ID, Rating)
VALUES
(1, 1, 5),
(2, 2, 4),
(3, 1, 3),
(4, 3, 5),
(5, 2, 2),
(6, 3, 4);

SELECT 
    p.Product_name, 
    SUM(od.Quantity) AS Total_Quantity_Sold, 
    AVG(p.Price) AS Average_Price
FROM 
    Products p
INNER JOIN 
    OrderDetails od ON p.ProductID = od.ProductID
INNER JOIN 
    Orders o ON od.OrderID = o.OrderID
GROUP BY 
    p.Product_name;
   
   
  
-- Create a view for the top 3 products sold based on total quantity
CREATE VIEW Top3ProductsSold AS
SELECT 
    p.ProductID,
    p.Product_name,
    SUM(od.Quantity) AS TotalQuantitySold
FROM 
    Products p
INNER JOIN 
    OrderDetails od ON p.ProductID = od.ProductID
GROUP BY 
    p.ProductID, p.Product_name
ORDER BY 
    TotalQuantitySold DESC
LIMIT 3;

-- Retrieve data from the view
SELECT * FROM Top3ProductsSold tps 	;
