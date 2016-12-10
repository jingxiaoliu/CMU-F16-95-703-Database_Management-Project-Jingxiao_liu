connect casteel/tiger
SET ECHO ON
START C:\DBM\Project\Script#1.sql
START C:\DBM\Project\Script#2.sql
SPOOL C:\DBM\Project\Output.txt
SET pagesize 2000
SET linesize 3000

COLUMN emp_ID FORMAT 99990
COLUMN sup_ID FORMAT 99990
COLUMN emp_Fname FORMAT A12
COLUMN emp_Fname FORMAT A12
COLUMN emp_Lname FORMAT A10
COLUMN street FORMAT A20
COLUMN city FORMAT A15
COLUMN crs_Title FORMAT A35
COLUMN crs_Type FORMAT A10
SELECT * FROM employee;
SELECT * FROM department;
SELECT * FROM training;
SELECT * FROM course;
SELECT * FROM instructor;
SELECT * FROM class;
SELECT * FROM grade_score;
--Q1
CLEAR COLUMNS
COLUMN employee FORMAT A30
COLUMN GPA FORMAT 0.99
SELECT DISTINCT emp_ID || '-' || emp_Lname || ', ' || emp_Fname AS employee,
	   COUNT(emp_ID) AS "# of times", AVG(score) AS GPA, crs_ID
FROM   grade_score JOIN training USING(grade)
				   JOIN employee USING(emp_ID)
GROUP BY emp_ID,emp_Lname,emp_Fname,crs_ID
HAVING COUNT(emp_ID) > 1;
--Q2
--Assumption: The fiscal year in the USA is from OCT 1st to next year's Sept 30th. In order to make sure that
--every semester is finished in one fiscal year. We assume that the fall semester is from AUG 1st to SEPT 30th,
--and the spring semester is from FEB 1st to MAR 31st. Thus, we should use different semesters' records in 
--different month. 
CLEAR COLUMNS
COLUMN employee FORMAT A30
SELECT employee, email, "# of classes"
FROM(SELECT DISTINCT emp_ID || '-' || emp_Lname || ', ' || emp_Fname AS employee, email,
		    COUNT(emp_ID) AS "# of classes", AVG(score) AS "GPA"
	 FROM   employee JOIN training USING(emp_ID)
					 JOIN class USING(crs_ID, section, sem_Cmpleted)
					 JOIN course USING(crs_ID)
					 JOIN grade_score USING(grade)
	 WHERE  (LOWER(crs_Title) = 'database mngt' OR LOWER(crs_Type) = 'dbm')
	        AND (TO_NUMBER(SUBSTR(sem_Cmpleted,INSTR(sem_Cmpleted,' ')+1,INSTR(sem_Cmpleted,' ')+4)) > EXTRACT(YEAR FROM SYSDATE)-3
	             OR sem_Cmpleted = (CASE 
			                        WHEN EXTRACT(MONTH FROM SYSDATE) BETWEEN 1 AND 9 THEN 'Fall '
							        ELSE NULL END) || TO_CHAR(EXTRACT(YEAR FROM SYSDATE)-3)
	             OR sem_Cmpleted = (CASE 
			                        WHEN EXTRACT(MONTH FROM SYSDATE) BETWEEN 1 AND 3 THEN 'Spring '
							        ELSE NULL END) || TO_CHAR(EXTRACT(YEAR FROM SYSDATE)-3))
	 GROUP BY emp_ID,emp_Lname,emp_Fname,email)
WHERE "GPA" > 0.00;
--Q3
CLEAR COLUMNS
COLUMN department FORMAT A35
COLUMN "Total budget" FORMAT $99990
COLUMN CLasses FORMAT 99
SELECT dept_ID || ' - ' || dept_Name AS department, COUNT(TID) AS "# of trainings",
       COUNT(DISTINCT crs_ID || sem_Cmpleted || section) AS "# of classes",
       SUM(NVL(tuition,0)) AS "Total budget",
	   RANK() OVER (ORDER BY SUM(NVL(tuition,0)) DESC) AS Rank
FROM   department JOIN employee USING(dept_ID)
                  LEFT OUTER JOIN training USING(emp_ID)
				  LEFT OUTER JOIN class USING(crs_ID, section, sem_Cmpleted)
			      LEFT OUTER JOIN course USING(crs_ID)
GROUP BY dept_ID, dept_Name;
--Q4
CLEAR COLUMNS
COLUMN instructor FORMAT A35
COLUMN class FORMAT A55
SELECT DISTINCT instr_ID || '-' || instr_Lname || ', ' || instr_Fname AS Instructor, instr_Phone AS PhoneNum,
       crs_ID || '-' || crs_Title || ', ' || section || ', ' || sem_Cmpleted AS Class
FROM   instructor JOIN class USING(instr_ID)
                  JOIN course USING(crs_ID)
				  JOIN training USING(crs_ID, section, sem_Cmpleted)
WHERE  grade <> 'R';
--Q5
CLEAR COLUMNS
COLUMN "Previous Semester" FORMAT 0.99
COLUMN "Current Semester" FORMAT 0.99
COLUMN "Following Semester"	 FORMAT 0.99
COLUMN semester FORMAT A15
SELECT L || R AS semester,
       LAG(grade, 1) OVER (ORDER BY R, L DESC) AS "Previous Semester",
	   grade AS "Current Semester",
       LEAD(grade, 1) OVER (ORDER BY R, L DESC) AS "Following Semester"	   
FROM(
SELECT SUBSTR(semester,1,INSTR(semester,' ')) AS L, SUBSTR(semester,INSTR(semester,' ')+1,INSTR(semester,' ')+4) AS R, grade
FROM(
SELECT DISTINCT sem_Cmpleted AS semester, ROUND(AVG(score),2) AS grade
FROM   training JOIN grade_score USING(grade)
GROUP BY sem_Cmpleted))
ORDER BY R, L DESC;
--Q6
CLEAR COLUMNS
SELECT tuition, COUNT(tuition) AS "# of Classes"
FROM(SELECT (CASE
             WHEN tuition > 0 AND tuition <= 1000 THEN 'Inexpensive'
		     WHEN tuition > 1000 AND tuition <= 2000 THEN 'Moderate'
		     WHEN tuition > 2000 THEN 'Expensive'
		     WHEN tuition IS NULL OR tuition = 0 THEN 'Unknown' END) AS tuition
     FROM    class JOIN course USING(crs_ID))
     RIGHT OUTER JOIN 
	 (SELECT 'Inexpensive' AS tuition FROM class
      UNION 
	  SELECT 'Moderate' AS tuition FROM class
	  UNION
	  SELECT 'Expensive' AS tuition FROM class
	  UNION
	  SELECT 'Unknown' AS tuition FROM class) USING(tuition)
GROUP BY tuition
ORDER BY 2 DESC;
--Q7
--Assumption: Number of classes attended is defined as the classes registered by employees. Thus, we counted
--classes, not trainings here.
COLUMN "Total tuition" FORMAT $999990
SELECT college_Name, COUNT(DISTINCT Offered) AS "# of Classes Offered",
       COUNT(DISTINCT CASE
	         WHEN TID IS NOT NULL 
			 THEN offered
			 END) AS "# of Classes Attended",
	   SUM(DECODE(TID,NULL,0,tuition)) AS "Total tuition"
FROM(SELECT college_Name, crs_ID || sem_Cmpleted || section AS Offered, tuition, TID
     FROM class LEFT OUTER JOIN training USING(crs_ID, section, sem_Cmpleted)
                           JOIN course USING(crs_ID))
GROUP BY college_Name;
--Q8
CLEAR COLUMNS
COLUMN employee FORMAT A30
SELECT DISTINCT emp_ID || '-' || emp_Lname || ', ' || emp_Fname AS employee, 
       COUNT(crs_ID) AS "# of Classes",
       DENSE_RANK() OVER (ORDER BY COUNT(crs_ID) DESC) AS Rank
FROM   employee LEFT OUTER JOIN training USING(emp_ID)
                LEFT OUTER JOIN class USING(crs_ID, section, sem_Cmpleted)
GROUP BY emp_ID,emp_Lname,emp_Fname
ORDER BY rank;
--Q9
CLEAR COLUMNS
COLUMN employee FORMAT A30
COLUMN crs_Title FORMAT A35
COLUMN "Semester and Grade (a)" FORMAT A22
COLUMN "Semester and Grade (b)" FORMAT A22
SELECT employee, crs_Title, A.Sem_Grade AS "Semester and Grade (a)", B.Sem_Grade AS "Semester and Grade (b)"
FROM(
	(SELECT DISTINCT emp_ID || ' - ' || emp_Lname || ', ' || emp_Fname AS employee, crs_Title, 
		   sem_Cmpleted || ', ' || grade AS Sem_Grade
	FROM
	((SELECT emp_Lname, emp_Fname, emp_ID,
				  crs_Title, crs_ID, COUNT(crs_ID) AS courseNum
		   FROM   employee JOIN training USING(emp_ID)
						   JOIN course USING(crs_ID)
		   GROUP BY emp_Lname,emp_Fname, emp_ID,crs_Title, crs_ID
		   HAVING COUNT(crs_ID)>1)
	JOIN
	training USING(emp_ID,crs_ID))) A
	JOIN
	(SELECT DISTINCT emp_ID || ' - ' || emp_Lname || ', ' || emp_Fname AS employee, crs_Title, 
		   sem_Cmpleted || ', ' || grade AS Sem_Grade
	FROM
	((SELECT emp_Lname, emp_Fname, emp_ID,
				  crs_Title, crs_ID, COUNT(crs_ID) AS courseNum
		   FROM   employee JOIN training USING(emp_ID)
						   JOIN course USING(crs_ID)
		   GROUP BY emp_Lname,emp_Fname, emp_ID,crs_Title, crs_ID
		   HAVING COUNT(crs_ID)>1)
	JOIN
	training USING(emp_ID,crs_ID))) B
	USING(employee, crs_Title))
WHERE A.Sem_Grade < B.Sem_Grade;
--Q10
CLEAR COLUMNS
BREAK ON course
COLUMN sem_Cmpleted FORMAT A15
COLUMN section FORMAT A10
COLUMN employee_ONE FORMAT A30
COLUMN employee_TWO FORMAT A30
COLUMN course FORMAT A35
SELECT DISTINCT crs_ID || ' - ' || crs_Title AS course, sem_Cmpleted, section, A.employee AS employee_ONE, B.employee AS employee_TWO
 FROM   ((SELECT crs_ID, crs_Title, sem_Cmpleted, section, emp_ID || '-' || emp_Lname || ', ' || emp_Fname AS employee
		  FROM   employee JOIN training USING(emp_ID)
						  JOIN class USING(crs_ID, sem_Cmpleted, section)
						  JOIN course USING(crs_ID)) A
		 JOIN 
		 (SELECT crs_ID, crs_Title, sem_Cmpleted, section, emp_ID || '-' || emp_Lname || ', ' || emp_Fname AS employee
		  FROM   employee JOIN training USING(emp_ID)
						  JOIN class USING(crs_ID, sem_Cmpleted, section)
						  JOIN course USING(crs_ID)) B
		 USING(crs_ID, crs_Title, sem_Cmpleted, section))
WHERE  A.employee > B.employee
ORDER BY 1;

SPOOL OUT
