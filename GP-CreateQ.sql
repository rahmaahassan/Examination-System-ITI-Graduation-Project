-- Create the database
CREATE DATABASE ITIGP

-- Topic table
CREATE TABLE Topic (
    Topic_Id INT PRIMARY KEY,
	Topic_Name VARCHAR(20)
)

-- Import the topic data file
BULK INSERT Topic
FROM 'C:\ITI\Power BI\GP\Database\Topic.csv'
WITH (
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '\n',
  FIRSTROW = 2
)

-- Course table
CREATE TABLE Course (
    Crs_ID INT PRIMARY KEY,
	Crs_Name VARCHAR(20),
	Topic_Id INT FOREIGN KEY REFERENCES Topic(Topic_id) ON UPDATE CASCADE  ON DELETE CASCADE
)

-- Import the course data file
BULK INSERT Course
FROM 'C:\ITI\Power BI\GP\Database\Course.csv'
WITH (
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '\n',
  FIRSTROW = 2
)

-- Question table
CREATE TABLE Question (
    Qus_No INT PRIMARY KEY,
	Qus_Text VARCHAR(200),
	Qus_Type VARCHAR(10),
	Crs_ID INT FOREIGN KEY REFERENCES Course(Crs_ID) ON UPDATE CASCADE  ON DELETE CASCADE
)

-- Import the Question data file
BULK INSERT Question
FROM 'C:\ITI\Power BI\GP\Database\Question.csv'
WITH (
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '\n',
  FIRSTROW = 2
)

-- Choices table
CREATE TABLE Choices (
    Choice_Id INT PRIMARY KEY,
	Choice_Text VARCHAR(200),
	Is_Correct INT,
	Qus_No INT FOREIGN KEY REFERENCES Question(Qus_No) ON UPDATE CASCADE  ON DELETE CASCADE
)

-- Import the Choices data file
BULK INSERT Choices
FROM 'C:\ITI\Power BI\GP\Database\Choices.csv'
WITH (
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '\n',
  FIRSTROW = 2
)

-- Department table
CREATE TABLE Department (
  Dept_No INT PRIMARY KEY,
	Dept_Name VARCHAR(20),
	Dept_Location VARCHAR(20)
)

ALTER TABLE Department ADD 
	Mngr_Id INT FOREIGN KEY REFERENCES Instructor(Ins_ID) ON UPDATE CASCADE  ON DELETE CASCADE

-- Import the Department data file
BULK INSERT Department
FROM 'C:\ITI\Power BI\GP\Database\Department.csv'
WITH (
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '\n',
  FIRSTROW = 2
)

-- Instructor table
CREATE TABLE Instructor (
    Ins_ID INT PRIMARY KEY,
	Ins_Name VARCHAR(25),
	Ins_Gender VARCHAR(20),
	Ins_DOB VARCHAR(20),
	Ins_City VARCHAR(20),
	Ins_Street VARCHAR(20),
	Ins_Email VARCHAR(40),
	Ins_Salary INT,
	Crs_Id INT FOREIGN KEY REFERENCES Course(Crs_Id) ON UPDATE CASCADE  ON DELETE CASCADE
)

-- After Create Dep table
ALTER TABLE Instructor ADD 
	Dept_No INT FOREIGN KEY REFERENCES Department(Dept_No)

-- Import the Instructor data file
BULK INSERT Instructor
FROM 'C:\ITI\Power BI\GP\Database\Instructor.csv'
WITH (
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '\n',
  FIRSTROW = 2
)

-- Ins_Phone table
GO
CREATE TABLE Ins_Phone (   
  Ins_ID INT FOREIGN KEY REFERENCES Instructor(Ins_ID),
  Ins_PhoneNo INT, 
	PRIMARY KEY (Ins_ID ,Ins_PhoneNo)
)

-- Import the Ins_Phone data file 
GO
BULK INSERT Ins_Phone
FROM 'C:\ITI\Power BI\GP\Database\Ins_Phone.csv'
WITH (
  FIELDTERMINATOR = ',',  
  ROWTERMINATOR = '\n',
  FIRSTROW = 2
)

-- Student table
GO
CREATE TABLE Student (   
    Std_ID INT PRIMARY KEY,
    Std_Name VARCHAR(30), 
	Std_Gender VARCHAR(10),
	Std_SSN INT UNIQUE,
	Std_Age INT,
	Std_Email VARCHAR(100),
	Std_City VARCHAR(20),
	Std_Street VARCHAR(30),
	Std_ZipCode INT,
	Std_UniGradeYear INT,
	Std_EventStatus INT,
	Std_FreelancingStatus INT,
	Std_DiseaseName VARCHAR(30),
	Std_EmcName VARCHAR(30),
	Std_EmcPhoneNo INT,
	Int_Name VARCHAR(30) FOREIGN KEY REFERENCES Intake(Int_Name) ON UPDATE CASCADE  ON DELETE CASCADE
)

-- Import the Student data file
GO
BULK INSERT Student
FROM 'C:\ITI\Power BI\GP\Database\Student.csv'
WITH (
  FIELDTERMINATOR = ',',  
  ROWTERMINATOR = '\n',
  FIRSTROW = 2
)

-- Std_Phone table
GO
CREATE TABLE Std_Phone (   
  Std_ID INT FOREIGN KEY REFERENCES Student(Std_ID),
  Std_PhoneNo INT, 
	PRIMARY KEY (Std_ID ,Std_PhoneNo)
)

-- Import the Std_Phone data file
GO
BULK INSERT Std_Phone
FROM 'C:\ITI\Power BI\GP\Database\Std_Phone.csv'
WITH (
  FIELDTERMINATOR = ',',  
  ROWTERMINATOR = '\n',
  FIRSTROW = 2
)

-- Std_CrsAttend table
GO
CREATE TABLE Std_CrsAttend (   
    Std_ID INT FOREIGN KEY REFERENCES Student(Std_ID),
    Crs_ID INT FOREIGN KEY REFERENCES Course(Crs_ID),
    AttndStatus INT,
    PRIMARY KEY (Std_ID ,Crs_ID)
)

-- Import the Std_CrsAttend data file
GO
BULK INSERT Std_CrsAttend
FROM 'C:\ITI\Power BI\GP\Database\Std_CrsAttend.csv'
WITH (
  FIELDTERMINATOR = ',',  
  ROWTERMINATOR = '\n',
  FIRSTROW = 2
)

-- Online_Crs table
GO
CREATE TABLE Online_Crs (
  OCrs_Id  INT PRIMARY KEY, 
  OCrs_Name VARCHAR(50),
  Cost VARCHAR(20)
)
drop table Online_Crs

-- Import the Online_Crs data file
GO
BULK INSERT Online_Crs
FROM 'C:\ITI\Power BI\GP\Database\Online_Crs.csv'
WITH (
  FIELDTERMINATOR = ',',  
  ROWTERMINATOR = '\n',
  FIRSTROW = 2
)

-- Std_OnlineCrs table
GO
CREATE TABLE Std_OnlineCrs (
  OCrs_Id INT FOREIGN KEY REFERENCES Online_Crs(OCrs_Id),
  Std_ID INT FOREIGN KEY REFERENCES Student(Std_ID),
  OCrs_StartDate VARCHAR(20),
  OCrs_CertDate VARCHAR(20), 
  CertURL VARCHAR(150),
  PRIMARY KEY (OCrs_Id ,Std_ID)
)

-- Import the Std_OnlineCrs data file
GO
BULK INSERT Std_OnlineCrs
FROM 'C:\ITI\Power BI\GP\Database\Std_OnlineCrs.csv'
WITH (
  FIELDTERMINATOR = ',',  
  ROWTERMINATOR = '\n',
  FIRSTROW = 2
)

-- Std_Feedback table
GO
CREATE TABLE Std_Feedback (
  FD_Id  INT PRIMARY KEY, 
  Crs_Material_helpful INT,
  Crs_Contant INT, 
  Crs_well_organised INT,
  Crs_Suitable_References INT,
  Inst_ClassTime INT,
  Inst_Responce_Qus INT,
  Inst_Explanation INT,
  Inst_GiveClearEx INT,
  Std_ID INT FOREIGN KEY REFERENCES Student(Std_ID)
)

-- Import the Std_Feedback data file
GO
BULK INSERT Std_Feedback
FROM 'C:\ITI\Power BI\GP\Database\Std_Feedback.csv'
WITH (
  FIELDTERMINATOR = ',',  
  ROWTERMINATOR = '\n',
  FIRSTROW = 2
)

--  Intake table
GO
CREATE TABLE Intake (
  Int_Name VARCHAR(30) PRIMARY KEY, 
  Int_BranchName VARCHAR(30),
  Int_StartDate DATE,
  Int_EndDate DATE
)

-- Import the Intake data file
GO
BULK INSERT Intake
FROM 'C:\ITI\Power BI\GP\Database\Intake.csv'
WITH (
  FIELDTERMINATOR = ',',  
  ROWTERMINATOR = '\n',
  FIRSTROW = 2
)

--  Grad_Std table
GO
CREATE TABLE Grad_Std (
  GStd_ID INT PRIMARY KEY, 
  GStd_HiringStatus INT,
  GStd_CompanyName VARCHAR(30), 
  GStd_PositionTitle VARCHAR(30),
  GStd_Salary INT,
  GStd_CertUrl VARCHAR(100),
  Int_Name VARCHAR(30) FOREIGN KEY REFERENCES Intake(Int_Name),
  Std_ID INT FOREIGN KEY REFERENCES Student(Std_ID)
)

-- Import the Grad_Std data file
GO
BULK INSERT Grad_Std
FROM 'C:\ITI\Power BI\GP\Database\Grad_Std.csv'
WITH (
  FIELDTERMINATOR = ',',  
  ROWTERMINATOR = '\n',
  FIRSTROW = 2
)

-- Exam table
GO
CREATE TABLE Exam (
    Ex_No INT PRIMARY KEY,
	Ex_Date VARCHAR(20),
	Ex_Duration INT,
	Crs_Id INT FOREIGN KEY REFERENCES Course(Crs_Id) ON UPDATE CASCADE  ON DELETE CASCADE
)

-- Import the Exam data file
GO
BULK INSERT Exam
FROM 'C:\ITI\Power BI\GP\Database\Exam.csv'
WITH (
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '\n',
  FIRSTROW = 2
)

-- Std_ExAnswer table
GO
CREATE TABLE Std_ExAnswer (
    Std_Id INT FOREIGN KEY REFERENCES Student(Std_Id),
	Ex_No INT FOREIGN KEY REFERENCES Exam(Ex_No),
	Qus_No INT FOREIGN KEY REFERENCES Question(Qus_No),
	Std_Ans INT,
    Std_Score INT,
    PRIMARY KEY (Std_Id, Ex_No, Qus_No)
)

-- Import the Std_ExAnswer data file
GO
BULK INSERT Std_ExAnswer
FROM 'C:\ITI\Power BI\GP\Database\Std_ExAnswer.csv'
WITH (
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '\n',
  FIRSTROW = 2
)

-- Exam Questions table
CREATE TABLE Exam_questions(
 Ex_No INT FOREIGN KEY REFERENCES Exam(Ex_No),
 Qus_No INT FOREIGN KEY REFERENCES Question(Qus_No) ON UPDATE CASCADE  ON DELETE CASCADE,
 Qus_Text VARCHAR(80),
 PRIMARY KEY (Ex_No, Qus_No)
)