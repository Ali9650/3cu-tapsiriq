Create DATABASE Movie 
USE Movie 

CREATE TABLE Movies  (
    Id INT PRIMARY KEY IDENTITY (1,1),
    Name VARCHAR(50) NOT NULL,
    ReleaseDate DATE,
    IMDB DECIMAL(3,1)
);

CREATE TABLE Actors   (
    Id INT PRIMARY KEY IDENTITY (1,1),
    Name VARCHAR(50) NOT NULL,
    Surname VARCHAR(50) NOT NULL   
);

CREATE TABLE Genres    (
    Id INT PRIMARY KEY IDENTITY (1,1),
    Name VARCHAR(50) NOT NULL
	);

	Create Table MovieActors(
	Id integer PRIMARY KEY IDENTITY(1,1),
	MovieId int FOREIGN KEY REFERENCES Movies(Id),
	ActorId int FOREIGN KEY REFERENCES Actors(Id)
)

Create Table MovieGenres(
	Id integer PRIMARY KEY IDENTITY(1,1),
	MovieId int FOREIGN KEY REFERENCES Movies(Id),
	GenreId int FOREIGN KEY REFERENCES Genres (Id)
);


INSERT INTO Movies (Name, ReleaseDate, IMDB)
VALUES
    ('Inception', '2010-07-16', 8.8),
    ('The Dark Knight', '2008-07-18', 9.0),
    ('Interstellar', '2014-11-07', 8.6),
    ('The Shawshank Redemption', '1994-09-23', 9.3),
    ('Pulp Fiction', '1994-10-14', 8.9),
    ('Fight Club', '1999-10-15', 8.8),
    ('The Matrix', '1999-03-31', 8.7),
    ('The Lord of the Rings: The Fellowship of the Ring', '2001-12-19', 8.8),
    ('The Godfather', '1972-03-24', 9.2),
    ('Forrest Gump', '1994-07-06', 8.8);

	
INSERT INTO Actors (Name, Surname)
VALUES
    ('Leonardo', 'DiCaprio'),
    ('Christian', 'Bale'),
    ('Tom', 'Hanks'),
    ('Morgan', 'Freeman'),
    ('Bruce', 'Willis'),
    ('Keanu', 'Reeves'),
    ('Al', 'Pacino'),
    ('Robert', 'De Niro'),
    ('Brad', 'Pitt'),
    ('Samuel', 'L. Jackson');

	
INSERT INTO Genres (Name)
VALUES
    ('Action'),
    ('Adventure'),
    ('Comedy'),
    ('Crime'),
    ('Drama'),
    ('Fantasy'),
    ('Horror'),
    ('Mystery'),
    ('Sci-Fi'),
    ('Thriller');
	
INSERT INTO MovieActors (MovieId, ActorId)
VALUES
    (1, 1), -- Leonardo DiCaprio
    (1, 2); -- Joseph Gordon-Levitt

-- For movie "The Dark Knight"
INSERT INTO MovieActors (MovieId, ActorId)
VALUES
    (2, 2), -- Christian Bale
    (2, 4); -- Morgan Freeman

-- For movie "Interstellar"
INSERT INTO MovieActors (MovieId, ActorId)
VALUES
    (3, 1), -- Leonardo DiCaprio
    (3, 6); -- Matthew McConaughey

-- For movie "The Shawshank Redemption"
INSERT INTO MovieActors (MovieId, ActorId)
VALUES
    (4, 4), -- Morgan Freeman
    (4, 9); -- Tim Robbins


-- For movie "Inception"
INSERT INTO MovieGenres (MovieId, GenreId)
VALUES
    (1, 1), -- Action
    (1, 3); -- Sci-Fi

-- For movie "The Dark Knight"
INSERT INTO MovieGenres (MovieId, GenreId)
VALUES
    (2, 1), -- Action
    (2, 5); -- Drama

-- For movie "Interstellar"
INSERT INTO MovieGenres (MovieId, GenreId)
VALUES
    (3, 3), -- Sci-Fi
    (3, 5); -- Drama

-- For movie "The Shawshank Redemption"
INSERT INTO MovieGenres (MovieId, GenreId)
VALUES
    (4, 5), -- Drama
    (4, 7); -- Mystery

-- Add more associations as needed for other movies and genres

SELECT Actors.Name, Actors.Surname, COUNT(*) AS NumRoles
FROM Actors
JOIN MovieActors ON Actors.Id = MovieActors.ActorId
GROUP BY Actors.Id, Actors.Name, Actors.Surname
ORDER BY NumRoles DESC;

SELECT Genres.Name, COUNT(*) AS NumMovies
FROM Genres
LEFT JOIN MovieGenres ON Genres.Id = MovieGenres.GenreId
GROUP BY Genres.Id, Genres.Name;

SELECT Name AS MovieName, ReleaseDate
FROM Movies
WHERE ReleaseDate IS NOT NULL
ORDER BY ReleaseDate;

SELECT AVG(IMDB) AS AvgIMDB
FROM Movies
WHERE ReleaseDate >= DATEADD(YEAR, -5, GETDATE());

SELECT Actors.Name, Actors.Surname, COUNT(DISTINCT MovieActors.MovieId) AS NumMovies
FROM Actors
JOIN MovieActors ON Actors.Id = MovieActors.ActorId
GROUP BY Actors.Id, Actors.Name, Actors.Surname
HAVING COUNT(DISTINCT MovieActors.MovieId) > 1
ORDER BY NumMovies DESC;
