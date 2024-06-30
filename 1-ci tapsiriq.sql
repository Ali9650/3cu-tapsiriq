Create DATABASE DemoApp 
USE DemoApp 
Create TABLE People   (
Id INT PRIMARY KEY IDENTITY (1,1),
Name NVARCHAR (50) NOT NULL,
Surname NVARCHAR (50) NOT NULL,
PhoneNumber NVARCHAR (50) DEFAULT ('+994000000000'),
Email NVARCHAR (50) NOT NULL UNIQUE,
Age INT CHECK (Age>=18),
Gender NVARCHAR (10) NOT NULL,
HasCitizenship Bit,
CityId int FOREIGN KEY REFERENCES Cities(Id)
)
Create TABLE Countries (
Id INT PRIMARY KEY IDENTITY (1,1),
Name NVARCHAR (50) NOT NULL,
Area Decimal (10,2)
)
Create TABLE Cities  (
Id INT PRIMARY KEY IDENTITY (1,1),
Name NVARCHAR (50) NOT NULL,
Area Decimal (10,2),
CountryId int FOREIGN KEY REFERENCES Countries(Id)
)
INSERT INTO Countries 
VALUES ('Azerbaycan', 84.4),
 ('Turkiye', 456)


INSERT INTO Cities 
VALUES ('Baki', 45.4, 1),
('Istanbul', 45, 2)

INSERT INTO People 
VALUES ('Ali', 'Cahangirov', '+994504265002', 'alik9650@gmail.com', 25, 'Male', 1, 1),
 ('Samir', 'Abbasov', '+9945055050500', 'samir@mail.ru', 28, 'Male', 1, 2)

SELECT * FROM People

SELECT People.Name, People.Surname, People.PhoneNumber, People.Email, People.Age, People.Gender, Countries.Name as Country_Name, Cities.Name as City_Name
FROM People
 JOIN Cities ON CityId = Cities.Id
 JOIN Countries ON Cities.CountryId=Countries.Id

SELECT * FROM Countries
ORDER BY Area;

SELECT * FROM Cities
ORDER BY Name;

SELECT COUNT(*)
FROM Countries
WHERE Area > 20000;

SELECT MAX(Area)
FROM Countries
WHERE Name LIKE 'I%';

SELECT Name FROM Countries
UNION
SELECT Name FROM Cities;

SELECT CityId, COUNT(*) AS PersonCount
FROM People
GROUP BY CityId;




SELECT SUM(p.CityId) as [Count], c.Name
FROM People p
INNER JOIN Cities c ON p.CityId = c.Id
GROUP BY c.Name
HAVING Sum(p.CityId) > 50000

