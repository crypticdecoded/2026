DROP TABLE IF EXISTS loans CASCADE;
DROP TABLE IF EXISTS books CASCADE;
DROP TABLE IF EXISTS members CASCADE;


CREATE TABLE members (
	member_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	email VARCHAR(100) UNIQUE NOT NULL,
	join_date DATE NOT NULL
);

CREATE TABLE books (
	book_id SERIAL PRIMARY KEY,
	title VARCHAR(150) NOT NULL,
	author VARCHAR(100) NOT NULL,
	genre VARCHAR(50),
	year INT,
	available BOOLEAN DEFAULT TRUE
)

	

CREATE TABLE loans (
	loan_id SERIAL PRIMARY KEY,
	member_id INT NOT NULL REFERENCES  members(member_id)
	book_id INT NOT NULL REFERENCES books(book_id),
	loan_date DATE NOT NULL,
	return_date DATE
	)

INSERT INTO members (first_name, last_name, email, join_date) VALUES
	('Alice', 'Johnson', 'alice@email.com', '2023-01-15'),
	('Bob', 'Smith', 'bob@email.com', '2023-03-22'),
	('Clara', 'David', 'clara@email', '2023-06-10'),
	('David', 'Lee', 'david@emailcom', '2024-01-05'),
	('Eva', 'Martin', 'eva@email.com', '2024-03-18');

INSERT INTO books (title, author, genre, year, available) VALUES
	('The Great Gatsby', 'F. Scott Fitzgerald', 	'Fiction',	1925,	TRUE),
	('To Kill a Mockingbird', 'Harper Lee',	'Fiction',	1960,	TRUE),
	 ('1984', 'George Orwell', 'Dystopian', 1949, FALSE),
    ('Sapiens', 'Yuval Noah Harari',  'Non-Fiction',  2011, TRUE),
    ('Dune', 'Frank Herbert', 'Sci-Fi',  1965, FALSE),
    ('Atomic Habits', 'James Clear', 'Non-Fiction',  2018, TRUE),
    ('The Alchemist', 'Paulo Coelho', 'Fiction',      1988, TRUE);

INSERT INTO loans (member_id, book_id, loan_date, return_date) VALUES
	(1, 3, '2024-04-01', '2024-04-15'),
	(2, 5, '2024-04-10', NULL),
	(3, 1, '2024-04-12', '2024-04-20'),
	(1, 6, '2024-05-01', NULL),
	(4, 2, '2024-05-05', '2024-05-19');

SELECT * FROM members;

SELECT * FROM books;

SELECT first_name, last_name, email FROM members;

SELECT
	title		AS book_title,
	author		AS written_by,
	year		AS published
FROM books;

SELECT * FROM books WHERE available = TRUE;

SELECT title, year FROM books WHERE year > 1960;

SELECT * FROM members WHERE email = 'bob@email.com';

SELECT title, genre FROM books WHERE genre = 'Fiction'	OR genre = 'Sci-Fi';

SELECT title, year FROM books WHERE year BETWEEN 1950 AND 2000;

SELECT title FROM books WHERE title ILIKE '%the%';


SELECT first_name, last_name, join_date
FROM members
ORDER BY join_date DESC
LIMIT 3;


SELECT COUNT(*)	AS total_books FROM books;
SELECT COUNT(*) AS available_books FROM books WHERE available = TRUE;
SELECT MIN(year)	AS oldest, MAX(year)	AS newest FROM books;
SELECT ROUND(AVG(year), 0) AS avg_year FROM books;

SELECT genre, COUNT(*) AS total
FROM books
GROUP BY genre
ORDER BY total DESC;


UPDATE books SET available = FALSE WHERE book_id = 6;

UPDATE members SET first_name = 'Claire' WHERE member_id = 3;

UPDATE loans SET return_date = '2024-05-20' WHERE loan_id = 4;




SELECT
	m.first_name,
	m.last_name,
	b.title,
	l.loan_date,
	l.return_date
FROM loans l
INNER JOIN members m ON l.member_id = m.member_id
INNER JOIN books b ON l.book_id	= b.book_id
ORDER BY l.loan_date;

SELECT
	m.first_name,
	m.last_name,
	l.loan_id
FROM members m
LEFT JOIN loans l ON m.member_id = l.member_id
WHERE l.loan_id IS NULL;


SELECT
	b.title,
	m.first_name,
	m.last_name,
	l.loan_date
FROM loans l
INNER JOIN books b ON l.book_id = b.book_id
INNER JOIN members m ON l.member_id = m.member_id
WHERE l.return_date IS NULL;

SELECT
	m.first_name || ' ' || m.last_name AS member,
	b.title							AS book,
	b.genre,
	l.loan_date,
	CASE
		WHEN l.return_date IS NOT NULL THEN 'Returned'
		ELSE 'Still on loan'
	END AS status
FROM loans l
INNER JOIN members m ON l.member_id = m.member_id
INNER JOIN books b ON l.book_id = b.book_id
ORDER BY l.loan_date;
	







