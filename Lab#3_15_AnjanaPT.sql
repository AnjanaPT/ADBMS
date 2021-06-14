create database UNIVERSITY;
show databases;
use UNIVERSITY;

/* 1. Write appropriate MYSQL DDL statements to define the UNIVERSITY database.*/

CREATE TABLE STUDENT(
	Student_number int not null,
	Name varchar(50) not null,
    Class int not null,
    Major varchar(10) not null,
	primary key(Student_number));
 

CREATE TABLE COURSE(
	Course_number varchar(50) not null,
	Course_name varchar(50) not null,
    Credit_hours int not null,
    Department varchar(10) not null,
	primary key(Course_number));



CREATE TABLE SECTION(
	Section_identifier int not null,
    Course_number varchar(50) not null,
	Semester varchar(10) not null,
    Year int not null,
    Instructor varchar(50) not null,
	primary key(Section_identifier),
    foreign key (Course_number) references COURSE (Course_number)
    ON DELETE CASCADE ON UPDATE CASCADE);
 
 
 CREATE TABLE GRADE_REPORT(
	Section_identifier int not null,
    Student_number int not null,
	Grade char(2) not null,
	primary key(Section_identifier,Student_number),
    foreign key (Student_number) references STUDENT (Student_number)
    ON DELETE CASCADE ON UPDATE CASCADE,
	foreign key (Section_identifier) references SECTION (Section_identifier)
    ON DELETE CASCADE ON UPDATE CASCADE);

 

CREATE TABLE PREREQUISITE(
    Prerequisite_number varchar(50) not null,
    Course_number varchar(50) not null,
	primary key(Prerequisite_number,Course_number),
    foreign key (Course_number) references COURSE (Course_number)
    ON DELETE CASCADE ON UPDATE CASCADE);

show tables;

/* 2. Write queries to insert values in all the five tables. */

/* STUDENT */

INSERT INTO STUDENT (Student_number,Name,Class,Major) VALUES (17,'Smith',1,'CS');
INSERT INTO STUDENT (Student_number,Name,Class,Major) VALUES (8,'Brown',2,'CS');

/* COURSE */

INSERT INTO COURSE (Course_number,Course_name,Credit_hours,Department) VALUES ('CS1310','Intro to Computer Science',4,'CS');
INSERT INTO COURSE (Course_number,Course_name,Credit_hours,Department) VALUES ('CS3320','Data Structures',4,'CS');
INSERT INTO COURSE (Course_number,Course_name,Credit_hours,Department) VALUES ('MATH2410','Discrete Mathematics',3,'MATH');
INSERT INTO COURSE (Course_number,Course_name,Credit_hours,Department) VALUES ('CS3380','Database',3,'CS');

/* SECTION */

INSERT INTO SECTION (Section_identifier,Course_number,Semester,Year,Instructor) VALUES (85,'MATH2410','Fall',07,'King');
INSERT INTO SECTION (Section_identifier,Course_number,Semester,Year,Instructor) VALUES (92,'CS1310','Fall',07,'Anderson');
INSERT INTO SECTION (Section_identifier,Course_number,Semester,Year,Instructor) VALUES (102,'CS3320','Spring',08,'Knuth'); 
INSERT INTO SECTION (Section_identifier,Course_number,Semester,Year,Instructor) VALUES (112,'MATH2410','Fall',07,'Chang');
INSERT INTO SECTION (Section_identifier,Course_number,Semester,Year,Instructor) VALUES (119,'CS1310','Fall',07,'Anderson');
INSERT INTO SECTION (Section_identifier,Course_number,Semester,Year,Instructor) VALUES (135,'CS3380','fall',08,'Stone'); 


 /* GRADE REPORT */
 
INSERT INTO GRADE_REPORT (Section_identifier,Student_number,Grade) VALUES (112,17,'B');
INSERT INTO GRADE_REPORT (Section_identifier,Student_number,Grade) VALUES (119,17,'C');
INSERT INTO GRADE_REPORT (Section_identifier,Student_number,Grade) VALUES (85,8,'A');
INSERT INTO GRADE_REPORT (Section_identifier,Student_number,Grade) VALUES (92,8,'A');
INSERT INTO GRADE_REPORT (Section_identifier,Student_number,Grade) VALUES (102,8,'B');
INSERT INTO GRADE_REPORT (Section_identifier,Student_number,Grade) VALUES (135,8,'A');


/* PREREQUISITE */

INSERT INTO PREREQUISITE (Prerequisite_number,Course_number) VALUES ('CS3320','CS3380');
INSERT INTO PREREQUISITE (Prerequisite_number,Course_number) VALUES ('MATH2410','CS3380');
INSERT INTO PREREQUISITE (Prerequisite_number,Course_number) VALUES ('CS1310','CS3320');


select * from STUDENT;
describe STUDENT;
select * from COURSE;
describe COURSE;
select * from SECTION;
describe SECTION;
select * from GRADE_REPORT;
describe GRADE_REPORT;
select * from PREREQUISITE;
describe PREREQUISITE;



/* 3.Retrieve the list of all courses and grades of ‘Smith’ */
select Course_name,Grade from STUDENT s join GRADE_REPORT g on s.Student_number=g.Student_number join SECTION sc on sc.Section_identifier=g.Section_identifier join COURSE c on c.Course_number=sc.Course_number where Name='Smith'; 


/* 4. List the names of students who took the section of the ‘Database’ course offered in fall 2008 and their grades in that section */
select Name,Grade from STUDENT s join GRADE_REPORT g on s.Student_number=g.Student_number join SECTION sc on g.Section_identifier=sc.Section_identifier join COURSE c on c.Course_number=sc.Course_number where c.Course_name='Database' and sc.Semester='Fall' and Year=08;


/* 5. List the prerequisites of the ‘Database’ course */
select c.Course_name as PREREQUISITES_OF_THE_COURSE_DATABASE from PREREQUISITE p join COURSE c on c.Course_number=p.Prerequisite_number join COURSE crs on crs.Course_number=p.Course_number where crs.Course_name='Database';


/*  6. Retrieve the names of all senior students(Class 4) majoring in ‘CS’ (computer science). */
select Name from STUDENT where Major='CS' and Class=4;
select Name from STUDENT where Major='CS' and Class IN (select MAX(Class) from STUDENT);


/* 7. Retrieve the names of all courses taught by Professor King in 2007 and 2008 */
select Course_name from COURSE c join SECTION sc on c.Course_number=sc.Course_number where sc.Instructor='King' and Year IN (07,08);


/* 8. For each section taught by Professor King, retrieve the course number,semester, year, and number of students who took the section. */
select c.Course_number,Semester,Year,Count(g.Student_number) AS Number_Of_Students from STUDENT s join GRADE_REPORT g  on s.Student_number = g.Student_number join SECTION sc on sc.Section_identifier = g.Section_identifier join COURSE c on c.Course_number = sc.Course_number where sc.Instructor='King' GROUP BY sc.Section_identifier ;


/* 9. Retrieve the name and transcript of each senior student (Class = 4)majoring in CS. A transcript includes course name, course number, credit hours, semester, year, and grade for each course completed by the student. */ 
select s.Name,c.Course_name,c.Course_number,Credit_hours,Semester,Year,Grade from STUDENT s join GRADE_REPORT g on s.Student_number = g.Student_number join SECTION sc on sc.Section_identifier = g.Section_identifier join COURSE c on c.Course_number = sc.Course_number where s.Major = 'CS' and s.Class = 4;


/* 10. Write SQL update statements to do the following on the database schema. */
/* A. Insert a new student, <‘Johnson’, 25, 1, ‘Math’>, in the database. */
INSERT INTO STUDENT (Student_number,Name,Class,Major) VALUES (25,'Johnson',1,'MATH');

/* B. Change the class of student ‘Smith’ to 2. */
SET SQL_SAFE_UPDATES=0;
UPDATE STUDENT SET Class=2 WHERE Name='Smith';

/* C. Insert a new course, <‘Knowledge Engineering’, ‘CS4390’, 3, ‘CS’>. */
INSERT INTO COURSE (Course_number,Course_name,Credit_hours,Department) VALUES ('CS4390','Knowledge Engineering',3,'CS');

/* D. Delete the record for the student whose name is ‘Smith’ and whose student number is 17*/
DELETE FROM STUDENT WHERE Student_number=17;