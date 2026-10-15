CREATE DATABASE IF NOT exists college_placement_db;
USE college_placement_db;
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);
INSERT INTO departments (department_id, department_name)
VALUES
(1, 'Computer Science Engineering'),
(2, 'Artificial Intelligence and Machine Learning'),
(3, 'Electronics and Communication Engineering'),
(4, 'Information Science Engineering');
SELECT * FROM departments;
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    gender VARCHAR(10),
    department_id INT,
    cgpa DECIMAL(3,2),
    graduation_year INT,
    
    FOREIGN KEY (department_id)
    REFERENCES departments(department_id)
);
SHOW TABLES;
INSERT INTO students
(student_id, student_name, email, gender, department_id, cgpa, graduation_year)
VALUES
(101, 'Samiksha', 'samiksha@gmail.com', 'Female', 2, 8.30, 2027),
(102, 'Priya', 'priya@gmail.com', 'Female', 1, 9.00, 2027),
(103, 'Rahul', 'rahul@gmail.com', 'Male', 1, 8.10, 2027),
(104, 'Sneha', 'sneha@gmail.com', 'Female', 2, 7.80, 2027),
(105, 'Amit', 'amit@gmail.com', 'Male', 3, 8.50, 2027);
SELECT * FROM students;
SELECT
    s.student_id,
    s.student_name,
    d.department_name,
    s.cgpa
FROM students s
JOIN departments d
ON s.department_id = d.department_id;
USE college_placement_db;

CREATE TABLE subjects (
    subject_id INT PRIMARY KEY,
    subject_name VARCHAR(100) NOT NULL,
    department_id INT,
    semester INT,
    
    FOREIGN KEY (department_id)
    REFERENCES departments(department_id)
);
INSERT INTO subjects
(subject_id, subject_name, department_id, semester)
VALUES
(1, 'Machine Learning', 2, 6),
(2, 'Deep Learning', 2, 7),
(3, 'Database Management System', 1, 5),
(4, 'Computer Networks', 1, 6),
(5, 'Digital Electronics', 3, 5),
(6, 'Artificial Intelligence', 2, 6),
(7, 'Operating Systems', 1, 5),
(8, 'Data Structures', 1, 4);
SELECT * FROM subjects;
CREATE TABLE marks (
    mark_id INT PRIMARY KEY,
    student_id INT,
    subject_id INT,
    marks INT,
    
    FOREIGN KEY (student_id)
    REFERENCES students(student_id),
    
    FOREIGN KEY (subject_id)
    REFERENCES subjects(subject_id)
);
INSERT INTO marks
(mark_id, student_id, subject_id, marks)
VALUES
(1, 101, 1, 88),
(2, 101, 6, 91),
(3, 102, 3, 95),
(4, 102, 4, 89),
(5, 103, 3, 82),
(6, 103, 7, 85),
(7, 104, 1, 78),
(8, 104, 6, 84),
(9, 105, 5, 90),
(10, 105, 3, 87);
SELECT * FROM marks;
SELECT
    s.student_name,
    sub.subject_name,
    m.marks
FROM marks m
JOIN students s
    ON m.student_id = s.student_id
JOIN subjects sub
    ON m.subject_id = sub.subject_id;
    SELECT
    s.student_name,
    sub.subject_name,
    m.marks
FROM marks m
JOIN students s
    ON m.student_id = s.student_id
JOIN subjects sub
    ON m.subject_id = sub.subject_id
WHERE m.marks > 85;
SELECT MAX(marks) AS highest_marks
FROM marks;
SELECT
    s.student_name,
    sub.subject_name,
    m.marks
FROM marks m
JOIN students s
    ON m.student_id = s.student_id
JOIN subjects sub
    ON m.subject_id = sub.subject_id
ORDER BY m.marks DESC
LIMIT 1;
USE college_placement_db;
CREATE TABLE attendance (
    attendance_id INT PRIMARY KEY,
    student_id INT,
    subject_id INT,
    attendance_percentage DECIMAL(5,2),

    FOREIGN KEY (student_id)
    REFERENCES students(student_id),

    FOREIGN KEY (subject_id)
    REFERENCES subjects(subject_id)
);
INSERT INTO attendance
(attendance_id, student_id, subject_id, attendance_percentage)
VALUES
(1, 101, 1, 92.50),
(2, 101, 6, 88.00),
(3, 102, 3, 95.00),
(4, 102, 4, 91.50),
(5, 103, 3, 76.00),
(6, 103, 7, 82.00),
(7, 104, 1, 68.00),
(8, 104, 6, 74.50),
(9, 105, 5, 89.00),
(10, 105, 3, 93.00);
SELECT * FROM attendance;
SELECT
    s.student_name,
    sub.subject_name,
    a.attendance_percentage
FROM attendance a
JOIN students s
    ON a.student_id = s.student_id
JOIN subjects sub
    ON a.subject_id = sub.subject_id
WHERE a.attendance_percentage < 75;
SELECT
    s.student_name,
    a.attendance_percentage
FROM attendance a
JOIN students s
    ON a.student_id = s.student_id
WHERE a.attendance_percentage >= 75;
SELECT
    AVG(attendance_percentage) AS average_attendance
FROM attendance;
SELECT
    MAX(attendance_percentage) AS highest_attendance
FROM attendance;
USE college_placement_db;
CREATE TABLE companies (
    company_id INT PRIMARY KEY,
    company_name VARCHAR(100) NOT NULL,
    industry VARCHAR(100),
    location VARCHAR(100),
    minimum_cgpa DECIMAL(3,2)
);
INSERT INTO companies
(company_id, company_name, industry, location, minimum_cgpa)
VALUES
(1, 'TCS', 'IT Services', 'Bengaluru', 7.00),
(2, 'Infosys', 'IT Services', 'Bengaluru', 6.50),
(3, 'Accenture', 'Consulting & IT', 'Bengaluru', 7.00),
(4, 'Wipro', 'IT Services', 'Hyderabad', 6.50),
(5, 'Deloitte', 'Consulting', 'Bengaluru', 7.50);
SELECT * FROM companies;
CREATE TABLE placements (
    placement_id INT PRIMARY KEY,
    student_id INT,
    company_id INT,
    package_lpa DECIMAL(5,2),
    placement_date DATE,
    status VARCHAR(20),

    FOREIGN KEY (student_id)
    REFERENCES students(student_id),

    FOREIGN KEY (company_id)
    REFERENCES companies(company_id)
);
INSERT INTO placements
(placement_id, student_id, company_id, package_lpa, placement_date, status)
VALUES
(1, 101, 1, 6.00, '2026-08-10', 'Selected'),
(2, 102, 2, 7.50, '2026-08-12', 'Selected'),
(3, 103, 3, 8.00, '2026-08-15', 'Selected'),
(4, 105, 5, 9.00, '2026-08-20', 'Selected');
SELECT * FROM placements;
SELECT
    s.student_name,
    c.company_name,
    p.package_lpa,
    p.placement_date,
    p.status
FROM placements p
JOIN students s
    ON p.student_id = s.student_id
JOIN companies c
    ON p.company_id = c.company_id;
    SELECT
    MAX(package_lpa) AS highest_package
FROM placements;
SELECT
    s.student_name,
    c.company_name,
    p.package_lpa
FROM placements p
JOIN students s
    ON p.student_id = s.student_id
JOIN companies c
    ON p.company_id = c.company_id
ORDER BY p.package_lpa DESC
LIMIT 1;
SELECT
    AVG(package_lpa) AS average_package
FROM placements;
SELECT
    c.company_name,
    COUNT(p.student_id) AS students_placed
FROM companies c
JOIN placements p
    ON c.company_id = p.company_id
GROUP BY c.company_name;
SELECT
    s.student_id,
    s.student_name
FROM students s
LEFT JOIN placements p
    ON s.student_id = p.student_id
WHERE p.student_id IS NULL;