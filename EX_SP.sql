-- Exam Generation --
Go
CREATE PROCEDURE GenerateAnExam
    @Ex_NO INT,
	@Crs_ID INT,
    @Ex_Duration INT,
    @Num_TF_Questions INT,
    @Num_MCQ_Questions INT
AS
BEGIN TRY
	IF NOT EXISTS (SELECT * FROM Course WHERE Crs_ID = @Crs_ID)
	    BEGIN
            SELECT 'The course does not exist' AS 'ErrMessage'
        END
    ELSE
        BEGIN
            -- Generate a random exam with 10 questions
            INSERT INTO Exam (Ex_NO, Ex_Date, Ex_Duration, Crs_ID)
            VALUES (@Ex_NO, GETDATE(), @Ex_Duration, @Crs_ID);

            -- Select True/False questions related to the same course
            INSERT INTO Exams_questions (Ex_No, Qus_No, Qus_Text)
            SELECT TOP (@Num_TF_Questions) @Ex_No, Q.Qus_No, Q.Qus_Text
            FROM Question Q
            WHERE Q.Crs_ID = @Crs_ID AND Q.Qus_Type = 't/f'
            ORDER BY NEWID();

            -- Select Multiple Choice questions related to the same course
            INSERT INTO Exams_questions (Ex_No, Qus_No)
            SELECT TOP (@Num_MCQ_Questions) @Ex_No, Q.Qus_No
            FROM Question Q
            WHERE Q.Crs_ID = @Crs_ID AND Q.Qus_Type = 'mcq'
            ORDER BY NEWID();
    
            -- Select exam model
            SELECT Q.* 
            FROM Exams_questions eq, Question Q, Exam E
			WHERE eq.Ex_No = E.Ex_No AND eq.Qus_No = Q.Qus_No AND eq.Ex_No = @Ex_No
        END
END TRY
BEGIN CATCH
	SELECT ERROR_MESSAGE() AS errorMessage
END CATCH

-- Test --
GO
GenerateExam @Ex_No = 13574, @Crs_ID = 112, @Ex_Duration = 15, @Num_TF_Questions = 5, @Num_MCQ_Questions = 10

-- Exam Answers --
GO
CREATE PROCEDURE SaveStudentExamAnswers
    @Ex_No INT,
    @Std_ID INT,
    @Qus_No INT,
    @Std_Ans INT
AS
BEGIN TRY
	IF NOT EXISTS (SELECT * FROM Exam WHERE Ex_No = @Ex_No)
		BEGIN
            SELECT 'The exam does not exist' AS 'ErrMessage'
        END
	ELSE IF NOT EXISTS (SELECT * FROM Question WHERE Qus_No = @Qus_No)
	    BEGIN
            SELECT 'The question does not exist' AS 'ErrMessage'
        END
	ELSE IF NOT EXISTS (SELECT * FROM Student WHERE Std_ID = @Std_ID)
	    BEGIN
            SELECT 'The student does not exist' AS 'ErrMessage'
        END
	ELSE
        BEGIN 
            INSERT INTO Std_ExAnswer (Std_ID, Ex_No, Qus_No, Std_Ans)
            VALUES (@Std_ID, @Ex_No, @Qus_No, @Std_Ans);
        END
END TRY

BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- Test --
GO
SaveExamAnswers @Ex_No = 123456, @Std_ID = 1, @Qus_No = 21, @Std_Ans = 2

-- Exam Correction & Student grade --
GO
CREATE PROCEDURE StudentModelAnswer
    @Std_ID INT,
    @Ex_No INT
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
            -- Update Std_Score based on the student's answers
            UPDATE SE
            SET Std_Score = CASE WHEN C.Is_Correct = 1 THEN 1 ELSE 0 END
            FROM Std_ExAnswer SE
            INNER JOIN Choices C ON SE.Qus_No = C.Qus_No
            WHERE SE.Ex_No = @Ex_No AND SE.Std_ID = @Std_ID

            -- Calculate the total number of correct answers
            DECLARE @TotalCorrectAnswers INT;
            SELECT @TotalCorrectAnswers = SUM(Std_Score)
            FROM Std_ExAnswer
            WHERE Ex_No = @Ex_No AND Std_ID = @Std_ID;
       
            -- Calculate the grade in percentage
            DECLARE @GradePercentage DECIMAL(5, 2);
            SELECT @GradePercentage = (@TotalCorrectAnswers * 100.0) / 20.0;

            -- Return the grade percentage
            SELECT @GradePercentage AS GradePercentage;
        END
 
END TRY
BEGIN CATCH
	SELECT ERROR_MESSAGE() AS errorMessage
END CATCH

-- Test --
GO
ExamGrade @Ex_No = 123456, @Std_ID = 1