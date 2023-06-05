-- Student Grades in Courses
GO
CREATE VIEW VStdCrsGrade AS
SELECT sx.Std_Id, c.Crs_Name, ROUND(SUM(sx.Std_Score) * 100 / COUNT(sx.Ex_No), 2) Std_Grade
FROM Std_ExAnswer sx LEFT JOIN Exam e
ON sx.Ex_No = e.Ex_No
JOIN Course c
ON e.Crs_Id = c.Crs_ID
GROUP BY sx.Std_Id, c.Crs_Name

-- Department Students
GO
CREATE VIEW VDepartmentStudents AS
WITH StdDept AS (
			     SELECT std.Std_ID, d.Dept_Name Depaertment
		         FROM Std_CrsAttend std INNER JOIN Course c
				 ON std.Crs_ID = c.Crs_ID
				 INNER JOIN Instructor i
				 ON i.Crs_Id = c.Crs_ID
				 LEFT JOIN Department d
				 ON i.Dept_No = d.Dept_No
			)

SELECT DISTINCT s.Std_ID, s.Std_Name, sd.Depaertment
FROM Student s LEFT JOIN StdDept sd
ON s.Std_ID = sd.Std_ID

-- Student Enrollment In course
GO
CREATE VIEW VStudentEnrollCourse AS
SELECT sa.*
FROM Student s JOIN Std_CrsAttend sa
ON s.Std_ID = sa.Std_ID
WHERE s.Std_ID not in (
                SELECT Grd_ID
				FROM Grad_Std
				)

-- Student Model Answer
GO
CREATE VIEW VStudentModelAnswer AS
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

-- Department Topics
CREATE VIEW VDepartmentTopic AS
SELECT t.Topic_Id, d.Dept_Name
FROM Topic t JOIN course c
on t.Topic_Id = c.Topic_Id
JOIN instructor i
on c.Crs_ID = i.Crs_Id
JOIN Department d
on i.Dept_No = d.Dept_No

-- Student Attend
CREATE VIEW VStudentAttend AS
SELECT Std_id, Std_EventStatus
FROM Student 
WHERE Std_id not in (
SELECT Std_ID
From Grad_Std
)