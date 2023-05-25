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
			SELECT q.Qus_No, q.Qus_Text, C.Choice_Text [Student Answer], SE.Std_Score
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
GetStudentModelAnswer  @Ex_No = 654321, @Std_ID = 1

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
GetStdInfoByDeptNo @Dept_No = 10


