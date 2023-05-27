----- SPs -----

----- Topic table -----

----- SP SELECT
GO
CREATE PROCEDURE SelectTopic
AS
BEGIN
    SELECT *
	FROM Topic
END

----- SP INSERT
GO
CREATE PROCEDURE InsertTopic
    @topic_name VARCHAR(20)
AS
BEGIN
    INSERT INTO Topic
	VALUES(@topic_name)
END

----- SP UPDATE
GO
CREATE PROCEDURE UpdateTopic
    @topic_id INT,
    @new_topic_name VARCHAR(20)
AS
BEGIN
    UPDATE Topic
	SET Topic_Name = @new_topic_name
	WHERE Topic_Id = @topic_id
END

----- SP DELETE
GO
CREATE PROCEDURE DeleteTopic
    @topic_id INT
AS
BEGIN
    DELETE FROM Topic
	WHERE Topic_Id = @topic_id
END

----- Course table -----

----- SP SELECT
GO
CREATE PROCEDURE SelectCourse
AS
BEGIN
    SELECT *
	FROM Course
END

----- SP INSERT
GO
CREATE PROCEDURE InsertCousre
    @Crs_Id INT,
	@Crs_Name VARCHAR(20),
	@Topic_Id INT
AS
BEGIN
    INSERT INTO Course
	VALUES(@Crs_Id,@Crs_Name, @Topic_Id)
END

----- SP UPDATE
GO
CREATE PROCEDURE UpdateCourse
    @Crs_Id INT,
    @New_Topic_Id INT
AS
BEGIN
    UPDATE Course
	SET Topic_Id = @New_Topic_Id
	WHERE Crs_Id = @Crs_Id
END

----- SP DELETE
GO
CREATE PROCEDURE DeleteCourse
    @Crs_Id INT
AS
BEGIN
    DELETE FROM Course
	WHERE Crs_ID = @Crs_Id
END

----- Question table -----

----- SP SELECT
GO
CREATE PROCEDURE SelectQuestion
AS
BEGIN
    SELECT *
	FROM Question
END

----- SP INSERT
GO
CREATE PROCEDURE InsertQuestion
    @Qus_No INT,
	@Choice_Text VARCHAR(200),
    @Qus_Type VARCHAR(10),
	@Crs_ID INT
AS
BEGIN
    INSERT INTO Question
	VALUES(@Qus_No, @Choice_Text, @Qus_Type, @Crs_ID)
END

----- SP UPDATE
GO
CREATE PROCEDURE UpdateQuestion
    @Qus_No INT,
    @New_Crs_Id INT
AS
BEGIN
    UPDATE Question
	SET Crs_ID = @New_Crs_Id
	WHERE Qus_No = @Qus_No
END

----- SP DELETE
GO
CREATE PROCEDURE DeleteQuestion
    @Qus_No INT
AS
BEGIN
    DELETE FROM Question
	WHERE Qus_No = @Qus_No
END

----- Choices table -----

----- SP SELECT
GO
CREATE PROCEDURE SelectChoices
AS
BEGIN
    SELECT *
	FROM Choices
END

----- SP INSERT
GO
CREATE PROCEDURE InsertChoices
    @Choice_Id INT,
	@Choice_Text VARCHAR(200),
    @Is_Correct INT,
	@Qus_No INT
AS
BEGIN
    INSERT INTO Choices
	VALUES(@Choice_Id, @Choice_Text, @Is_Correct, @Qus_No)
END

----- SP UPDATE
GO
CREATE PROCEDURE UpdateChoices
    @Choice_Id INT,
    @New_Choice_Text VARCHAR(200)
AS
BEGIN
    UPDATE Choices
	SET Choice_Text = @New_Choice_Text
	WHERE Choice_Id = @Choice_Id
END

----- SP DELETE
GO
CREATE PROCEDURE DeleteChoices
    @Choice_Id INT
AS
BEGIN
    DELETE FROM Choices
	WHERE Choice_Id = @Choice_Id
END

----- Department table -----

----- SP SELECT
GO
CREATE PROCEDURE SelectDepartment
AS
BEGIN
    SELECT *
	FROM Department
END

----- SP INSERT
GO
CREATE PROCEDURE InsertDepartment
    @Dept_No INT,
	@Dept_Name VARCHAR(20),
	@Dept_Location VARCHAR(20),
    @Mngr_Id INT
AS
BEGIN
    INSERT INTO Department
	VALUES(@Dept_No, @Dept_Name, @Dept_Location, @Mngr_Id)
END

----- SP UPDATE
GO
CREATE PROCEDURE UpdateDepartment
    @Dept_No INT,
    @New_Mngr_Id INT
AS
BEGIN
    UPDATE Department
	SET Mngr_Id = @New_Mngr_Id
	WHERE Dept_No = @Dept_No
END

----- SP DELETE
GO
CREATE PROCEDURE DeleteDepartment
    @Dept_No INT
AS
BEGIN
    DELETE FROM Department
	WHERE Dept_No = @Dept_No
END

----- Instructor table -----

----- SP SELECT
GO
CREATE PROCEDURE SelectInstructor
AS
BEGIN
    SELECT *
	FROM Instructor
END

----- SP INSERT
GO
CREATE PROCEDURE InsertInstructor
    @Ins_ID INT,
	@Ins_Name VARCHAR(25),
	@Ins_Gender VARCHAR(20),
	@Ins_DOB VARCHAR(20),
	@Ins_City VARCHAR(20),
	@Ins_Street VARCHAR(20),
	@Ins_Email VARCHAR(40),
	@Ins_Salary INT,
	@Crs_Id INT
AS
BEGIN
    INSERT INTO Instructor
	VALUES(@Ins_ID, @Ins_Name, @Ins_Gender, @Ins_DOB, @Ins_City, @Ins_Street, @Ins_Email, @Ins_Salary, @Crs_Id)
END

----- SP UPDATE
GO
CREATE PROCEDURE UpdateInstructor
    @Ins_ID INT,
    @New_Ins_Salary INT
AS
BEGIN
    UPDATE Instructor
	SET Ins_Salary = @New_Ins_Salary
	WHERE Ins_ID = @Ins_ID
END

----- SP DELETE
GO
CREATE PROCEDURE DeleteInstructor
    @Ins_ID INT
AS
BEGIN
    DELETE FROM Instructor
	WHERE Ins_ID = @Ins_ID
END

----- Std_Phone table -----

----- SP SELECT
GO
CREATE PROCEDURE SelectStd_Phone
AS
BEGIN
    SELECT *
	FROM Std_Phone
END

----- SP INSERT
GO
CREATE PROCEDURE InsertStd_Phone
    @Std_ID INT,
    @Std_Phone INT
AS
BEGIN
 	INSERT INTO Std_Phone
    VALUES(@Std_ID, @Std_Phone)
    
END

----- SP UPDATE
GO
CREATE PROCEDURE UpdateStd_Phone
    @Std_ID INT,
    @Std_Phone INT,
    @New_Std_Phone INT
AS
BEGIN
    UPDATE Std_Phone
	SET Std_PhoneNo = @New_Std_Phone
	WHERE Std_ID = @Std_ID AND Std_Phone = @Std_Phone
END

----- SP DELETE
GO
CREATE PROCEDURE DeleteStd_Phone
    @Std_ID INT,
    @Std_PhoneNo INT
AS
BEGIN
    DELETE FROM Std_Phone
	WHERE Std_ID = @Std_ID AND Std_PhoneNo = @Std_PhoneNo
END

----- Student table -----

----- SP SELECT
GO
CREATE PROCEDURE SelectStudent
AS
BEGIN
    SELECT *
	FROM Student
END

----- SP INSERT
GO
CREATE PROCEDURE InsertStudent
    @Std_ID INT,
    @Std_SSN INT,
    @Std_Name VARCHAR(20),
	@Std_City VARCHAR(20)
AS
BEGIN
    INSERT INTO Student (Std_ID, Std_Name, Std_SSN, Std_City)
	VALUES(@Std_ID, @Std_Name,@Std_SSN,@Std_City)
END

----- SP UPDATE
GO
CREATE PROCEDURE UpdateStudent
    @Std_ID INT,
	@New_Std_City VARCHAR(20)
AS
BEGIN
    UPDATE Student
	SET Std_City = @New_Std_City
	WHERE Std_ID = @Std_ID
END

----- SP DELETE
GO
CREATE PROCEDURE DeleteStudent
    @Std_ID INT
AS
BEGIN
    DELETE FROM Student
	WHERE Std_ID = @Std_ID
END

----- Std_CrsAttend table -----

----- SP SELECT
GO
CREATE PROCEDURE SelectStd_CrsAttend
AS
BEGIN
    SELECT *
	FROM Std_CrsAttend
END

----- SP INSERT
GO
CREATE PROCEDURE InsertStd_CrsAttend
	@Std_ID INT,
    @Crs_ID INT,
    @AttndStatus INT
AS
BEGIN
    INSERT INTO Std_CrsAttend
	VALUES(@Std_ID, @Crs_ID, @AttndStatus)
END

----- SP UPDATE
GO
CREATE PROCEDURE UpdateStd_CrsAttend
    @Std_ID INT,
    @Crs_ID INT,
    @New_AttndStatus INT
AS
BEGIN
    UPDATE Std_CrsAttend
	SET AttndStatus = @New_AttndStatus
	WHERE Std_ID = @Std_ID AND Crs_ID = @Crs_ID
END

----- SP DELETE
GO
CREATE PROCEDURE DeleteStd_CrsAttend
    @Std_ID INT,
	@Crs_ID INT
AS
BEGIN
    DELETE FROM Std_CrsAttend
	WHERE Std_ID = @Std_ID AND Crs_ID = @Crs_ID
END

----- Std_OnlineCrs table -----

----- SP SELECT
GO
CREATE PROCEDURE SelectStd_OnlineCrs
AS
BEGIN
    SELECT *
	FROM Std_OnlineCrs
END

----- SP INSERT
GO
CREATE PROCEDURE InsertStd_OnlineCrs
    @OCrs_Id INT,
    @Std_ID INT,
    @CertURL VARCHAR(80)
AS
BEGIN
    INSERT INTO Std_OnlineCrs (OCrs_ID, Std_ID, CertURL)
	VALUES(@OCrs_Id, @Std_ID, @CertURL)
END

----- SP UPDATE
GO
CREATE PROCEDURE UpdateStd_OnlineCrs
    @OCrs_Id INT,
    @Std_ID INT,
    @New_CertURL VARCHAR(80)
AS
BEGIN
    UPDATE Std_OnlineCrs
	SET CertURL = @New_CertURL
	WHERE OCrs_Id = @OCrs_Id AND Std_ID = @Std_ID
END

----- SP DELETE
GO
CREATE PROCEDURE DeleteStd_OnlineCrs
    @OCrs_Id INT,
    @Std_ID INT
AS
BEGIN
    DELETE FROM Std_OnlineCrs
	WHERE OCrs_Id = @OCrs_Id AND Std_ID = @Std_ID
END

----- Online_Crs table -----

----- SP SELECT
GO
CREATE PROCEDURE SelectOnline_Crs
AS
BEGIN
    SELECT *
	FROM Online_Crs
END

----- SP INSERT
GO
CREATE PROCEDURE InsertOnline_Crs
    @OCrs_Id INT,
	@OCrs_Name VARCHAR(20)

AS
BEGIN
    INSERT INTO Online_Crs
	VALUES(@OCrs_Id, @OCrs_Name)
END

----- SP UPDATE
GO
CREATE PROCEDURE UpdateOnline_Crs
    @OCrs_Id INT,
    @New_OCrs_Name VARCHAR(20)
AS
BEGIN
    UPDATE Online_Crs
	SET OCrs_Name = @New_OCrs_Name
	WHERE OCrs_Id = @OCrs_Id
END

----- SP DELETE
GO
CREATE PROCEDURE DeleteOnline_Crs
    @OCrs_Id INT
AS
BEGIN
    DELETE FROM Online_Crs
	WHERE OCrs_ID = @OCrs_Id
END

----- Std_Feedback table -----

----- SP SELECT
GO
CREATE PROCEDURE SelectStd_Feedback
AS
BEGIN
    SELECT *
	FROM Std_Feedback
END

----- SP INSERT
GO
CREATE PROCEDURE InsertStd_Feedback
    @FD_Id INT,
    @Std_ID INT,
    @Crs_Material_helpful INT,
    @Crs_Contant INT
AS
BEGIN
    INSERT INTO Std_Feedback (FD_Id, Std_ID, Crs_Material_helpful, Crs_Contant)
	VALUES(@FD_Id, @Std_ID, @Crs_Material_helpful, @Crs_Contant)
END

----- SP UPDATE
GO
CREATE PROCEDURE UpdateStd_Feedback
    @FD_Id INT,
    @Std_ID INT,
    @New_Crs_Material_helpful INT
AS
BEGIN
    UPDATE Std_Feedback
	SET Crs_Material_helpful = @New_Crs_Material_helpful
	WHERE FD_Id = @FD_Id AND Std_ID = @Std_ID
END

----- SP DELETE
GO
CREATE PROCEDURE DeleteStd_Feedback
    @FD_Id INT,
    @Std_ID INT
AS
BEGIN
    DELETE FROM Std_Feedback
	WHERE FD_Id = @FD_Id AND Std_ID = @Std_ID
END

----- Intake table -----

----- SP SELECT
GO
CREATE PROCEDURE SelectIntake
AS
BEGIN
    SELECT *
	FROM Intake
END

----- SP INSERT
GO
CREATE PROCEDURE InsertIntake
   @Int_Name  VARCHAR(30), 
   @Int_BranchName VARCHAR(30)
AS
BEGIN
    INSERT INTO Intake (Int_Name ,Int_BranchName)
	VALUES (@Int_Name, @Int_BranchName)
END

----- SP UPDATE
GO
CREATE PROCEDURE UpdateIntake
    @Int_Name VARCHAR(30),
	@New_Int_BranchName VARCHAR(30)
AS
BEGIN
    UPDATE Intake
	SET Int_BranchName = @New_Int_BranchName
	WHERE Int_Name = @Int_Name
END

----- SP DELETE 
GO
CREATE PROCEDURE DeleteIntake
    @Int_Name  VARCHAR(30)
AS
BEGIN
    DELETE FROM Intake
	WHERE Int_Name = @Int_Name
END

----- Grad_Std table -----

-- SP SELECT
GO
CREATE PROCEDURE SelectGrad_Std
AS
BEGIN
    SELECT *
	FROM Grad_Std
END

-- SP INSERT
GO
CREATE PROCEDURE InsertGrad_Std
    @GStd_ID INT,
	@GSts_HiringStatus INT,
	@Int_Name INT
AS
BEGIN
    INSERT INTO Grad_Std(GStd_ID, GStd_HiringStatus, Int_Name)
	VALUES(@GStd_ID, @GSts_HiringStatus, @Int_Name)
END

-- SP UPDATE
GO
CREATE PROCEDURE UpdateGrad_Std
    @GStd_ID INT,
	@New_GStd_HiringStatus INT
AS
BEGIN
    UPDATE Grad_Std
	SET GStd_HiringStatus = @New_GStd_HiringStatus
	WHERE GStd_ID = @GStd_ID 
END

-- SP DELETE
GO
CREATE PROCEDURE DeleteGrad_Std
    @GStd_ID INT
AS
BEGIN
    DELETE FROM Grad_Std
	WHERE GStd_ID = @GStd_ID
END

----- Ins_Phone table -----

----- SP SELECT
GO
CREATE PROCEDURE SelectIns_Phone
AS
BEGIN
    SELECT *
	FROM Ins_Phone
END

----- SP INSERT
GO
CREATE PROCEDURE InsertIns_Phone
    @Ins_ID INT,
    @Ins_PhoneNo INT
AS
BEGIN
 	INSERT INTO Ins_Phone
    VALUES(@Ins_ID, @Ins_PhoneNo)
    
END

----- SP UPDATE
GO
CREATE PROCEDURE UpdateIns_Phone
    @Ins_ID INT,
    @Ins_PhoneNo INT,
    @New_Ins_PhoneNo INT
AS
BEGIN
    UPDATE Ins_Phone
	SET Ins_PhoneNo = @New_Ins_PhoneNo
	WHERE Ins_ID = @Ins_ID AND Ins_PhoneNo = @Ins_PhoneNo
END

----- SP DELETE
GO
CREATE PROCEDURE DeleteIns_Phone
    @Ins_ID INT,
    @Ins_PhoneNo INT
AS
BEGIN
    DELETE FROM Ins_Phone
	WHERE Ins_ID = @Ins_ID AND Ins_PhoneNo = @Ins_PhoneNo
END

/*
----- test

go
EXEC SelectCourse
go
EXEC InsertCousre @Crs_Id = 12 ,@Crs_Name = 'DDL', @Topic_Id = 4
go
EXEC SelectCourse
go
EXEC UpdateCourse @Crs_Id = 12, @New_Topic_Id = 5
go
EXEC SelectTopic 
go
EXEC DeleteCourse @Crs_Id = 12
go
EXEC SelectTopic 
*/