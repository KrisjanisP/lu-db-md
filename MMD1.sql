DROP TABLE IF EXISTS submissions
DROP TABLE IF EXISTS tasks
DROP TABLE IF EXISTS users

CREATE TABLE users (
	id INT IDENTITY(1,1) PRIMARY KEY,
	username VARCHAR(64) NOT NULL UNIQUE,
	password VARCHAR(128) NOT NULL,
	first_name VARCHAR(64),
	last_name VARCHAR(64),
	email VARCHAR(128) NOT NULL UNIQUE
);

CREATE TABLE tasks (
    id INT PRIMARY KEY,
    name VARCHAR(64)
);

CREATE TABLE submissions (
    id INT IDENTITY(1,1) PRIMARY KEY,
    task_id INT NOT NULL,
    user_id INT NOT NULL,
    subm_time DATETIME DEFAULT GETDATE(),
    CONSTRAINT fk_submission_task FOREIGN KEY (task_id)
                         REFERENCES tasks(id),
    CONSTRAINT fk_submission_user FOREIGN KEY (user_id)
                         REFERENCES users(id)
)

INSERT INTO users(username,password,first_name,last_name,email)
VALUES ('KrisjanisP', 'password1', 'Krišjānis', 'Petručeņa', 'krisjanispetrucena@gmail.com'),
       ('AnsisG', 'password2', 'Ansis', 'Andersons', 'ansisandersons@gmail.com'),
       ('Valters07', 'password3', 'Valters', 'Kalniņš', 'valterskalnins@gmail.com'),
       ('ievins', 'passowrd4', 'Raivis', 'Ieviņš', 'raivisievins@gmail.com'),
       ('Askola', 'password5', 'Mārtiņš', 'Opmanis', 'martinsopmanis@gmail.com');

INSERT INTO tasks
VALUES (1, 'divi'),
       (3, 'iberian'),
       (5, 'candies'),
       (7, 'minesweeper'),
       (9, 'pascal');

INSERT INTO submissions(task_id, user_id)
SELECT tasks.id, users.id FROM users CROSS JOIN tasks;

SELECT * FROM submissions WHERE user_id = 1 AND task_id <> 3 AND subm_time IS NOT NULL
                          ORDER BY task_id DESC -- selects all user 1 submission except for task 3 and orders by task id descending

SELECT users.username, tasks.name FROM users
    JOIN submissions on users.id = submissions.user_id
    JOIN tasks on tasks.id = submissions.task_id
ORDER BY users.username -- shows all users and the respective tasks that they have attempted to solve

DELETE FROM submissions
DELETE FROM tasks
DELETE FROM users

DROP TABLE submissions
DROP TABLE tasks
DROP TABLE users