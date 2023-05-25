
DROP TABLE IF EXISTS enrollments
DROP TABLE IF EXISTS courses
DROP TABLE IF EXISTS students


-- TABULU IZVEIDE

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name NVARCHAR(50),
    last_name NVARCHAR(50),
    birthdate DATE,
    major NVARCHAR(50)
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name NVARCHAR(50),
    faculty NVARCHAR(50)
);

CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT FOREIGN KEY REFERENCES students(student_id),
    course_id INT FOREIGN KEY REFERENCES courses(course_id)
);

-- DATU IEVADE

INSERT INTO students(student_id, first_name, last_name, birthdate, major)
VALUES
(1, 'John', 'Doe', '2001-07-15', 'Computer Science'),
(2, 'Emma', 'Smith', '2000-12-01', 'Biology'),
(3, 'David', 'Johnson', '2002-01-20', 'Mathematics'),
(4, 'Olivia', 'Williams', '2001-11-11', 'English Literature'),
(5, 'Michael', 'Brown', '2002-04-18', 'Chemistry'),
(6, 'Sophia', 'Martinez', '2000-09-21', 'Physics'),
(7, 'Benjamin', 'Anderson', '2001-02-15', 'History'),
(8, 'Amelia', 'Taylor', '2000-07-08', 'Psychology'),
(9, 'Lucas', 'Thomas', '2001-05-17', 'Economics'),
(10, 'Mia', 'Rodriguez', '2002-08-12', 'Philosophy'),
(11, 'Elijah', 'Roberts', '2001-06-03', 'Computer Science'),
(12, 'Ava', 'Jackson', '2000-08-24', 'Biology'),
(13, 'Daniel', 'Walker', '2002-05-15', 'Mathematics'),
(14, 'Isabella', 'Moore', '2000-10-10', 'English Literature'),
(15, 'Matthew', 'Harris', '2002-03-22', 'Chemistry'),
(21, 'Mason', 'Wilson', '2002-04-09', 'Computer Science'),
(22, 'Ella', 'Miller', '2001-06-18', 'Biology'),
(23, 'Logan', 'Davis', '2000-09-29', 'Mathematics'),
(24, 'Avery', 'Garcia', '2001-08-03', 'English Literature'),
(25, 'Aiden', 'Martin', '2002-07-21', 'Chemistry'),
(26, 'Scarlett', 'White', '2001-05-30', 'Physics'),
(27, 'James', 'Baker', '2002-12-07', 'History'),
(28, 'Chloe', 'Hill', '2001-03-14', 'Psychology'),
(29, 'Noah', 'Edwards', '2002-07-20', 'Economics'),
(30, 'Madison', 'Parker', '2000-11-08', 'Philosophy');

INSERT INTO courses(course_id, course_name, faculty)
VALUES
(101, 'Introduction to Computer Science', 'Engineering'),
(102, 'Cell Biology', 'Natural Sciences'),
(103, 'Calculus II', 'Mathematics'),
(104, 'Shakespearean Literature', 'Humanities'),
(105, 'Organic Chemistry', 'Natural Sciences'),
(106, 'Classical Physics', 'Physics'),
(107, 'World War II History', 'History'),
(108, 'Psychology 101', 'Social Sciences'),
(109, 'Macroeconomics', 'Business'),
(110, 'Introduction to Philosophy', 'Humanities'),
(111, 'Data Structures and Algorithms', 'Engineering'),
(112, 'Molecular Biology', 'Natural Sciences'),
(113, 'Algebra', 'Mathematics'),
(114, 'Modern English Literature', 'Humanities'),
(115, 'Physical Chemistry', 'Natural Sciences'),
(121, 'Artificial Intelligence', 'Engineering'),
(122, 'Genetics', 'Natural Sciences'),
(123, 'Statistics', 'Mathematics'),
(124, 'Post-Colonial Literature', 'Humanities'),
(125, 'Inorganic Chemistry', 'Natural Sciences'),
(126, 'Theoretical Physics', 'Physics'),
(127, 'Medieval History', 'History'),
(128, 'Cognitive Psychology', 'Social Sciences'),
(129, 'International Economics', 'Business'),
(130, 'Philosophy of Mind', 'Humanities');

INSERT INTO enrollments(enrollment_id, student_id, course_id)
VALUES
(201, 1, 101),
(202, 2, 102),
(203, 3, 103),
(204, 4, 104),
(205, 5, 105),
(206, 6, 106),
(207, 7, 107),
(208, 8, 108),
(209, 9, 109),
(210, 10, 110),
(211, 11, 111),
(212, 12, 112),
(213, 13, 113),
(214, 14, 114),
(215, 15, 115),
(221, 21, 121),
(222, 21, 122),
(223, 22, 122),
(224, 23, 123),
(225, 24, 124),
(226, 25, 125),
(227, 21, 123),
(228, 21, 124),
(229, 21, 125),
(231, 26, 126),
(232, 26, 127),
(233, 27, 127),
(234, 28, 128),
(235, 29, 129),
(236, 30, 130),
(237, 26, 128),
(238, 26, 129),
(239, 26, 130);

-- VAICĀJUMI

SELECT s.first_name, s.last_name, c.course_name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE c.faculty = 'Engineering';

SELECT
    MAX(course_count) as max_enrollment,
    MIN(course_count) as min_enrollment,
    AVG(CAST(course_count AS FLOAT)) as avg_enrollment
FROM
(
    SELECT COUNT(course_id) as course_count
    FROM Enrollments
    GROUP BY student_id
) AS student_enrollment_counts;

SELECT c.faculty, s.major, COUNT(e.enrollment_id) as "studentu skaits"
FROM enrollments e
JOIN Students s ON e.student_id = s.student_id
JOIN Courses c ON e.course_id = c.course_id
GROUP BY s.major, c.faculty;

SELECT s.first_name, s.last_name, (SELECT COUNT(*) FROM Enrollments e WHERE e.student_id = s.student_id) as "kursu skaits"
FROM students s
ORDER BY "kursu skaits" DESC;

SELECT s.student_id, s.first_name, s.last_name
FROM Students s
WHERE s.student_id IN (
    SELECT e.student_id
    FROM Enrollments e
    GROUP BY e.student_id
    HAVING COUNT(e.course_id) >= 2
);
