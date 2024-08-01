DROP DATABASE IF EXISTS BabyStore;
CREATE DATABASE BabyStore;
USE BabyStore;

CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    PurchaseReason ENUM('Padre', 'Tio', 'Abuelo', 'Otro') NOT NULL,
    DataCreated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Categories (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Description TEXT,
    Price DECIMAL(10, 2) NOT NULL,
    CategoryID INT,
    Advertiser VARCHAR(255) NOT NULL,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    OrderDate DATE NOT NULL,
    CustomerID INT,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE Tips (
    TipID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    Content TEXT NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Añadir índices en columnas que se usan frecuentemente
CREATE INDEX idx_customer_email ON Customers(Email);
CREATE INDEX idx_product_category ON Products(CategoryID);
CREATE INDEX idx_order_date ON Orders(OrderDate);

-- Poblar la tabla Categories
INSERT INTO Categories (CategoryName) VALUES
('Ropa'),
('Calzado'),
('Juguetes'),
('Libros');

-- Poblar la tabla Products
INSERT INTO Products (Name, Description, Price, CategoryID, Advertiser) VALUES
('Camisa de Bebé', 'Camisa de algodón 100% para bebés.', 19.99, 1, 'BabyClothes Inc.'),
('Zapatillas Infantiles', 'Zapatillas cómodas para niños.', 29.99, 2, 'KidsFootwear Ltd.'),
('Juguete Educativo', 'Juguete para el desarrollo cognitivo.', 14.99, 3, 'EduToys Co.'),
('Libro de Cuentos', 'Libro con cuentos infantiles.', 9.99, 4, 'StoryBooks Publishers');

-- Poblar la tabla Customers
INSERT INTO Customers (FirstName, LastName, Email, PurchaseReason) VALUES
('Juan', 'Pérez', 'juan.perez@example.com', 'Padre'),
('Laura', 'Gómez', 'laura.gomez@example.com', 'Tio'),
('Pedro', 'Martínez', 'pedro.martinez@example.com', 'Abuelo'),
('Ana', 'Rodríguez', 'ana.rodriguez@example.com', 'Otro');

-- Poblar la tabla Orders
INSERT INTO Orders (OrderDate, CustomerID, TotalAmount) VALUES
('2024-07-15', 1, 49.98),
('2024-07-16', 2, 29.99),
('2024-07-17', 3, 24.98),
('2024-07-18', 4, 14.99);

-- Poblar la tabla OrderDetails
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price) VALUES
(1, 1, 2, 19.99),
(1, 2, 1, 29.99),
(2, 2, 1, 29.99),
(3, 3, 1, 14.99),
(3, 4, 1, 9.99),
(4, 4, 1, 14.99);

-- Poblar la tabla Tips
INSERT INTO Tips (CustomerID, Content) VALUES
(1, 'Asegúrate de comprar ropa con tejido hipoalergénico.'),
(2, 'Revisa las tallas antes de comprar calzado.'),
(3, 'Los juguetes educativos son excelentes para el desarrollo temprano.'),
(4, 'Un libro de cuentos puede ser un regalo encantador para cualquier niño.');

-- 1. Seleccionar todos los clientes
SELECT * FROM Customers;

-- 2. Seleccionar todos los productos en una categoría específica
SELECT * FROM Products WHERE CategoryID = 1;

-- 3. Ordenar los productos por precio
SELECT * FROM Products ORDER BY Price ASC;

-- 4. Limitar el número de resultados a 5
SELECT * FROM Products LIMIT 5;

-- 5. Buscar productos con precio mayor a 20
SELECT * FROM Products WHERE Price > 20;

-- 6. Buscar órdenes realizadas en una fecha específica
SELECT * FROM Orders WHERE OrderDate = '2024-07-15';

-- 7. Buscar clientes cuyo nombre empiece con 'J'
SELECT * FROM Customers WHERE FirstName LIKE 'J%';

-- 8. Buscar productos sin descripción
SELECT * FROM Products WHERE Description IS NULL;

-- 9. Contar el número de órdenes realizadas por un cliente específico
SELECT COUNT(*) FROM Orders WHERE CustomerID = 1;

-- 10. Buscar productos en la categoría 'Juguetes'
SELECT * FROM Products WHERE CategoryID = (SELECT CategoryID FROM Categories WHERE CategoryName = 'Juguetes');

-- 1. Consultar el nombre del cliente y el total de su gasto
SELECT Customers.FirstName, Customers.LastName, SUM(Orders.TotalAmount) AS TotalSpent
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID;

-- 2. Consultar el total de ventas por categoría de producto
SELECT Categories.CategoryName, SUM(OrderDetails.Quantity * OrderDetails.Price) AS TotalSales
FROM OrderDetails
JOIN Products ON OrderDetails.ProductID = Products.ProductID
JOIN Categories ON Products.CategoryID = Categories.CategoryID
GROUP BY Categories.CategoryName;

-- 3. Obtener el total de artículos comprados en cada orden
SELECT Orders.OrderID, SUM(OrderDetails.Quantity) AS TotalItems
FROM OrderDetails
JOIN Orders ON OrderDetails.OrderID = Orders.OrderID
GROUP BY Orders.OrderID;

-- 4. Consultar los productos que han sido comprados más de una vez
SELECT Products.Name, COUNT(OrderDetails.OrderID) AS PurchaseCount
FROM OrderDetails
JOIN Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY Products.ProductID
HAVING COUNT(OrderDetails.OrderID) > 1;

-- 5. Consultar el nombre del cliente y los productos comprados usando JOIN
SELECT Customers.FirstName, Customers.LastName, Products.Name
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
JOIN Products ON OrderDetails.ProductID = Products.ProductID;

-- 6. Obtener la lista de productos y su precio promedio por categoría
SELECT Categories.CategoryName, AVG(Products.Price) AS AvgPrice
FROM Products
JOIN Categories ON Products.CategoryID = Categories.CategoryID
GROUP BY Categories.CategoryName;

-- 7. Buscar clientes que realizaron más de una compra
SELECT Customers.FirstName, Customers.LastName, COUNT(Orders.OrderID) AS NumberOfOrders
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID
HAVING COUNT(Orders.OrderID) > 1;

-- 8. Consultar la cantidad total de productos vendidos por cada producto
SELECT Products.Name, SUM(OrderDetails.Quantity) AS TotalQuantity
FROM OrderDetails
JOIN Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY Products.ProductID;

-- 9. Consultar los clientes que han dejado tips
SELECT Customers.FirstName, Customers.LastName, Tips.Content
FROM Customers
JOIN Tips ON Customers.CustomerID = Tips.CustomerID;

-- 10. Consultar los productos con el mayor y menor precio
SELECT MIN(Price) AS MinPrice, MAX(Price) AS MaxPrice
FROM Products;

-- TRIGGER
DELIMITER //

CREATE TRIGGER UpdateOrderTotal
AFTER INSERT ON OrderDetails
FOR EACH ROW
BEGIN
    UPDATE Orders
    SET TotalAmount = (SELECT SUM(Quantity * Price) FROM OrderDetails WHERE OrderID = NEW.OrderID)
    WHERE OrderID = NEW.OrderID;
END;
//

DELIMITER ;

-- FUNCION
DELIMITER //

CREATE FUNCTION GetTotalSpent(customerID INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE totalSpent DECIMAL(10,2);
    SELECT SUM(TotalAmount) INTO totalSpent
    FROM Orders
    WHERE CustomerID = customerID;
    RETURN totalSpent;
END;
//

DELIMITER ; 
