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



