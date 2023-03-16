CREATE TABLE submissions (
	id INT IDENTITY(1,1) PRIMARY KEY
	time DATETIME
	user_id INT NOT NULL
	task_id INT NOT NULL
	language VARCHAR(20)
	source_code VARCHAR(10000)
	CONSTRAINT fk_submission_user FOREIGN KEY (user_id)
	REFERENCES users(id)
);

CREATE TABLE users (
	id INT IDENTITY(1,1) PRIMARY KEY
	username VARCHAR(64) NOT NULL UNIQUE
	password VARCHAR(128) NOT NULL
	first_name VARCHAR(64)
	last_name VARCHAR(64)
	email VARCHAR(128) NOT NULL UNIQUE
);

CREATE TABLE task (
	id [INT] [PRIMARY KEY] [AUTO INCREMENT]
	checker [VARCHAR]
);
