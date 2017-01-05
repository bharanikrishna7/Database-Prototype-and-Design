------------------------------------------------------------------
------------------------------------------------------------------
-- COURSE 	: CSR 581 Introduction to Database Management 		--
-- SEMESTER : Fall 2016											--
-- AUTHOR 	: Venkata Bharani Krishna Chekuri					--
-- SUID 	: 356579351											--
-- VERSION  : 1.0												--
-- DATE 	: 12/10/2016 										--
------------------------------------------------------------------
------------------------------------------------------------------

------------------------------------------------------------------
-- 						   REQUIREMENT 01						--							
-- 							  DESIGN 							--
------------------------------------------------------------------
-- 1. In my First Project the Lookup Tables were not Created Prop-
-- -erly. And I lost considerable points for this.
-- 
-- 2. The Course Enrollment of Students was Not Polished and Coun- 
-- -ter Intuitive.
--
-- Used Some parts of the Instructors Code :
-- 		* Employee Job Information.
--		* Lookup Tables for Employee Benefits.
--		* Course Enrollment
-- 
-- Modified :
-- 		* Course Schedule Table to Store Course Information for
--		  every Semester (if offered).
--		  Also Supports Class Sections.
--
-- Supports :
-- 		* Student Can have Multiple Majors & Multiple Minors.
--		* Student Can Repeat a Course in Other Semesters.  
--		* Flexibility to set Class Time & Class Room for 
--		  Each Section of Each Course Every Semester.
--			ex: A course CIS 500 for Fall 2016 can have
--			    following schedule :-
--				Monday - 10:00 am to 11:30 am - Classroom 1
--				Friday - 09:00 am to 12:30 pm - Classroom 2
---------------------------------------------------------------


----------------------------------
--       DATABASE SCHEMA        --
----------------------------------
-- Create Schema for Project
CREATE SCHEMA prj AUTHORIZATION vbchekur;



------------------------------------------------------------------
-- 						   REQUIREMENT 02						--							
-- 						   TABLE CREATION 						--
------------------------------------------------------------------
-------------------
-- LOOKUP TABLES --
-------------------
-- Create Health Benefits Lookup Table
-- Lookup for Health Benefits availaible for College Employees.
CREATE TABLE prj.HealthBenefitLkp (
	BenefitSelectionId	SMALLINT		PRIMARY KEY		IDENTITY(1,1),
	HealthBenefit		VARCHAR(40)		NOT NULL		UNIQUE
	);

-- Create Vision Benefits Lookup Table
-- Lookup for Vision Benefits availaible for College Employees.
CREATE TABLE prj.VisionBenefitLkp (
	BenefitSelectionId	SMALLINT		PRIMARY KEY		IDENTITY(1,1),
	VisionBenefit		VARCHAR(40)		NOT NULL		UNIQUE
	);

-- Create Dental Benefits Lookup Table
-- Lookup for Dental Benefits availaible for College Employees.
CREATE TABLE prj.DentalBenefitLkp (
	BenefitSelectionId	SMALLINT		PRIMARY KEY		IDENTITY(1,1),
	DentalBenefit		VARCHAR(40)		NOT NULL		UNIQUE
	);

-- Create Days Lookup Table
-- Lookup for Days of a Week
CREATE TABLE prj.DaysLkp (
	DayId				TINYINT			PRIMARY KEY		IDENTITY(1,1),
	DayText				VARCHAR(10)		NOT NULL		UNIQUE
	);

-- Create Projector Lookup Table
-- Lookup for projectors being used by College.
CREATE TABLE prj.ProjectorLkp (
	ProjectorId			SMALLINT		PRIMARY KEY		IDENTITY(1,1),
	ProjectorText		VARCHAR(100)	NOT NULL		UNIQUE
	);

-- Create Building Lookup Table
-- Lookup for Buildings belonging to College.
CREATE TABLE prj.BuildingLkp (
	BuildingId			SMALLINT		PRIMARY KEY		IDENTITY(1,1),
	BuildingName		VARCHAR(100)	NOT NULL		UNIQUE
	);

-- Create School Lookup Table
-- Lookup for Schools present in the University.
CREATE TABLE prj.SchoolLkp (
	SchoolId			TINYINT			PRIMARY KEY		IDENTITY(1,1),
	SchoolName			VARCHAR(100)	NOT NULL		UNIQUE
	);

-- Create Student Status Lookup Table
-- Lookup for Status Associated with a Student.
CREATE TABLE prj.StudentStatusLkp (
	StudentStatusId		TINYINT			PRIMARY KEY		IDENTITY(1,1),
	StudentStatus		VARCHAR(20)		NOT NULL		UNIQUE
	);

-- Create Grades Lookup Table
-- Lookup for Letter Grades.
CREATE TABLE prj.GradesLkp (
	GradeId				TINYINT			PRIMARY KEY		IDENTITY(1,1),
	Grade				VARCHAR(2)		NOT NULL		UNIQUE
	);

-- Create Enrollment Status Lookup Table
-- Lookup for Course Enrollment Status (Previously Enrolled, Currently Enrolled)
CREATE TABLE prj.EnrollmentStatusLkp (
	EnrollmentStatusId	TINYINT			PRIMARY KEY		IDENTITY(1,1),
	EnrollmentStatus	VARCHAR(15)		NOT NULL		UNIQUE
	);

-- Create Semester Lookup Table
-- Lookup for Semesters of the University
CREATE TABLE prj.SemesterLkp (
	SemesterNameId		TINYINT			PRIMARY KEY		IDENTITY(1,1),
	SemesterName		VARCHAR(15)		NOT NULL		UNIQUE
	);

-- Create Academic Year Lookup Table
-- Lookupo for Academic Years for Scheduling Courses
CREATE TABLE prj.AcademicYearLkp (
	YearId				INTEGER			PRIMARY KEY		IDENTITY(1,1),
	YearText			INTEGER			UNIQUE
	);

-----------------------------------
-- TABLES WITH 1-M RELATIONSHIPS --
-----------------------------------
-- Create Address Table
-- Table to Store Addresses associated with Students and Employees
CREATE TABLE prj.Address (
	AddressId			INTEGER			PRIMARY KEY		IDENTITY(1,1),
	Address1			VARCHAR(70)		NOT NULL,
	Address2			VARCHAR(70),
	City				VARCHAR(58)		NOT NULL,
	State				CHAR(2)			NOT NULL,
	Country				VARCHAR(50)		NOT NULL
	);

-- Create Job Information Table
-- Table to Store Jobs offered by the University.
CREATE TABLE prj.JobInformation (
	JobId				SMALLINT		PRIMARY KEY		IDENTITY(1,1),
	JobName				VARCHAR(50)		NOT NULL,
	JobDescription		VARCHAR(500)	NOT NULL,
	JobRequirements		VARCHAR(500),
	MinPay				DECIMAL(7,2)	NOT NULL,
	MaxPay				DECIMAL(8,2)	NOT NULL
	);

-- Create Course Catalogue Table
-- Table to Store the Courses previously offered or currently being offered by the University.
CREATE TABLE prj.CourseCatalogue (
	CourseCode			CHAR(3)			NOT NULL,
	CourseNumber		SMALLINT		NOT NULL,
	CourseTitle			VARCHAR(50)		NOT NULL,
	CourseDescription	VARCHAR(500),
	PRIMARY KEY (CourseCode, CourseNumber)
	);

-- Create Health Benefits Table
-- Table to Store the Health Benefits offered by University to its Employees.
CREATE TABLE prj.HealthBenefits (
	HealthBenefitId		SMALLINT		PRIMARY KEY		IDENTITY(1,1),
	HealthBenefit		SMALLINT		NOT NULL		REFERENCES prj.HealthBenefitLkp(BenefitSelectionId),
	Cost				DECIMAL(5,2)	NOT NULL,
	Description			VARCHAR(500)
	);

-- Create Vision Benefits Table
-- Table to Store the Vision Benefits offered by University to its Employees.
CREATE TABLE prj.VisionBenefits (
	VisionBenefitId		SMALLINT		PRIMARY KEY		IDENTITY(1,1),
	VisionBenefit		SMALLINT		NOT NULL		REFERENCES prj.VisionBenefitLkp(BenefitSelectionId),
	Cost				DECIMAL(5,2)	NOT NULL,
	Description			VARCHAR(500)
	);

-- Create Dental Benefits Table
-- Table to Store the Demtal Benefits offered by the University to its Employees.
CREATE TABLE prj.DentalBenefits (
	DentalBenefitId		SMALLINT		PRIMARY KEY		IDENTITY(1,1),
	DentalBenefit		SMALLINT		NOT NULL		REFERENCES prj.DentalBenefitLkp(BenefitSelectionId),
	Cost				DECIMAL(5,2)	NOT NULL,
	Description			VARCHAR(500)
	);

-- Create Area of Study Table
-- Table to Store Concentrations offered by the Univeristy.
CREATE TABLE prj.AreaOfStudy (
	AreaOfStudyId		SMALLINT		PRIMARY KEY		IDENTITY(1,1),
	ConcentrationName	VARCHAR(80)		NOT NULL,
	School				TINYINT			NOT NULL		REFERENCES prj.SchoolLkp(SchoolId)
	);

-- Create Semester Information Table
-- Table to Store Information Associated with Each Semester Every Year.
CREATE TABLE prj.SemesterInfo (
	SemesterId			INTEGER			PRIMARY KEY		IDENTITY(1,1),
	AcademicYear		INTEGER			NOT NULL		REFERENCES prj.AcademicYearLkp(YearId),
	Semester			TINYINT			NOT NULL		REFERENCES prj.SemesterLkp(SemesterNameId),
	FirstDay			DATE 			NOT NULL,
	LastDay				DATE 			NOT NULL
	);

-- Create People Table
-- Table to Store Students & Employees Generic Information.
CREATE TABLE prj.People (
	PersonId			INTEGER			PRIMARY KEY		IDENTITY(1,1),
	NTID				VARCHAR(8)		NOT NULL		UNIQUE,
	Password			VARCHAR(21)		NOT NULL,
	FirstName			VARCHAR(20)		NOT NULL,
	MiddleName			VARCHAR(20),
	LastName			VARCHAR(20)		NOT NULL,
	DateOfBirth			DATE			NOT NULL,
	SSN					INTEGER,
	HomeAddress			INTEGER			NOT NULL		REFERENCES prj.Address(AddressId),
	LocalAddress		INTEGER			NOT NULL		REFERENCES prj.Address(AddressId)
	);

-- Create Students Table
-- Table to Store Information Associated with Students.
CREATE TABLE prj.Students (
	StudentId			INTEGER			PRIMARY KEY		IDENTITY(1,1),
	PersonId			INTEGER			NOT NULL		UNIQUE	   REFERENCES prj.People(PersonId),
	StudentStatus		TINYINT			NOT NULL		REFERENCES prj.StudentStatusLkp(StudentStatusId),
	);

-- Create Classroom Table
-- Table to Store Classroom Information.
CREATE TABLE prj.Classroom (
	ClassroomId			INTEGER			PRIMARY KEY		IDENTITY(1,1),
	Building			SMALLINT		NOT NULL		REFERENCES prj.BuildingLkp(BuildingId),
	RoomNumber			SMALLINT		NOT NULL,
	Capacity			SMALLINT		NOT NULL,
	Projector			SMALLINT		NOT NULL		REFERENCES prj.ProjectorLkp(ProjectorId),
	WhiteBoardCount		TINYINT			NOT NULL,
	OtherAv				VARCHAR(500)
	);

-- Create Employees Table
-- Table to Store Information Associated with Employees.
CREATE TABLE prj.Employees (
	EmployeeId			INTEGER			PRIMARY KEY		IDENTITY(1,1),
	PersonId			INTEGER			NOT NULL		REFERENCES prj.People(PersonId),
	YearlyPay			DECIMAL(8,2)	NOT NULL,
	JobInformation		SMALLINT		NOT NULL		REFERENCES prj.JobInformation(JobId),
	HealthBenefits		SMALLINT		NOT NULL		REFERENCES prj.HealthBenefits(HealthBenefitId),
	VisionBenefits		SMALLINT		NOT NULL		REFERENCES prj.VisionBenefits(VisionBenefitId),
	DentalBenefits		SMALLINT		NOT NULL		REFERENCES prj.DentalBenefits(DentalBenefitId)
	);

-- Create Course Schedule Table
-- Table to Store Course Schedule for Each Section - Each Semester - Each Year for A Course.
CREATE TABLE prj.CourseSchedule (
	CourseScheduleId	INTEGER			PRIMARY KEY		IDENTITY(1,1),
	CourseCode			CHAR(3)			NOT NULL,
	CourseNumber		SMALLINT		NOT NULL,
	Semester			INTEGER			NOT NULL		REFERENCES prj.SemesterInfo(SemesterId),
	SectionNumber		TINYINT			NOT NULL,
	NumberOfSeats		SMALLINT		NOT NULL,
	Instructor			INTEGER			NOT NULL		REFERENCES prj.Employees(EmployeeId),
	isOnline			BIT				NOT NULL,
	Location			INTEGER			REFERENCES prj.Classroom(ClassroomId),
	FOREIGN KEY (CourseCode, CourseNumber) REFERENCES prj.CourseCatalogue(CourseCode, CourseNumber),
	UNIQUE (CourseCode, CourseNumber, SectionNumber, Instructor, Semester)
	);

-- Create Course Enrollment Table
-- Table to Store Records of Student Enrollment into Courses.
CREATE TABLE prj.CourseEnrollment (
	CourseEnrollmentId	INTEGER			PRIMARY KEY		IDENTITY(1,1),
	StudentId			INTEGER			NOT NULL		REFERENCES prj.Students(StudentId),
	Course				INTEGER			NOT NULL		REFERENCES prj.CourseSchedule(CourseScheduleId),
	EnrollmentStatus	TINYINT			NOT NULL		REFERENCES prj.EnrollmentStatusLkp(EnrollmentStatusId),
	Grade				TINYINT			REFERENCES prj.GradesLkp(GradeId),
	UNIQUE (StudentId, Course)
	);

-----------------------------------
-- TABLES WITH M-M RELATIONSHIPS --
-----------------------------------
-- Create Table Students And Majors
-- Table to Store Data Associated with Majors Being Pursued by Students.
-- A Student Can Have Multiple Majors.
CREATE TABLE prj.StudentsAndMajors (
	StudentId			INTEGER			NOT NULL		REFERENCES prj.Students(StudentId),
	MajorsId			SMALLINT		NOT NULL		REFERENCES prj.AreaOfStudy(AreaOfStudyId),
	PRIMARY KEY (StudentId, MajorsId)
	);

-- Create Table Students And Majors
-- Table to Store Data Associated with Minors Being Pursued by Students.
-- A Student Can Have Multiple Majors.
CREATE TABLE prj.StudentsAndMinors (
	StudentId			INTEGER			NOT NULL		REFERENCES prj.Students(StudentId),
	MinorsId			SMALLINT		NOT NULL		REFERENCES prj.AreaOfStudy(AreaOfStudyId),
	PRIMARY KEY (StudentId, MinorsId)
	);

-- Create Table Courses And Prerequisites
-- Table to Store Course Prerequisite(s) Information.
CREATE TABLE prj.CoursesAndPrerequisites (
	CourseCode			CHAR(3)			NOT NULL,
	CourseNumber		SMALLINT		NOT NULL,
	PreCourseCode		CHAR(3)			NOT NULL,
	PreCourseNumber		SMALLINT		NOT NULL,
	PRIMARY KEY (CourseCode, CourseNumber, PreCourseCode, PreCourseNumber),
	FOREIGN KEY (CourseCode, CourseNumber) REFERENCES prj.CourseCatalogue(CourseCode, CourseNumber),
	FOREIGN KEY (PreCourseCode, PreCourseNumber) REFERENCES prj.CourseCatalogue(CourseCode, CourseNumber)
	);

-- Create Table Daily Class Schedule
-- Table to Store Daily Class Schedule Information.
CREATE TABLE prj.DailyClassSchedule (
	CourseScheduleId	INTEGER			NOT NULL		REFERENCES prj.CourseSchedule(CourseScheduleId),
	DayId				TINYINT			NOT NULL		REFERENCES prj.DaysLkp(DayId),
	ClassTime			TIME			NOT NULL,
	Duration			TIME			NOT NULL
	PRIMARY KEY (CourseScheduleId, DayId),
	UNIQUE (CourseScheduleId, DayId, ClassTime)
	);



------------------------------------------------------------------
-- 						   REQUIREMENT 03						--							
-- 						   DATA INSERTION 						--
------------------------------------------------------------------
-- SQL Query to insert Data into Health Benefits Lookup Table
INSERT INTO prj.HealthBenefitLkp (HealthBenefit)
	VALUES	('Aetna'),
			('New York State of Health'),
			('Blue Cross Blue Sheild'),
			('United Health Care'),
			('Obamacare'),
			('EmblemHealth'),
			('No Health Benefits');

-- SQL Query to insert Data into Vision Benefits Lookup Table
INSERT INTO prj.VisionBenefitLkp (VisionBenefit)
	VALUES	('AARP'),
			('Blue Cross Blue Sheild'),
			('Eyemed Vision Care'),
			('Lemonade'),
			('Obamacare'),
			('VSP'),
			('No Vision Benefits');

-- SQL Query to insert Data into Dental Benefits Lookup Table
INSERT INTO prj.DentalBenefitLkp (DentalBenefit)
	VALUES	('Aflac'),
			('Humana'),
			('Delta Dental'),
			('United Health Care'),
			('AARP'),
			('Cigna'),
			('Uhone'),
			('No Dental Benefits');

-- SQL Query to Insert Days into Days Lookup Table
INSERT INTO prj.DaysLkp (DayText)
	VALUES	('Sunday'),
			('Monday'),
			('Tuesday'),
			('Wednesday'),
			('Thursday'),
			('Friday'),
			('Saturday');

-- SQL Query to Insert Projectors Data into Projector Lookup Table
INSERT INTO prj.ProjectorLkp (ProjectorText)
	VALUES	('Acer S1385WHne'),
			('Celluon PicoPro'),
			('Epson EX3240'),
			('Optoma EH341'),
			('Optoma GT1080'),
			('BenQ SW921'),
			('NEC Display NP-P452W');

-- SQL Query to Insert Building Data into Building Lookup Table
INSERT INTO prj.BuildingLkp (BuildingName)
	VALUES	('Maxwell Hall'),
			('Newhouse 1'),
			('Newhouse 2'),
			('Newhouse 3'),
			('Browne Hall'),
			('Lyman Hall'),
			('Slocum Hall'),
			('Science & Technology Center'),
			('Link Hall');

-- SQL Query to Insert School Names into School Lookup Table
INSERT INTO prj.SchoolLkp (SchoolName)
	VALUES	('LC Smith College of Engineering'),
			('Maxwell School of Citizenship & Public Affairs'),
			('Sentor School of Music'),
			('School of Architecture'),
			('School of Information Sciences'),
			('College of Law'),
			('Whitman School of Management'),
			('Newhouse School of Public Communications'),
			('College of Visual & Performing Arts');

-- SQL Query to Insert Student Status Information into Student Status Lookup Table
INSERT INTO prj.StudentStatusLkp (StudentStatus)
	VALUES	('Undergrad - Pursuing'),
			('Graduate - Pursuing'),
			('PhD - Pursuing'),
			('Undergrad - Graduated'),
			('Graduate - Graduated'),
			('PhD - Graduated');

-- SQL Query to Insert Grades into Grade Lookup Table
INSERT INTO prj.GradesLkp (Grade)
	VALUES	('A'),
			('A-'),
			('B'),
			('B-'),
			('C'),
			('C-'),
			('D'),
			('F');

-- SQL Query to Insert Enrollment Status into Enrollment Status Lookup Table
INSERT INTO prj.EnrollmentStatusLkp (EnrollmentStatus)
	VALUES	('Enrolled'),
			('Completed');

-- SQL Query to Semester Details into Semester Lookup Table
INSERT INTO prj.SemesterLkp (SemesterName)
	VALUES	('Fall'),
			('Spring'),
			('Summer');

-- SQL Query to insert Data into Academic Year Lookup Table
INSERT INTO prj.AcademicYearLkp (YearText)
	VALUES	(2010),
			(2011),
			(2012),
			(2013),
			(2014),
			(2015),
			(2016);

-- SQL Query to Insert Addresses into Address Table
INSERT INTO prj.Address (Address1, Address2, City, State, Country) 
	VALUES	('61128 Old Gate Point', 'Apartment 1', 'San Antonio', 'TX', 'United States'),
			('1464 Dennis Junction', 'Apartment 2', 'Springfield', 'IL', 'United States'),
			('77693 Rutledge Place', 'House 3', 'Riverside', 'CA', 'United States'),
			('0975 Crest Line Drive', NULL, 'Kansas City', 'MO', 'United States'),
			('732 Buhler Trail', NULL, 'Metairie', 'LA', 'United States'),
			('9417 Pond Parkway', 'Apartment 1', 'Los Angeles', 'CA', 'United States'),
			('08 Kropf Trail', NULL, 'Des Moines', 'IA', 'United States'),
			('04 Waxwing Crossing', NULL, 'Huntington Beach', 'CA', 'United States'),
			('33366 Pearson Lane', NULL, 'Cape Coral', 'FL', 'United States'),
			('0362 Stuart Court', 'Apartment 10', 'Minneapolis', 'MN', 'United States'),
			('665 Fairview Pass', NULL, 'Green Bay', 'WI', 'United States'),
			('51 Luster Park', NULL, 'Washington', 'DC', 'United States'),
			('3 Lighthouse Bay Street', NULL, 'Roanoke', 'VA', 'United States'),
			('66 Arizona Street', 'Apartment 6', 'Evansville', 'IN', 'United States'),
			('28833 Messerschmidt Hill', NULL, 'Harrisburg', 'PA', 'United States'),
			('48 Hanson Lane', 'Apartment 101', 'Davenport', 'IA', 'United States'),
			('9 Birchwood Alley', NULL, 'San Bernardino', 'CA', 'United States'),
			('88 Sullivan Plaza', NULL, 'Oklahoma City', 'OK', 'United States'),
			('0876 Acker Street', NULL, 'Dallas', 'TX', 'United States'),
			('6066 Oakridge Terrace', NULL, 'Scranton', 'PA', 'United States'),
			('9 Ridgeway Court', NULL, 'Dallas', 'TX', 'United States'),
			('73 Heffernan Trail', 'Apartment 4', 'Omaha', 'NE', 'United States'),
			('25 Anhalt Street', 'Apartment 201', 'Jacksonville', 'FL', 'United States'),
			('0338 Thierer Junction', NULL, 'El Paso', 'TX', 'United States'),
			('057 Messerschmidt Plaza', NULL, 'Detroit', 'MI', 'United States'),
			('5629 Londonderry Trail', NULL, 'San Diego', 'CA', 'United States'),
			('8324 Holmberg Crossing', NULL, 'Norman', 'OK', 'United States'),
			('95689 Mcbride Street', 'Apartment 1', 'Washington', 'DC', 'United States'),
			('44027 Washington Place', NULL, 'New Orleans', 'LA', 'United States'),
			('1023 Elka Terrace', NULL, 'Saint Louis', 'MO', 'United States'),
			('327 Laurel Avenue', NULL, 'Alexandria', 'VA', 'United States'),
			('34 Johnson Plaza', 'Apartment 801', 'Minneapolis', 'MN', 'United States'),
			('3 Redwing Crossing', NULL, 'Los Angeles', 'CA', 'United States'),
			('0 Havey Trail', NULL, 'Tampa', 'FL', 'United States'),
			('43 Gale Park', NULL, 'Carol Stream', 'IL', 'United States'),
			('81104 Cottonwood Parkway', 'Apartment 2', 'Portland', 'OR', 'United States'),
			('6 Haas Plaza', NULL, 'Syracuse', 'NY', 'United States'),
			('806 Monica Crossing', NULL, 'New York City', 'NY', 'United States'),
			('66 Garrison Crossing', NULL, 'Canton', 'OH', 'United States'),
			('263 Mayfield Lane', 'Apartment 409', 'Waco', 'TX', 'United States'),
			('63 Red Cloud Crossing', 'House 4', 'Sacramento', 'CA', 'United States'),
			('84 Debs Parkway', NULL, 'Winter Haven', 'FL', 'United States'),
			('48 Weeping Birch Point', NULL, 'Pittsburgh', 'PA', 'United States'),
			('244 Karstens Pass', 'Apartment 101', 'Pasadena', 'CA', 'United States'),
			('473 North Street', NULL, 'Buffalo', 'NY', 'United States'),
			('5 Arkansas Drive', NULL, 'Chula Vista', 'CA', 'United States'),
			('1504 Melvin Center', 'Apartment 420', 'Peoria', 'AZ', 'United States'),
			('464 Oriole Avenue', NULL, 'Erie', 'PA', 'United States'),
			('3878 Ruskin Lane', NULL, 'Tallahassee', 'FL', 'United States'),
			('4201 Jay Plaza', NULL, 'Dallas', 'TX', 'United States');

-- SQL Query to Insert Job Details into Job Information Table
INSERT INTO prj.JobInformation (JobName, JobDescription, JobRequirements, MinPay, MaxPay)
	VALUES	('RA - LCS', 'Research Assistant at LC Smith College of Engineering', NULL, 24000.00, 30000.00),
			('RA - WMN', 'Research Assistant at Whitman School of Management', NULL, 28000.00, 40000.00),
			('RA - ISC', 'Research Assistant at ISchool', NULL, 20000.00, 35000.00),
			('RA - MAX', 'Research Assistant at Maxwell School of Citizenship & Public Affairs', NULL, 30000.00, 42000.00),
			('AP - LCS', 'Assistant Professor at LC Smith College of Engineering', 'Minimum 3 years of Work Experience', 75000, 120000),
			('AP - WMN', 'Assistant Professor at Whitman School of Management', 'Minimum 3 years of Work Experience', 80000, 130000),
			('AP - ISC', 'Assistant Professor at ISchool', 'Minimum 3 years of Work Experience', 75000, 120000),
			('AP - MAX', 'Assistant Professor at Maxwell School of Citizenship & Public Affairs', 'Minimum 3 years of Work Experience', 80000, 135000),
			('PR - LCS', 'Professor at LC Smith College of Engineering', 'Minimum 5 years of Work Experience', 90000, 180000),
			('PR - WMN', 'Professor at Whitman School of Management', 'Minimum 6 years of Work Experience', 90000, 190000),
			('PR - ISC', 'Professor at ISchool', 'Minimum 5 years of Work Experience', 90000, 175000),
			('PR - MAX', 'Professor at Maxwell School of Citizenship & Public Affairs', 'Minimum 7 years of Work Experience', 99000, 200000);

-- SQL Query to Insert Courses into Course Catalogue Table
INSERT INTO prj.CourseCatalogue (CourseCode, CourseNumber, CourseTitle, CourseDescription)
	VALUES	('CIS', 543, 'Control of Robots', 'Kinematics, dynamics, and control of mobile and/or manipulator robots. Path planning, actuators, sensors, human/machine interface. Two hours lecture and two hours laboratory weekly. Design project.'),
			('CIS', 612, 'Colud Computing', 'Virtualized data centers, including virtual machine management, power management, and networking; cloud computing applications; and mobile cloud computing.'),
			('CIS', 631, 'Compiler Design', 'Development of the logical design of a compiler: lexical analyzer, parser, symbol table, error routines, code generator, and code optimizer. Analysis of formal algorithms for each component, description of overall compiler-construction techniques.'),
			('CIS', 651, 'Mobile Application Programming', NULL),
			('IST', 500, 'Selected Topics', NULL),
			('IST', 522, 'Applied Information Security', 'Applications of information security including hands-on experience. Students who successfully complete this course will understand how information security technology is applied to real systems.'),
			('IST', 565, 'Data Mining', 'Introduction to data mining techniques, familiarity with particular real-world applications, challenges involved in these applications, and future directions of the field. Optional hands-on experience with commercially available software packages.'),
			('IST', 585, 'Knowledge Management', 'Information systems behaviors that enable organizations to systematically identify, acquire, store, analyze, distribute, and reuse information and knowledge from all sources (internal and external, explicit and tacit) in order to enhance organizational productivity and competitiveness.'),
			('PAF', 431, 'Criminal Justice System', 'Seminar exploring the structure and function of the criminal justice system, as well as current issues, through readings, case analysis, court observation, and guest speakers.'),
			('PAF', 424, 'Conflict Resolution in Groups', 'Skills to enhance understanding of conflict and conflict resolution and manage conflict in intragroup and intergroup settings. Unstructured small group experience to learn how groups function and to present a context for practice.'),
			('PAF', 416, 'Community Problem Solving', 'Historical problems of Syracuse. Volunteerism, community organization, and local socioeconomic conditions. Student teams work with youths from Syracuse community centers to solve local problems.'),
			('PAF', 351, 'Global Social Problems', 'Topics include war, inequality, population, scarcity, environment, and technology.'),
			('MGT', 701, 'Women in Management', 'Investigate the opportunities and obstacles that women face in management and develop skills for leading women and men in order to improve individual, group and organizational performance.  Enhance critical thinking skills essential for managers.'),
			('MGT', 702, 'Transformational Management', 'The development of personal skills in designing, implementing, and processing structured learning intervention that facilitate comprehension of organizational dynamics as well as foster real organizational learning and transformation.  An experiential learning methodology will be employed.'),
			('MGT', 709, 'Business Policy', 'Interdepartmental approach to policy-making and administration from a top-management point of view. Thinking about business problems from an overall point of view.'),
			('MGT', 710, 'Administrative Policy', 'Applies the principles and techniques of management to the life-cycle management process through the use of a computerized management simulation problem. Includes consideration of policy-making issues from the top management point of view.'),
			('CSE', 776, 'Design Patterns', 'A seminar course based on the book "Design Patterns." Object oriented design methods emphasizing conceptual understanding rather than software development projects.'),
			('CIS', 787, 'Advanced Data Mining', 'Knowledge discovery process, data warehouses, OLAP, data mining inference based on statistics and machine learning, rule generation; emphasis on analytical aspects; applications.'),
			('CSE', 610, 'Introduction to Data Mining', 'DBMS building blocks; entity-relationship and relational models; SQL/Oracle; integrity constraints; database design; file structures; indexing; query processing; transactions and recovery; overview of object relational DBMS, data warehouses, data mining.');

-- SQL to Insert Employee Health Benefit Data into Health Benefits Table
INSERT INTO prj.HealthBenefits (HealthBenefit, Cost, Description)
	VALUES	(1, 2500.00, 'Complete Health Plan'),
			(2, 0.00, 'Basic Health Plan'),
			(5, 1500.00, NULL),
			(6, 1700.00, 'Complete Health Plan'),
			(4, 2450.00, 'Complete Health Plan');

-- SQL to Insert Employee Health Benefit Data into Health Benefits Table
INSERT INTO prj.VisionBenefits (VisionBenefit, Cost, Description)
	VALUES	(1, 500.00, 'Complete Vision Plan'),
			(2, 240.00, 'Basic Health Plan'),
			(6, 480.00, 'Complete Vision Plan'),
			(4, 450.00, NULL),
			(5, 510.00, 'Complete Health Plan');

-- SQL to Insert Employee Health Benefit Data into Health Benefits Table
INSERT INTO prj.DentalBenefits (DentalBenefit, Cost, Description)
	VALUES	(2, 300.00, 'Complete Dental Plan'),
			(2, 108.00, 'Basic Dental Plan'),
			(4, 380.00, 'Complete Dental Plan'),
			(1, 305.00, NULL),
			(2, 400.00, 'Complete Dental Plan - Tobacco user');

-- SQL to Insert Area of Study Information into Area of Study Table
INSERT INTO prj.AreaOfStudy (ConcentrationName, School)
	VALUES	('Computer Science', 1),
			('Engineering Management', 1),
			('Information Management', 5),
			('Computer Engineering', 1),
			('Finance', 7),
			('Marketing', 7),
			('Public Relations', 7),
			('Music Theory & Composition', 3),
			('Philosophy', 2),
			('Psychology', 2),
			('Journalism', 2),
			('Legal Studies', 6),
			('Homeland Security', 6);

-- SQL to Insert Semester Details into Semester Info Table
INSERT INTO prj.SemesterInfo (AcademicYear, Semester, FirstDay, LastDay)
	VALUES	(6, 1, '20150828', '20151215'),
			(7, 2, '20160119', '20160515'),
			(7, 3, '20160520', '20160630'),
			(7, 1, '20160827', '20161215');

-- SQL Query to Insert Random Generated People Data into People Table.
INSERT INTO prj.People (NTID, Password, FirstName, MiddleName, LastName, DateOfBirth, SSN, HomeAddress, LocalAddress) 
	VALUES	('emwhite', 'GNCI1IYezX', 'Evelyn', 'Mildred', 'White', '19811226', 906449908, 1, 2),
			('mdhudson', 'Hl1DmHaE', 'Mary', 'Denise', 'Hudson', '19801222', 822435554, 3, 4),
			('hcryan', '3ztBXGGOD0', 'Helen', 'Carolyn', 'Ryan', '19810212', 402690757, 5, 6),
			('rjreed', 'NGYOF2Tu5u', 'Robin', 'John', 'Reed', '19840915', 110607993, 7, 8),
			('hjrogers', 'CnvzUwsIoWp', 'Harry', 'Janice', 'Rogers', '19830824', 107530810, 9, 10),
			('ttrussel', 'C6zxpmAOi', 'Todd', 'Terry', 'Russell', '19820905', 870035567, 11, 12),
			('rvasquez', 'RXKrVhTDex', 'Ruth', NULL, 'Vasquez', '19870117', 007768131, 13, 14),
			('arcook', '9tDZy1a', 'Anne', 'Rebecca', 'Cook', '19951014', 572503822, 15, 16),
			('abweaver', 'sd4eEpNUY', 'Adam', 'Benjamin', 'Weaver', '20020818', 573980992, 17, 18),
			('jshudson', 'HzdEhxZjPbua', 'Jane', 'Sara', 'Hudson', '19900406', NULL, 19, 20),
			('dphguyen', 'JokloDsuR', 'Denise', 'Philip', 'Nguyen', '19940314', 668136545, 21, 22),
			('pmorris', '6bb4FXlTjuZf', 'Peter', NULL, 'Morris', '20041120', NULL, 23, 24),
			('jlReid', 'Idxpt9JSXA', 'Joshua', 'Linda', 'Reid', '19910706', NULL, 25, 26),
			('lhernand', '5knqCqYVyXTX', 'Louis', NULL, 'Hernandez', '19900225', NULL, 27, 28),
			('nrmontgo', 'I07c7MReSt', 'Nancy', 'Ronald', 'Montgomery', '19991203', 942393379, 29, 30),
			('gjfisher', 'MoaQJkSPVxuq', 'Gary', 'Joe', 'Fisher', '19960531', 666781070, 31, 32),
			('price', 'lzCcFn37j', 'Phillip', NULL, 'Rice', '20030308', 931211721, 33, 34),
			('cjmartin', 'zfBxaD', 'Clarence', 'Jimmy', 'Martin', '19990414', 462911994, 35, 36),
			('ragardne', 'hbKtNEBlErvd', 'Ruby', 'Andrew', 'Gardner', '19921019', 122025369, 37, 38),
			('nccarr', 'ph5TeE', 'Nicholas', 'Carlos', 'Carr', '19960520', NULL, 39, 40),
			('pjfox', 'pfoAdi', 'Philip', 'Johnny', 'Fox', '19910325', NULL, 41, 42),
			('ajhoward', 'Rjy8TvV', 'Albert', 'Jason', 'Howard', '19900621', NULL, 43, 44),
			('jrhamilt', 'u3z7Xtr2P', 'Jane', 'Ralph', 'Hamilton', '20040126', 307995355, 45, 46),
			('lrwallac', 'CIEeK14B', 'Lori', 'Ralph', 'Wallace', '19910416', 356312283, 47, 48),
			('jcsanche', 'vxuwgFWaq', 'Justin', 'Craig', 'Sanchez', '19911108', 756595702, 49, 50);

-- SQL to Insert Random Student Data into Students Table
INSERT INTO prj.Students (PersonId, StudentStatus)
	VALUES	( 8, 1), 
			( 9, 1), 
			(10, 1),
			(11, 1), 
			(12, 1), 
			(13, 1),
			(14, 2), 
			(15, 2), 
			(16, 2),
			(17, 2), 
			(18, 2), 
			(19, 2),
			(20, 1), 
			(21, 2), 
			(22, 2),
			(23, 2), 
			(24, 1), 
			(25, 3);

-- SQL to Insert Random Classroom Data into Classroom Table
INSERT INTO prj.Classroom (Building, RoomNumber, Capacity, Projector, WhiteBoardCount, OtherAv)
	VALUES	(8, 401, 60, 3, 2, 'Lecture Recording Equipment'),
			(6, 205, 120, 6, 4, NULL),
			(3, 421, 80, 7, 2, NULL),
			(7, 451, 40, 1, 2, NULL),
			(5, 308, 60, 5, 2, NULL),
			(9, 201, 120, 6, 4, 'Lecture Recording Equipment');

-- SQL QUERY to Insert Randomly Generated Employee Data into Employees Table
INSERT INTO prj.Employees (PersonId, YearlyPay, JobInformation, HealthBenefits, VisionBenefits, DentalBenefits)
	VALUES	(1,  90000.00, 1, 1, 1, 1),
			(2, 130000.00, 5, 6, 6, 6),
			(3, 135000.00, 6, 5, 1, 5),
			(4, 105000.00, 4, 1, 1, 5),
			(5,  95000.00, 3, 1, 4, 3),
			(6, 140000.00, 7, 5, 1, 1),
			(7, 180000.00, 8, 5, 1, 5);

-- SQL Query to Insert Course Schedule Information in Course Schedule Table
INSERT INTO prj.CourseSchedule (CourseCode, CourseNumber, SectionNumber, Instructor, NumberOfSeats, Semester, Location, isOnline)
	VALUES	('CIS', 543, 1, 1, 40, 2, 1, 0),
			('CIS', 631, 1, 2, 30, 4, 1, 0),
			('CIS', 631, 2, 1, 30, 4, 6, 0),
			('IST', 565, 1, 5, 50, 4, 3, 0),
			('IST', 565, 2, 6, 90, 4, NULL, 1),
			('MGT', 709, 1, 3, 80, 2, 3, 0),
			('CIS', 543, 1, 1, 40, 4, 1, 0),
			('CIS', 631, 1, 1, 40, 4, 1, 0),
			('PAF', 416, 1, 7, 40, 4, 5, 0);

-- SQL Query to Insert Student(s) Course Enrollment Records into Course Enrollment Table
INSERT INTO prj.CourseEnrollment (StudentId, Course, EnrollmentStatus, Grade)
	VALUES	( 1, 1, 2, 4), 
			( 2, 1, 2, 1),
			( 1, 7, 1, NULL), 
			( 2, 3, 1, NULL),
			( 3, 4, 2, 1), 
			( 4, 4, 2, 1),
			( 5, 3, 2, 1), 
			( 6, 3, 2, 2),
			( 7, 6, 2, 1), 
			( 7, 2, 1, NULL),
			( 7, 7, 2, 1), 
			( 8, 1, 2, 1),
			( 8, 2, 1, NULL), 
			( 8, 4, 2, 2),
			( 9, 1, 2, 2), 
			( 9, 2, 1, NULL),
			( 9, 4, 2, 1), 
			(10, 4, 2, 2),
			(10, 6, 2, 3), 
			(11, 1, 2, 2),
			(11, 5, 2, 1), 
			(11, 7, 1, NULL),
			(12, 6, 2, 1), 
			(13, 6, 2, 3),
			(14, 5, 2, 1), 
			(15, 5, 2, 1),
			(16, 4, 2, 2), 
			(16, 2, 1, NULL),
			(16, 1, 2, 2), 
			(17, 1, 2, 1),
			(17, 4, 2, 1), 
			(17, 6, 2, 2),
			(18, 5, 2, 1), 
			(18, 7, 2, 2),
			(18, 2, 1, NULL);

-- SQL Query to Insert Student Majors Data into Students And Majors Table
INSERT INTO prj.StudentsAndMajors (StudentId, MajorsId)
	VALUES	( 1, 1),
			( 2, 1),
			( 3, 3),
			( 4, 3),
			( 5, 4),
			( 6, 1),
			( 7, 1),
			( 7, 6),
			( 8, 3),
			( 9, 1),
			(10, 3),
			(11, 1),
			(12, 5),
			(13, 6),
			(14, 3),
			(15, 3),
			(16, 1),
			(17, 3),
			(18, 1);

-- SQL Query to Insert Student Minors Data into Students And Majors Table
INSERT INTO prj.StudentsAndMinors(StudentId, MinorsId)
	VALUES	( 8, 1),
			(10, 6),
			(11, 3),
			(17, 1),
			(17, 5);

-- SQL Query to Insert Course Dependency Data into Prerequisites And Courses Table
INSERT INTO prj. CoursesAndPrerequisites (CourseCode, CourseNumber, PreCourseCode, PreCourseNumber)
	VALUES	('PAF', 416, 'PAF', 351),
			('CIS', 787, 'CSE', 610),
			('CSE', 776, 'CIS', 631),
			('CSE', 776, 'CIS', 612),
			('CIS', 787, 'IST', 565),
			('IST', 585, 'IST', 565),
			('MGT', 710, 'MGT', 709);

-- SQL Query to Insert Time Slots for Every Periodic Class of Every Course in Every Semester into Daily Class Schedule And Day Table.
INSERT INTO prj.DailyClassSchedule (CourseScheduleId, DayId, ClassTime, Duration)
	VALUES	(1, 2, '09:00:00', '01:30:00'),
			(1, 4, '09:00:00', '01:30:00'),
			(2, 3, '09:00:00', '03:00:00'),
			(3, 4, '17:00:00', '03:00:00'),
			(4, 3, '11:00:00', '01:25:00'),
			(4, 5, '11:00:00', '01:25:00'),
			(5, 2, '08:00:00', '03:00:00'),
			(6, 2, '09:00:00', '01:30:00'),
			(6, 6, '14:00:00', '03:00:00'),
			(7, 2, '09:00:00', '01:30:00'),
			(7, 4, '09:00:00', '01:30:00'),
			(9, 3, '09:00:00', '03:00:00');



------------------------------------------------------------------
-- 						   REQUIREMENT 04						--							
-- 						    CREATE VIEWS 						--
------------------------------------------------------------------
-- SQL Query to Create View to Display Employee Information
-- This View will Display Employee Name, Job Title, Employee Salary, Health Benefit, Vision Benefit & Dental Benefit for Each Employee. 
CREATE VIEW prj.EmployeesView (Name, JobTitle, Salary, HealthBenefit, VisionBenefit, DentalBenefit)
	AS
		SELECT	p.FirstName + ' ' + ISNULL(p.MiddleName, '') + ', '+ p.LastName, j.JobName, '$ ' + CONVERT(VARCHAR(10), e.YearlyPay), 
				h.HealthBenefit, v.VisionBenefit, d.DentalBenefit
				FROM prj.People p
					RIGHT OUTER JOIN prj.Employees e
						ON e.PersonId = p.PersonId
					INNER JOIN prj.JobInformation j
						ON e.JobInformation = j.JobId
					INNER JOIN prj.HealthBenefits hb
						ON e.HealthBenefits = hb.HealthBenefitId
					INNER JOIN prj.VisionBenefits vb
						ON e.VisionBenefits = vb.VisionBenefitId
					INNER JOIN prj.DentalBenefits db
						ON e.DentalBenefits = db.DentalBenefitId
					INNER JOIN prj.HealthBenefitLkp h
						ON hb.HealthBenefit = h.BenefitSelectionId
					INNER JOIN prj.VisionBenefitLkp v
						ON vb.VisionBenefit = v.BenefitSelectionId
					INNER JOIN prj.DentalBenefitLkp d
						ON db.DentalBenefit = d.BenefitSelectionId;

-- SQL Query to Create View to Display Courses Taken Up By Students
-- This View will Display the Courses Taken up by Students Across all Semesters 
-- for Each Academic Year 
CREATE VIEW prj.CourseEnrollmentView (Student, Course, Semester, AcademicYear, Grade)
	AS
		SELECT	p.FirstName + ' ' + ISNULL(p.MiddleName, '') + ', ' + p.Lastname, s.CourseCode + ' ' + CONVERT(VARCHAR(5), s.CourseNumber),
				l.SemesterName, y.YearText, g.Grade
				FROM prj.People p
					INNER JOIN prj.Students st
						ON st.PersonId = p.PersonId
					INNER JOIN prj.CourseEnrollment e
						ON e.StudentId = st.StudentId
					INNER JOIN prj.CourseSchedule s
						ON s.CourseScheduleId = e.Course
					INNER JOIN prj.SemesterInfo i
						ON i.SemesterId = s.Semester
					INNER JOIN prj.SemesterLkp l
						ON l.SemesterNameId = i.Semester
					INNER JOIN prj.GradesLkp g
						ON g.GradeId = e.Grade
					INNER JOIN prj.AcademicYearLkp y
						ON y.YearId = i.AcademicYear;

-- SQL QUERY to Show Courses Taken Up by Instuctors along with Enrollment Count for Each Semester
-- This View will Display Courses Taught by Instructor Across all Semesters for every Academic Year
-- It also displays the Popularity of course (how often it is picked and influence of instructor on
-- students while picking the course) 
CREATE VIEW prj.CoursesAndInstructorsView (Course, Semester, AcademicYear, Instructor, StudentCount)
	AS
		SELECT	s.CourseCode + ' ' + CONVERT(VARCHAR(5), s.CourseNumber), l.SemesterName, y.YearText,
						p.FirstName + ' ' + ISNULL(p.MiddleName, '') + ', ' + p.LastName, COUNT(e.Course)
						FROM prj.CourseSchedule s
							INNER JOIN prj.SemesterInfo i
								ON i.SemesterId = s.Semester
							INNER JOIN prj.SemesterLkp l
								ON i.Semester = l.SemesterNameId
							INNER JOIN prj.Employees o
								ON o.EmployeeId = s.Instructor
							INNER JOIN prj.People p
								ON p.PersonId = o.PersonId
							INNER JOIN prj.CourseEnrollment e
								ON e.Course = s.CourseScheduleId
							INNER JOIN prj.AcademicYearLkp y
								ON y.YearId = i.AcademicYear
							GROUP BY s.CourseCode, s.CourseNumber, s.Semester, l.SemesterName, 
									 p.FirstName, p.LastName, p.MiddleName, y.YearText;

-- SQL Query to Create View to Display Generic Information of People (Includes Students & Employees) in the Database
-- This View will Display all the Generic Information (not student / Employee Information) Associated to Every Person
-- present in our Database
CREATE VIEW prj.PeopleView (Name, NTID, DateOfBirth, HomeAddress, LocalAddress)
	AS
		SELECT	p.FirstName + ' ' + ISNULL(p.MiddleName, '') + ', ' + p.LastName, p.NTID, p.DateOfBirth, 
				a.Address1 + ', ' + ISNULL(a.Address2, '') + ', ' + a.City + ', ' + a.State + ', ' + a.Country,
				a.Address1 + ', ' + ISNULL(a.Address2, '') + ', ' + a.City + ', ' + a.State + ', ' + a.Country
				FROM prj.People p
					INNER JOIN prj.Address a
						ON	p.HomeAddress = a.AddressId
					INNER JOIN prj.Address b
						ON p.LocalAddress = b.AddressId;

-- SQL Query to Create View to Display Courses And their Prerequisite Courses
-- This View will Display all the Courses and if present their PreRequisite Courses
-- for every
CREATE VIEW prj.CoursesAndPrerequisitesView (Course, CourseTitle, Prerequisite, PrerequisiteCourseTitle)
	AS
		SELECT c.CourseCode + ' ' + CONVERT(VARCHAR(5), c.CourseNumber), c.CourseTitle, 
			   ISNULL(p.CourseCode + ' ' + CONVERT(VARCHAR(5), p.CourseNumber), 'N/A'), p.CourseTitle
			FROM prj.CoursesAndPrerequisites a
				RIGHT OUTER JOIN prj.CourseCatalogue c
					ON	a.CourseCode = c.CourseCode
						AND a.CourseNumber = c.CourseNumber
				INNER JOIN prj.CourseCatalogue p
					ON a.PreCourseCode = p.CourseCode
						AND a.PreCourseNumber = p.CourseNumber;

-- SQL Query to Create View to Display Courses And their Prerequisite Courses
-- This View will Display all the Courses and if present their PreRequisite Courses
-- for every Course
CREATE VIEW prj.CoursesAndPrerequisitesView (Course, CourseTitle, Prerequisite, PrerequisiteCourseTitle)
	AS
		SELECT c.CourseCode + ' ' + CONVERT(VARCHAR(5), c.CourseNumber), c.CourseTitle, 
			   ISNULL(p.CourseCode + ' ' + CONVERT(VARCHAR(5), p.CourseNumber), 'N/A'), ISNULL(p.CourseTitle, 'N/A')
			FROM prj.CoursesAndPrerequisites a
				RIGHT OUTER JOIN prj.CourseCatalogue c
					ON	a.CourseCode = c.CourseCode
						AND a.CourseNumber = c.CourseNumber
				LEFT OUTER JOIN prj.CourseCatalogue p
					ON a.PreCourseCode = p.CourseCode
						AND a.PreCourseNumber = p.CourseNumber;



------------------------------------------------------------------
-- 						   REQUIREMENT 05						--							
-- 					  CREATE STORED PROCEDURES 					--
------------------------------------------------------------------
-------------------------------------------------
-- SQL Query to Insert New Student Information --
-------------------------------------------------
CREATE PROC prj.InsertStudentProc  (@firstName AS VARCHAR(20), @middleName AS VARCHAR(20), @lastName AS VARCHAR(20), 
									@password AS VARCHAR(21), @dob AS DATE, @ssn AS INTEGER, @hAddress1 AS VARCHAR(70), 
									@hAddress2 AS VARCHAR(70), @hCity AS VARCHAR(58),@hState AS CHAR(2), @hCountry AS VARCHAR(50), 
									@lAddress1 AS VARCHAR(70), @lAddress2 AS VARCHAR(70), @lCity AS VARCHAR(58), @lState AS CHAR(2), 
									@studentStatus AS VARCHAR(20))
	AS
		BEGIN TRAN
			-- SQL Query to Make sure that if SSN is present
			-- SSN should be 9 digit and not already be present
			-- in the Database.
			IF @ssn = ''
				BEGIN
					SET @ssn = NULL
				END
			IF (@ssn > 999999999 OR @ssn < 100000000)
				BEGIN
					PRINT '[Error] : Invalid SSN';
					PRINT '			 SSN Should be Unique 9 Digit Number';
					ROLLBACK TRAN;
					GOTO TRANEND;
				END
			IF (SELECT SSN
					FROM prj.People p
						WHERE p.SSN =@ssn) IS NOT NULL
				BEGIN
					PRINT '[Error] : Invalid SSN. Duplicate Value';
					PRINT '			 Please enter the Correct SSN or Leave the Field Blank';
					ROLLBACK TRAN;
					GOTO TRANEND;
				END

			-- If Home Address 2 Field is Blank, Make it NULL.
			IF @hAddress2 = ''
				BEGIN
					SET @hAddress2 = NULL;
				END

			-- Try Catch to Make Sure Insertion is done Properly.
			-- If Something Goes Wrong, Rollback Insertion(s).
			BEGIN TRY
				INSERT INTO prj.Address (Address1, Address2, City, State, Country)
					VALUES (@hAddress1, @hAddress2, @hCity, @hState, @hCountry);
			END TRY
			BEGIN CATCH
				PRINT '[Error] : Please Check Your Home Address';
				PRINT '          Format - Address1 (VARCHAR 20), Address2 (VARCHAR 20), City(VARCHAR 58), State(CHAR 2), Country (VARCHAR 50)';
				PRINT 'Rolling Back Changes';
				ROLLBACK TRAN;
				GOTO TRANEND;
			END CATCH

			-- Declare Variables to Hold Home Address Keys
			DECLARE @hAddress AS INTEGER;
			-- Get the Home Address Key
			SET @hAddress = (SELECT TOP 1 AddressId
								FROM prj.Address a
									WHERE a.Address1 = @hAddress1
										AND ISNULL(a.Address2, '') = ISNULL(@hAddress2, '')
										AND a.City = @hCity
										AND a.State = @hState
										AND a.Country = @hCountry
									ORDER BY 1 DESC);

			-- If Home Address 1 Field is Blank, Make it NULL.
			IF @hAddress1 = ''
				BEGIN
					SET @hAddress2 = NULL;
				END

			-- Try Catch to Make Sure Insertion is done Properly.
			-- If Something Goes Wrong, Rollback Insertion(s).
			BEGIN TRY
				INSERT INTO prj.Address (Address1, Address2, City, State, Country)
					VALUES (@lAddress1, @lAddress2, @lCity, @lState, 'United States');
			END TRY
			BEGIN CATCH
				PRINT '[Error] : Please Check Your Local Address';
				PRINT '          Format - Address1 (VARCHAR 20), Address2 (VARCHAR 20), City(VARCHAR 58), State(CHAR 2), Country (VARCHAR 50)';
				PRINT 'Rolling Back Changes';
				ROLLBACK TRAN;
				GOTO TRANEND;
			END CATCH

			-- Declare Variables to Hold Home Address Keys
			DECLARE @lAddress AS INTEGER;
			-- Get the Home Address Key
			SET @lAddress = (SELECT TOP 1 AddressId
								FROM prj.Address a
									WHERE a.Address1 = @lAddress1
										AND ISNULL(a.Address2, '') = ISNULL(@lAddress2, '')
										AND a.City = @lCity
										AND a.State = @lState
										AND a.Country = 'United States'
									ORDER BY 1 DESC);
			
			-- Declare Variable to Generate NTID
			DECLARE @ntid AS VARCHAR(8);
			-- Generate NTID
			SET @ntid = SUBSTRING(SUBSTRING(@firstName, 1, 1) + ISNULL(SUBSTRING(@middleName, 1, 1), '') + @lastName, 1, 8);

			-- If Middle Name Field is Blank, Make it NULL.
			IF @middleName = ''
				BEGIN
					SET @middleName = NULL;
				END

			-- Try Catch to Make Sure Insertion is done Properly.
			-- If Something Goes Wrong, Rollback Insertion(s).
			BEGIN TRY
				INSERT INTO prj.People (NTID, Password, FirstName, MiddleName, LastName, DateOfBirth, SSN, HomeAddress, LocalAddress)
					VALUES (@ntid, @password, @firstName, @middleName, @lastName, @dob, @ssn, @hAddress, @lAddress);
			END TRY
			BEGIN CATCH
				PRINT '[Error] : Please Check Name / DOB / Password';
				PRINT '          Format - FirstName (VARCHAR 20), MiddleName (VARCHAR 20), LastName (VARCHAR 20), DateOfBirth(YYYYMMDD), Password (VARCHAR 21)';
				PRINT 'Rolling Back Changes';
				ROLLBACK TRAN;
				GOTO TRANEND;
			END CATCH

			-- Variable to Store Student Status Value
			DECLARE @status AS TINYINT;
			-- Get the Value of Student Status
			SET @status = (SELECT StudentStatusId
								FROM prj.StudentStatusLkp
									WHERE StudentStatus = @studentStatus);
			-- If @status is NULL, then Terminate
			IF @status IS NULL
				BEGIN
					PRINT '[Error] : Invalid Student Status';
					PRINT '			 Student Status is Invalid';
					ROLLBACK TRAN;
					GOTO TRANEND;
				END

			-- Variable to Hold Person Id
			DECLARE @person AS INTEGER;
			-- Get the PersonId For The Values We Just Inserted
			IF @ssn IS NULL
				BEGIN
					SET @person = (SELECT TOP 1 PersonId
										FROM prj.People p
											WHERE p.FirstName = @firstName
												AND ISNULL(p.MiddleName, '') = ISNULL(@middleName, '')
												AND p.LastName = @lastName
												AND p.DateOfBirth = @dob
												ORDER BY p.PersonId DESC);
				END
			ELSE
				BEGIN
					SET @person = (SELECT PersonId
										FROM prj.People p
											WHERE p.SSN = @ssn);
				END

			-- Try Catch to Make Sure Insertion is done Properly.
			-- If Something Goes Wrong, Rollback Insertion(s).
			BEGIN TRY
				INSERT INTO prj.Students (PersonId, StudentStatus)
					VALUES (@person, @status);
			END TRY
			BEGIN CATCH
				PRINT '[Error] : Unable to Create Student with Given Data';
				PRINT '			 Internal Error. Database Needs Maintenance';
				ROLLBACK TRAN;
				GOTO TRANEND;
			END CATCH

	TRANEND:
		PRINT 'Command Completed';



------------------------------------------------
-- SQL Query to Enroll a Student into a Class --
------------------------------------------------
CREATE PROC prj.EnrollStudentProc (@ntid AS VARCHAR(8), @courseCode AS CHAR(3), @courseNumber AS SMALLINT, 
								   @semester AS VARCHAR(15), @academicYear AS INTEGER, @section AS TINYINT)
	AS
		BEGIN TRAN
			-- Variable to Hold Student ID
			DECLARE @student AS INTEGER;
			-- Get the Value of Student ID
			SET @student = (SELECT StudentId
								FROM prj.Students s
									INNER JOIN prj.People p
										ON s.PersonId = p.PersonId
									WHERE p.NTID = @ntid);

			-- If No Student with @ntid Exists, Then Rollback & Exit
			IF @student IS NULL
				BEGIN
					PRINT '[Error] : Invalid NTID';
					PRINT '			 No Student with NTID ' + @ntid + ' exists';
					PRINT 'Rolling Back Changes';
					ROLLBACK TRAN;
					GOTO TRANEND;
				END

			-- Variable to Hold Semester ID
			DECLARE @semId AS TINYINT;
			-- Get the Value of Semester ID
			SET @semId = (SELECT SemesterNameId
							FROM prj.SemesterLkp s
								WHERE s.SemesterName = @semester);
			
			-- If No Such Semester Exists, Then Rollback & Exit
			IF @semId IS NULL
				BEGIN
					PRINT '[Error] : Invalid Semester';
					PRINT '			 ' + CAST(@semester AS VARCHAR) + ' Semester Does Not Exists';
					PRINT 'Rolling Back Changes';
					ROLLBACK TRAN;
					GOTO TRANEND;
				END

			-- Variable to Hold Academic Year ID
			DECLARE @yearId AS INTEGER;
			-- Get the Value of Academic Year ID
			SET @yearId = (SELECT YearId
								FROM prj.AcademicYearLkp
									WHERE YearText = @academicYear);
			
			-- If No Such Semester Exists, Then Rollback & Exit
			IF @yearId IS NULL
				BEGIN
					PRINT '[Error] : Invalid Academic Year';
					PRINT '			 ' + CAST(@academicYear AS VARCHAR) + ' Academic Year Does Not Exists';
					PRINT 'Rolling Back Changes';
					ROLLBACK TRAN;
					GOTO TRANEND;
				END

			-- Variable to Hold Course Schedule ID
			DECLARE @scheduleId AS INTEGER;
			-- Get the Value of Course Schedule Matching to the Parameter Information
			SET @scheduleId = (SELECT CourseScheduleId
									FROM prj.CourseSchedule s
									INNER JOIN prj.SemesterInfo i
										ON i.SemesterId = s.Semester
									WHERE i.Semester = @semId
										AND i.AcademicYear = @yearId
										AND s.CourseCode = @courseCode
										AND s.CourseNumber = @courseNumber
										AND s.SectionNumber = @section);

			-- If No Matching Class Exists in the Schedule, Then Rollback & Exit
			IF @scheduleId IS NULL
				BEGIN
					PRINT 'The Requested Course is Not Scheduled for Academic Year - ' + CAST(@academicYear AS VARCHAR) + ' Semester - ' + CAST(@semester AS VARCHAR);
					PRINT 'Rolling Back Changes';
					ROLLBACK TRAN;
					GOTO TRANEND;
				END

			-- Variable to Hold List of Prerequisite Courses
			DECLARE @prerequisites AS TABLE (CourseCode CHAR(3), CourseNumber SMALLINT);
			-- Get the List of Prerequisite Courses
			INSERT INTO @prerequisites (CourseCode, CourseNumber)
				SELECT PreCourseCode, PreCourseNumber
						FROM prj.CoursesAndPrerequisites p
							WHERE p.CourseCode = @courseCode
								AND p.CourseNumber = @courseNumber;

			-- Check if the Student Has Taken Prerequisites
			IF (SELECT COUNT (*) 
					FROM @prerequisites) <= (SELECT COUNT(*) 
												FROM prj.CourseEnrollment e
													INNER JOIN prj.CourseSchedule s
														ON s.CourseScheduleId = e.Course
													INNER JOIN prj.CourseCatalogue c
														ON c.CourseCode = @courseCode
															AND c.CourseNumber = @courseNumber
													WHERE e.StudentId = @student
														AND c.CourseCode IN (SELECT CourseCode FROM @prerequisites)
														AND c.CourseNumber IN (SELECT CourseNumber FROM @prerequisites))
				BEGIN
					-- Try Catch to Capture Error While Performing Insertion
					BEGIN TRY
						INSERT INTO prj.CourseEnrollment (StudentId, Course, EnrollmentStatus, Grade)
							VALUES (@student, @scheduleId, 1, NULL);
					END TRY
					BEGIN CATCH
						PRINT '[Error] : Unable to Enroll Student';
						PRINT 'Internal Error. Database Needs Maintenance';
						PRINT 'Rolling Back Changes';
						ROLLBACK TRAN;
						GOTO TRANEND;
					END CATCH
				END
				ELSE
					BEGIN
						PRINT '[Error] : Student Has Not Taken the Required Prerequisites';
						PRINT 'Enrollment Cannot be Completed';
						PRINT 'Rolling Back Changes';
						ROLLBACK TRAN;
						GOTO TRANEND;
					END

	TRANEND:
		PRINT 'Command Complete';


-------------------------------------------------------
-- SQL Query to Pull out All the Student Information --
-------------------------------------------------------
CREATE PROC prj.StudentInfoFunc (@ntid AS VARCHAR(8))
	AS
		-- Variable to Hold Student ID
		DECLARE @studentId INTEGER;
		-- Get the Value of Student ID
		SET @studentId = (SELECT StudentId
							FROM prj.Students s
								INNER JOIN prj.People p
									ON s.PersonId = p.PersonId
								WHERE p.NTID = @ntid);

		-- If No Student with @ntid Exists, Then Exit
		IF @studentId IS NULL
			BEGIN
				PRINT '[Error] : Invalid NTID';
				PRINT 'No Student with NTID ' + @ntid + ' exists';
				GOTO PROCEND;
			END

		-- Variable to Hold Student Status
		DECLARE @status VARCHAR(20);
		-- Get the Value of Student Status
		SET @status = (SELECT l.StudentStatus
							FROM prj.Students s
								INNER JOIN prj.StudentStatusLkp l
									ON l.StudentStatusId = s.StudentStatus
								WHERE s.StudentId = @studentId);
		-- Print the Student Status
		PRINT 'Student Status : ' + @status;
		-- Variable to Hold Temporary Data
		DECLARE @tmp VARCHAR(80);

		-- Print the Student Majors
		-- Variable to Hold Concentration Name
		DECLARE @mname AS VARCHAR(600);
		SET @mname = '';
		-- Cursor to Hold all the Majors Data Associated with the Student
		DECLARE MajorsCursor CURSOR FOR
			SELECT a.ConcentrationName
				FROM prj.Students s
					INNER JOIN prj.StudentsAndMajors m
						ON s.StudentId = m.StudentId
					INNER JOIN prj.AreaOfStudy a
						ON a.AreaOfStudyId = m.MajorsId
					WHERE s.StudentId = @studentId;

		-- Print Majors Names on Console
		OPEN MajorsCursor;
		FETCH NEXT FROM MajorsCursor INTO @tmp;
		WHILE @@FETCH_STATUS = 0
			BEGIN
				SET @mname = @mname + '"' + @tmp + '" ';
				FETCH NEXT FROM MajorsCursor INTO @tmp;
			END
		PRINT 'Majors : ' + @mname;
		
		-- Close MajorsCursor
		CLOSE MajorsCursor
		-- DROP MajorsCursor
		DEALLOCATE MajorsCursor;

		-- Print the Student Minors
		-- Variable to Hold Concentration Name
		DECLARE @iname AS VARCHAR(600);
		SET @iname = '';
		-- Cursor to Hold all the Majors Data Associated with the Student
		DECLARE MinorsCursor CURSOR FOR
			SELECT a.ConcentrationName
				FROM prj.Students s
					INNER JOIN prj.StudentsAndMinors m
						ON s.StudentId = m.StudentId
					INNER JOIN prj.AreaOfStudy a
						ON a.AreaOfStudyId = m.MinorsId
					WHERE s.StudentId = @studentId;

		-- Print Minors Names on Console
		OPEN MinorsCursor;
		FETCH NEXT FROM MinorsCursor INTO @tmp;
		WHILE @@FETCH_STATUS = 0
			BEGIN
				SET @iname = @iname + '"' + @tmp + '" ';
				FETCH NEXT FROM MinorsCursor INTO @tmp;
			END
		
		IF (@iname = '')
			BEGIN
				PRINT 'Minors : N/A';
			END
		ELSE
			BEGIN
				PRINT 'Minors : ' + @iname;
			END 
		
		-- Close MinorsCursor
		CLOSE MinorsCursor
		-- DROP MinorsCursor
		DEALLOCATE MinorsCursor;

		-- Print the Classes Taken by Students
		-- Temporary Variables to Hold Class Information
		DECLARE @tcc AS CHAR(3);
		DECLARE @tcn AS SMALLINT;
		DECLARE @tay AS INTEGER;
		DECLARE @ts  AS VARCHAR(15);
		
		-- Cursor to Hold all the Class Data Associated with the Student
		DECLARE ClassCursor CURSOR FOR
			SELECT s.CourseCode, s.CourseNumber, a.YearText, l.SemesterName
				FROM prj.CourseSchedule s
					INNER JOIN prj.CourseEnrollment e
						ON e.Course = s.CourseScheduleId
					INNER JOIN prj.SemesterInfo i
						ON i.SemesterId = s.Semester
					INNER JOIN prj.SemesterLkp l
						ON l.SemesterNameId = i.Semester
					INNER JOIN prj.AcademicYearLkp a
						ON a.YearId = i.AcademicYear
					WHERE e.StudentId = @studentId
					ORDER BY a.YearText, l.SemesterNameId;
		
		-- Print Classes Taken by Student on Console
		OPEN ClassCursor;
		FETCH NEXT FROM ClassCursor INTO @tcc, @tcn, @tay, @ts;
		PRINT '';
		PRINT 'Classes Taken';
		PRINT '-------------';
		PRINT 'Course    Year   Semester';
		WHILE @@FETCH_STATUS = 0
			BEGIN
				PRINT @tcc + ' ' + CAST(@tcn AS VARCHAR) + '   ' + CAST(@tay AS VARCHAR) + '   ' + @ts;
				FETCH NEXT FROM ClassCursor INTO @tcc, @tcn, @tay, @ts;
			END
		
		-- Close MinorsCursor
		CLOSE ClassCursor
		-- DROP MinorsCursor
		DEALLOCATE ClassCursor;

	PROCEND:
		PRINT '';
		PRINT 'Command Complete.';


-------------------------------------------------------------
-- 						   REQUIREMENT 05				   --							
-- 					  	  CREATE FUNCTIONS 				   --
-------------------------------------------------------------
-------------------------------------------------------------
--SQL Query to Return all Student Timetable for a Semester --
-------------------------------------------------------------
CREATE FUNCTION prj.StudentTimetable (@ntid AS VARCHAR(8), @year AS INTEGER, @semester AS VARCHAR(15))
	RETURNS @timetable TABLE (CourseCode CHAR(3), CourseNumber SMALLINT, AcademicYear INTEGER, Semester VARCHAR(15))
	AS
		BEGIN
			-- Variable to Hold Student ID
			DECLARE @studentId AS INTEGER;
			-- Get the Value of Student ID
			SET @studentId = (SELECT StudentId
								FROM prj.Students s
									INNER JOIN prj.People p
										ON s.PersonId = p.PersonId
									WHERE p.NTID = @ntid);
			
			-- Get the Values of TimeTable
			INSERT INTO @timetable (CourseCode, CourseNumber, Academicyear, Semester)
				SELECT s.CourseCode, s.CourseNumber, a.YearText, l.SemesterName
					FROM prj.CourseSchedule s
						INNER JOIN prj.CourseEnrollment e
							ON e.Course = s.CourseScheduleId
						INNER JOIN prj.SemesterInfo i
							ON i.SemesterId = s.Semester
						INNER JOIN prj.SemesterLkp l
							ON l.SemesterNameId = i.Semester
						INNER JOIN prj.AcademicYearLkp a
							ON a.YearId = i.AcademicYear
						WHERE e.StudentId = @studentId
							AND a.YearText = @year
							AND l.SemesterName = @semester
						ORDER BY a.YearText, l.SemesterNameId;
			
			-- The Time Table will be Automatically Returned.
			RETURN;
		END



--------------------------------------------------------------------------------------------------
-- 											REFERENCES											--
--------------------------------------------------------------------------------------------------
-- 1. Dr. Palider's Lectures And Assignments
-- 2. https://www.codeproject.com/articles/167399/using-table-valued-functions-in-sql-server
-- 3. http://www.sqlservercentral.com/Forums/Topic1063878-1292-1.aspx
-- 4. http://stackoverflow.com/questions/21824478/reset-identity-seed-after-deleting-records-in-sql-server
-- 5. https://www.mockaroo.com/
-- 6. http:://www.databasetestdata.com
