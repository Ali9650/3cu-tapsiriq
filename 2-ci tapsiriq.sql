Create DATABASE Seller 
USE Seller 
CREATE TABLE Sellers (
    Id INT PRIMARY KEY IDENTITY (1,1),
    Name VARCHAR(50),
    Surname VARCHAR(50),
    City VARCHAR(50)
);

CREATE TABLE Customers (
    Id INT PRIMARY KEY IDENTITY (1,1),
    Name VARCHAR(50),
    Surname VARCHAR(50),
    City VARCHAR(50)
);

CREATE TABLE Orders (
    Id INT PRIMARY KEY IDENTITY (1,1),
    OrderDate DATE,
    Amount DECIMAL(10, 2),
    State VARCHAR(50),
    CustomerId INT,
    SellerId INT,
    FOREIGN KEY (CustomerId) REFERENCES Customers(Id),
    FOREIGN KEY (SellerId) REFERENCES Sellers(Id)
);

INSERT INTO Sellers 
VALUES ('Ali', 'Cahangirov', 'Baki'),
('Samir', 'Abbasov', 'Sumqayit')

INSERT INTO Customers 
VALUES ('Sabir', 'Mustafayev', 'Sumqayit'),
('Royal', 'Ceferov', 'Baki')

INSERT INTO Orders 
VALUES ('2024.04.04', 1000.5, 'Tamamlanib', 1, 2),
('2024.05.05', 5567.5, 'Catdirilmada', 2, 1)

SELECT c.Name, c.Surname, SUM(o.Amount) AS TotalAmount
FROM Customers c
JOIN Orders o ON c.Id = o.CustomerId
WHERE o.Amount > 1000
GROUP BY c.Name, c.Surname
ORDER BY TotalAmount DESC;

SELECT c.Name AS CustomerName, c.City AS CustomerCity, s.Name AS SellerName, s.City AS SellerCity
FROM Customers c
JOIN Sellers s ON c.City = s.City
ORDER BY c.City, c.Name, s.Name;

SELECT o.Id, o.OrderDate, o.Amount, o.State, c.Name AS CustomerName, s.Name AS SellerName
FROM Orders o
JOIN Customers c ON o.CustomerId = c.Id
JOIN Sellers s ON o.SellerId = s.Id
WHERE o.OrderDate >= '2024-01-04' AND o.State = 'Tamamlanib'
ORDER BY o.OrderDate;

SELECT s.Id, s.Name, COUNT(*) AS OrderCount
FROM Sellers s
JOIN Orders o ON s.Id = o.SellerId
WHERE o.State = 'Tamamlanib'
GROUP BY s.Id, s.Name
HAVING COUNT(*) > 10
ORDER BY OrderCount DESC;

SELECT c.Id, c.Name, c.Surname, COUNT(*) AS OrderCount
FROM Customers c
JOIN Orders o ON c.Id = o.CustomerId
GROUP BY c.Id, c.Name, c.Surname
ORDER BY OrderCount DESC;

SELECT s.Name AS SellerName, s.City AS SellerCity, o.Id AS OrderId, o.OrderDate, o.State
FROM Orders o
JOIN Sellers s ON o.SellerId = s.Id
WHERE o.State != 'Tamamlanib'
ORDER BY o.OrderDate;

SELECT o.Id, o.OrderDate, o.Amount, o.State, c.Name AS CustomerName, s.Name AS SellerName
FROM Orders o
JOIN Customers c ON o.CustomerId = c.Id
JOIN Sellers s ON o.SellerId = s.Id
WHERE o.OrderDate >= DATEADD(MONTH, -1, GETDATE()) AND o.State = 'Tamamlanib'
ORDER BY o.OrderDate DESC;

