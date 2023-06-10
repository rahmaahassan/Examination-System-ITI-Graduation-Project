-- Std info by Dept No --
GO
CREATE PROCEDURE GetStdInfoByDeptNo
	@Dept_No INT
AS
BEGIN TRY
	IF NOT EXISTS (SELECT * FROM Department WHERE Dept_No = @Dept_No)
		BEGIN
            SELECT 'The department does not exist' AS 'ErrMessage'
        END
	ELSE
		BEGIN	
		    WITH StdDept AS (
			     SELECT DISTINCT sct.Std_ID, d.Dept_No
		         FROM Std_CrsAttend sct JOIN Course c
				 ON sct.Crs_ID = c.Crs_ID
				 INNER JOIN Instructor ins
				 ON c.Crs_ID = ins.Crs_Id
				 INNER JOIN Department d
				 ON ins.Dept_No = d.Dept_No
			)
			SELECT s.* 
			FROM Student s LEFT JOIN StdDept sd
			ON s.Std_ID = sd.Std_ID
			WHERE sd.Dept_No = @Dept_No
		END		
END TRY
BEGIN CATCH
	SELECT ERROR_MESSAGE() AS errorMessage
END CATCH

--Test --
GetStdInfoByDeptNo @Dept_No = 202

-- Student Model Answer --
GO
CREATE PROCEDURE GetStudentModelAnswer
    @Ex_No INT,
	@Std_ID INT
AS
BEGIN TRY
	IF NOT EXISTS (SELECT * FROM Exam WHERE Ex_No = @Ex_No)
		BEGIN
            SELECT 'The exam does not exist' AS 'ErrMessage'
        END
	ELSE IF NOT EXISTS (SELECT * FROM Student WHERE Std_ID = @Std_ID)
	    BEGIN
            SELECT 'The student does not exist' AS 'ErrMessage'
        END
	ELSE
		BEGIN	
			SELECT q.Qus_No, q.Qus_Text, C.Choice_Text [Student Answer],
			       CASE WHEN SE.Std_Score = 1 THEN 'True Answer'
				        WHEN SE.Std_Score = 0 THEN 'Wrong Answer'
						END AS [Answer Correction]
            FROM Std_ExAnswer SE
			INNER JOIN Exam E
            ON E.Ex_No = SE.Ex_No
			INNER JOIN Question Q
            ON SE.Qus_No = Q.Qus_No
            INNER JOIN Choices C
            ON Q.Qus_No = C.Qus_No AND C.Is_Correct = 1
			WHERE SE.Std_ID = @Std_ID AND SE.Ex_No = @Ex_No AND se.Qus_No = c.Qus_No
		END		
END TRY
BEGIN CATCH
	SELECT ERROR_MESSAGE() AS errorMessage
END CATCH

--Test --
GO
GetStudentModelAnswer  @Ex_No = 654321, @Std_ID = 1

-- Instructor course and student
GO
CREATE PROCEDURE PCoursesAndStudentByInstuctorId
 @InstructorID INT
As
Begin
 Select Department.Dept_Name as [Department Name],Instructor.Ins_Name as [Instructor Name],
 Course.Crs_Name as[Course Name],Count(distinct Std_CrsAttend.Std_ID) AS Student_Number
 From   Instructor,Student,Course,Std_CrsAttend,Department
 where  Instructor.Crs_Id=Course.Crs_ID
 and    Course.Crs_ID=Std_CrsAttend.Crs_ID
 and    Std_CrsAttend.Std_ID=Student.Std_ID
 and    Department.Dept_No=Instructor.Dept_No
 and    Instructor.Ins_ID=@InstructorID
 
 group by Course.Crs_Name,Department.Dept_Name,Instructor.Ins_Name
End

go
EXEC PCoursesAndStudentByInstuctorId @InstructorID=9

-- Student Grade
GO
CREATE PROCEDURE studentgradesbyid
       @Std_Id INT
AS
Begin
select VStdCrsGrade.Crs_Name AS[Courses Names],VStdCrsGrade.Std_Grade as [Student Grades]
from VStdCrsGrade
where VStdCrsGrade.Std_Id=@Std_Id
End

-- Topic Courses
GO
CREATE PROCEDURE SELECTTOPICS
    @Crs_ID INT 
AS
BEGIN
    SELECT Crs_ID, Crs_Name, C.Topic_Id, Topic_Name
    FROM Course C , Topic T
    Where C.Topic_Id = T.Topic_Id and Crs_ID=@Crs_ID
End

-- Exam Model
GO
create procedure TakeExam 
@Ex_No INT 
as 
begin 
select q.Qus_Text, c.Choice_Text 
from Exam_Question e 
inner join Choices c 
on e.Qus_No=c.Qus_No 
inner join question q 
on c.Qus_No=q.Qus_No 
where e.Ex_No=@Ex_No 
END 
 
EXEC TakeExam @Ex_No=109024 
 
 
ALTER  procedure [dbo].[TakeExam] @Ex_No INT 
as  
begin 
DECLARE @myCursor CURSOR; 
DECLARE @myField INT;   
CREATE TABLE #Exam ( 
Quest_Answer VARCHAR(Max) 
); 
 
set @myCursor = CURSOR for 
select Qus_No from Exam_Question where Ex_No=@Ex_No 
OPEN @myCursor 
FETCH NEXT FROM @myCursor INTO @myField; 
WHILE @@FETCH_STATUS = 0 
BEGIN 
insert into #Exam  select Qus_Text from question  where Qus_No=@myField 
insert into #Exam  select CONCAT(char(96+ ROW_NUMBER() over ( partition by Qus_No order by Choice_Text )) , ' )  ',Choice_Text) from Choices  where Qus_No=@myField 
insert into #Exam   values ('') 
 
    FETCH NEXT FROM @myCursor INTO @myField; 
END; 
 
 
CLOSE @myCursor; 
DEALLOCATE @myCursor; 
 
select * from #Exam 
end 
EXEC TakeExam 109024