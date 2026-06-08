CREATE DATABASE StudentManagementSystem;
USE StudentManagementSystem;
CREATE TABLE Students (
    Student_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Department VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15)
);
SELECT * FROM Students;
CREATE TABLE Courses (
    Course_ID INT PRIMARY KEY AUTO_INCREMENT,
    Course_Name VARCHAR(100) NOT NULL,
    Credits INT
);
CREATE TABLE Enrollments (
    Enrollment_ID INT PRIMARY KEY AUTO_INCREMENT,
    Student_ID INT,
    Course_ID INT,
    FOREIGN KEY (Student_ID) REFERENCES Students(Student_ID),
    FOREIGN KEY (Course_ID) REFERENCES Courses(Course_ID)
);
CREATE TABLE Attendance (
    Attendance_ID INT PRIMARY KEY AUTO_INCREMENT,
    Student_ID INT,
    Course_ID INT,
    Attendance_Date DATE,
    Status ENUM('Present', 'Absent'),
    FOREIGN KEY (Student_ID) REFERENCES Students(Student_ID),
    FOREIGN KEY (Course_ID) REFERENCES Courses(Course_ID)
);
CREATE TABLE Grades (
    Grade_ID INT PRIMARY KEY AUTO_INCREMENT,
    Student_ID INT,
    Course_ID INT,
    Marks INT,
    Grade CHAR(2),
    FOREIGN KEY (Student_ID) REFERENCES Students(Student_ID),
    FOREIGN KEY (Course_ID) REFERENCES Courses(Course_ID)
);
INSERT INTO Students (Name, Department, Email, Phone)
VALUES
('Krishnan', 'IT', 'krishnan@gmail.com', '9876543210'),
('Arun', 'CSE', 'arun@gmail.com', '9876543211'),
('Priya', 'ECE', 'priya@gmail.com', '9876543212');
INSERT INTO Courses (Course_Name, Credits)
VALUES
('Database Management System', 4),
('Data Structures', 3),
('Operating Systems', 4);
INSERT INTO Enrollments (Student_ID, Course_ID)
VALUES
(1,1),
(1,2),
(2,1),
(3,3);
INSERT INTO Attendance
(Student_ID, Course_ID, Attendance_Date, Status)
VALUES
(1,1,'2026-06-01','Present'),
(1,1,'2026-06-02','Absent'),
(2,1,'2026-06-01','Present'),
(3,3,'2026-06-01','Present');
INSERT INTO Grades
(Student_ID, Course_ID, Marks, Grade)
VALUES
(1,1,90,'A'),
(1,2,85,'A'),
(2,1,78,'B'),
(3,3,92,'A');
#crud operations
SELECT * FROM Students;
UPDATE Students
SET Phone = '9999999999'
WHERE Student_ID = 1;
DELETE FROM Students
WHERE Student_ID = 3;
SELECT * FROM Attendance WHERE Student_ID = 3;
DELETE FROM Attendance
WHERE Student_ID = 3;
DELETE FROM Grades
WHERE Student_ID = 3;
DELETE FROM Enrollments
WHERE Student_ID = 3;
DELETE FROM Students
WHERE Student_ID = 3;
SELECT s.Name,
       c.Course_Name,
       g.Marks,
       g.Grade
FROM Grades g
JOIN Students s ON g.Student_ID = s.Student_ID
JOIN Courses c ON g.Course_ID = c.Course_ID;
SELECT s.Name,
       ROUND(
         SUM(CASE WHEN a.Status='Present' THEN 1 ELSE 0 END)
         *100.0/COUNT(*),2
       ) AS Attendance_Percentage
FROM Attendance a
JOIN Students s
ON a.Student_ID=s.Student_ID
GROUP BY s.Name;
SELECT s.Name,
       AVG(g.Marks) AS Average_Marks
FROM Grades g
JOIN Students s
ON g.Student_ID=s.Student_ID
GROUP BY s.Name
ORDER BY Average_Marks DESC;