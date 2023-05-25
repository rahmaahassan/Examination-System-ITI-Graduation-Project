-- Student Grades in Courses
CREATE VIEW VStdCrsGrade AS
SELECT sx.Std_Id, c.Crs_Name, ROUND(SUM(sx.Std_Score) * 100 / COUNT(sx.Ex_No), 2) Std_Grade
FROM Std_ExAnswer sx LEFT JOIN Exam e
ON sx.Ex_No = e.Ex_No
JOIN Course c
ON e.Crs_Id = c.Crs_ID
GROUP BY  sx.Std_Id, c.Crs_Name

-- Department Students
CREATE VIEW DepartmentStudents AS
WITH StdDept AS (
			     SELECT DISTINCT sct.Std_ID, d.Dept_Name DepaertmentName
		         FROM Std_CrsAttend sct JOIN Course c
				 ON sct.Crs_ID = c.Crs_ID
				 INNER JOIN Instructor ins
				 ON c.Crs_ID = ins.Crs_Id
				 INNER JOIN Department d
				 ON ins.Dept_No = d.Dept_No
			)
SELECT s.Std_ID, s.Std_Name, sd.DepaertmentName
FROM Student s LEFT JOIN StdDept sd
ON s.Std_ID = sd.Std_ID

-- Student Enrollment In course
CREATE VIEW VStudentEnrollCourse AS
SELECT sa.*
FROM Student s JOIN Std_CrsAttend sa
ON s.Std_ID = sa.Std_ID
WHERE s.Std_ID not in (
                SELECT GStd_ID
				FROM Grad_Std
				)
