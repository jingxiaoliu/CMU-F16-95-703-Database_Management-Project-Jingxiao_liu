DROP VIEW employeeTrainingSummary;
CREATE VIEW employeeTrainingSummary
AS
SELECT dept_Name AS department,
	   employee.emp_ID || ' - ' || employee.emp_Lname || ', ' || employee.emp_Fname AS employee,
	   (CASE 
		WHEN employee.sup_ID IS NULL 
		THEN NULL
		ELSE employee.sup_ID || ' - ' || sup.emp_Lname || ', ' || sup.emp_Fname
		END) AS supervisor,
	   (CASE
        WHEN crs_Title IS NULL
        THEN NULL
        ELSE crs_Title || ', ' || sem_Cmpleted || ', ' || grade 
		END) AS Training, score
FROM   department JOIN employee ON employee.dept_ID = department.dept_ID
				  LEFT OUTER JOIN employee sup ON employee.sup_ID = sup.emp_ID
				  LEFT OUTER　JOIN training ON employee.emp_ID = training.emp_ID
				  LEFT OUTER JOIN class USING(crs_ID,section,sem_Cmpleted)
				  LEFT OUTER JOIN course USING(crs_ID)
				  LEFT OUTER JOIN grade_Score USING(grade)
ORDER BY 1,2,3,4;

REM "Employee Training Information Report" created on November 29 2016
REM by user CASTEEL
SET FEEDBACK OFF LINESIZE 150 PAGESIZE 45

REM set up the appropriate parameters to increase readability
CLEAR COLUMNS
COLUMN employee      HEADING 'Employee|Number/Name'                     FORMAT A30
COLUMN supervisor    HEADING 'Supervisor|Number/Name'                   FORMAT A30 NULL 'Supervisor'
COLUMN department    HEADING 'Department|Number/Name'                   FORMAT A25
COLUMN training      HEADING 'Training|Title/Semester/Grade'            FORMAT A50 NULL 'No training'
COLUMN Score         HEADING 'GPA'                                      FORMAT 0.99
TTITLE 'Employee Trainings'
BTITLE CENTER 'END of Employee Training Information Report' RIGHT 'Run By: Team#1'

BREAK ON department SKIP 1 ON employee SKIP 1 ON supervisor
COMPUTE COUNT LABEL 'Number of Classes (Emp)' OF training ON employee
COMPUTE AVG   LABEL 'Employee GPA' OF score ON employee
COMPUTE COUNT LABEL 'Number of Classes (Dept)' OF training ON department
COMPUTE AVG   LABEL 'Department GPA' OF score ON department

SPOOL C:\DBM\Project\Report_OUTPUT.TXT
SELECT department, employee, supervisor, training, score
FROM employeeTrainingSummary;
SPOOL OFF

CLEAR BREAK COLUMN COMPUTE
TTITLE OFF
BTITLE OFF
SET FEEDBACK ON LINESIZE 100 PAGESIZE 80
