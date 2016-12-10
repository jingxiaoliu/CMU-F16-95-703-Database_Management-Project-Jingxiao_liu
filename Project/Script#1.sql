DROP TABLE employee           CASCADE CONSTRAINTS; 
DROP TABLE department         CASCADE CONSTRAINTS; 
DROP TABLE training           CASCADE CONSTRAINTS; 
DROP TABLE course             CASCADE CONSTRAINTS; 
DROP TABLE class              CASCADE CONSTRAINTS; 
DROP TABLE instructor         CASCADE CONSTRAINTS; 
DROP TABLE grade_score        CASCADE CONSTRAINTS;

CREATE TABLE department
(dept_ID    NUMBER(5),
 dept_Name  VARCHAR2(30) NOT NULL,
 dept_Mngr  NUMBER(5),
 CONSTRAINT department_ID_PK PRIMARY KEY (dept_ID)
);

CREATE TABLE employee
(emp_ID     NUMBER(5),
 emp_Lname  VARCHAR2(30),
 emp_Fname  VARCHAR2(30),
 email      VARCHAR2(30),
 DOB        DATE NOT NULL,
 hire_Date  DATE DEFAULT SYSDATE,
 street     VARCHAR2(30),
 city       VARCHAR2(30),
 state      VARCHAR2(2),
 zip_code   NUMBER(5),
 dept_ID    NUMBER(5),
 sup_ID     NUMBER(5),
 CONSTRAINT employee_ID_PK PRIMARY KEY (emp_ID),
 CONSTRAINT employee_deptID_FK FOREIGN KEY (dept_ID) REFERENCES department (dept_ID),
 CONSTRAINT employee_supID_FK FOREIGN KEY (sup_ID) REFERENCES employee (emp_ID),
 CONSTRAINT employee_dates_CK CHECK (DOB <= hire_Date),
 CONSTRAINT employee_email_CK CHECK (email LIKE '%@%.%'),
 CONSTRAINT employee_supID_CK CHECK (sup_ID <> emp_ID)
);

CREATE TABLE course
(crs_ID         NUMBER(5),
 crs_Title      VARCHAR2(50),
 crs_Type       VARCHAR2(30),
 college_Name   VARCHAR2(30),
 tuition        NUMBER(5),
 CONSTRAINT course_ID_PK PRIMARY KEY (crs_ID)
);

CREATE TABLE instructor
(instr_ID       NUMBER(5),
 instr_Lname    VARCHAR2(30) NOT NULL,
 instr_Fname    VARCHAR2(30) NOT NULL,
 instr_Phone    NUMBER(10),
 specialty      VARCHAR2(30),
 CONSTRAINT instructor_ID_PK PRIMARY KEY (instr_ID)
);

CREATE TABLE grade_score
(grade   VARCHAR2(2) NOT NULL,
 score   NUMBER(3,2) NOT NULL,
 CONSTRAINT gradeScore_grade_PK PRIMARY KEY (grade),
 CONSTRAINT gradeScore_grade_CK CHECK (grade IN ('A+','A','A-','B+','B','B-','C+','C','C-','R')),
 CONSTRAINT gradeScore_score_CK CHECK ((score <= 4.33) AND (score >= 0.00))
);

CREATE TABLE class
(crs_ID         NUMBER(5),
 section        VARCHAR2(2),
 sem_Cmpleted   VARCHAR2(30),
 instr_ID       NUMBER(5),
 CONSTRAINT class_ID_PK PRIMARY KEY (crs_ID,section,sem_Cmpleted),
 CONSTRAINT class_crsID_FK FOREIGN KEY (crs_ID) REFERENCES course (crs_ID),
 CONSTRAINT class_instrID_FK FOREIGN KEY (instr_ID) REFERENCES instructor (instr_ID)
);

CREATE TABLE training
(TID            NUMBER(5),
 emp_ID         NUMBER(5),
 appr_Date      DATE,
 crs_ID         NUMBER(5),
 section        VARCHAR2(2),
 sem_Cmpleted   VARCHAR2(30) NOT NULL,
 grade          VARCHAR2(2) NOT NULL,
 CONSTRAINT training_TID_PK PRIMARY KEY (TID),
 CONSTRAINT training_empID_FK FOREIGN KEY (emp_ID) REFERENCES employee (emp_ID),
 CONSTRAINT training_crsID_FK FOREIGN KEY (crs_ID,section,sem_Cmpleted) REFERENCES class (crs_ID,section,sem_Cmpleted),
 CONSTRAINT training_grade_FK FOREIGN KEY (grade) REFERENCES grade_score (grade)
);

ALTER TABLE department
ADD CONSTRAINT department_deptMngr_FK FOREIGN KEY (dept_Mngr) REFERENCES employee (emp_ID);

COMMIT;