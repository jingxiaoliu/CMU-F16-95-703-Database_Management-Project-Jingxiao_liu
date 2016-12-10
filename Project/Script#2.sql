
-- department
INSERT INTO department VALUES (1001,'Marketing',null);
INSERT INTO department VALUES (1002,'Human Resources',null);
INSERT INTO department VALUES (1003,'Sales',null);
INSERT INTO department VALUES (1004,'Customer Service',null);
INSERT INTO department VALUES (1005,'Finance',null);
INSERT INTO department VALUES (1006,'Production',null);
INSERT INTO department VALUES (1007,'Research and Development',null);
INSERT INTO department VALUES (1008,'Manufacturing',null);
INSERT INTO department VALUES (1009,'Accounting',null);
INSERT INTO department VALUES (1010,'Consulting',null);
INSERT INTO department VALUES (1011,'Analytics',null);

-- employee
INSERT INTO employee VALUES (10001,'Liu','Jingxiao','jingxial@andrew.cmu.edu','19-FEB-1994','01-AUG-2011',
                             '230 N Craig','Pittsburgh','PA',15213,1001,null);
INSERT INTO employee VALUES (10002,'Agarwal','Ajay','aragarwa@andrew.cmu.edu','10-JAN-1994','02-AUG-2011',
                             '5710 Bartlett Street','Pittsburgh','PA',15217,1001,10001);
INSERT INTO employee VALUES (10003,'Ahn','Jungho','junghoa@andrew.cmu.edu','24-JUN-1994','01-AUG-2011',
                             '4750 Centre Avenue','Pittsburgh','PA',15213,1001,10001);
INSERT INTO employee VALUES (10004,'Aravind','Pritham','pvaravin@andrew.cmu.edu','09-APR-1994','02-AUG-2011',
                             '5738 Darlington','Pittsburgh','PA',15217 ,1002,null);
INSERT INTO employee VALUES (10005,'Bakert','Andrew','abakert@andrew.cmu.edu','21-DEC-1994','01-AUG-2012',
                             '240 Melwood Ave','Pittsburgh','PA',15213,1002,10004);
INSERT INTO employee VALUES (10006,'Arora','Rajat','rarora1@cmu.edu','06-APR-1993','02-AUG-2012',
                             '5738 Darlington','Pittsburgh','PA',15217 ,1003,null);
INSERT INTO employee VALUES (10007,'Chao','Shucheng','shuchenc@andrew.cmu.edu','21-NOV-1994','01-AUG-2012',
                             '230 N Craig','Pittsburgh','PA',15213,1003,10006);
INSERT INTO employee VALUES (10008,'Chen','Dihong','dihonc@andrew.cmu.edu','09-APR-1994','02-AUG-2012',
                             '5738 Darlington','Pittsburgh','PA',15217 ,1004,null);
INSERT INTO employee VALUES (10009,'Chen','Yiming','yimingc1@andrew.cmu.edu','21-SEP-1993','02-AUG-2012',
                             '5710 Bartlett Street','Pittsburgh','PA',15217,1004,10008);
INSERT INTO employee VALUES (10010,'Dennin','Luke','ldennin@andrew.cmu.edu','03-APR-1995','02-AUG-2012',
                             '5738 Darlington','Pittsburgh','PA',15217 ,1005,null);
INSERT INTO employee VALUES (10011,'Feng','Christopher','cf1@andrew.cmu.edu','27-FEB-1994','01-AUG-2012',
                             '4750 Centre Avenue','Pittsburgh','PA',15213,1005,10010);
INSERT INTO employee VALUES (10012,'Zhu','Di','zhudi@andrew.cmu.edu','19-MAR-1994','01-AUG-2012',
                             '230 N Craig','Pittsburgh','PA',15213,1006,null);
INSERT INTO employee VALUES (10013,'Zhou','Jiali','jializ@andrew.cmu.edu','10-JAN-1994','02-AUG-2012',
                             '5710 Bartlett Street','Pittsburgh','PA',15217,1006,10012);
INSERT INTO employee VALUES (10014,'Zhao','Yusheng','zhaoyu@andrew.cmu.edu','24-JUN-1994','01-AUG-2012',
                             '4750 Centre Avenue','Pittsburgh','PA',15213,1007,null);
INSERT INTO employee VALUES (10015,'Zhao','Yiren','Yiren@andrew.cmu.edu','09-APR-1994','02-AUG-2012',
                             '5738 Darlington','Pittsburgh','PA',15217 ,1007,10014);
INSERT INTO employee VALUES (10016,'Zhao','Xin','xinzh@andrew.cmu.edu','21-DEC-1994','01-AUG-2012',
                             '240 Melwood Ave','Pittsburgh','PA',15213,1008,null);
INSERT INTO employee VALUES (10017,'Alla','Sharan','sharan@cmu.edu','06-APR-1993','02-AUG-2012',
                             '5738 Darlington','Pittsburgh','PA',15217,1008,10016);
INSERT INTO employee VALUES (10018,'Bamforth','Gabriel','gabriel@andrew.cmu.edu','21-NOV-1994','01-AUG-2012',
                             '230 N Craig','Pittsburgh','PA',15213,1009,null);
INSERT INTO employee VALUES (10019,'Cheng','Perry','perryc@andrew.cmu.edu','09-APR-1994','02-AUG-2012',
                             '5738 Darlington','Pittsburgh','PA',15217 ,1009,10018);
INSERT INTO employee VALUES (10020,'Chirinos','Renato','renato@andrew.cmu.edu','21-SEP-1993','02-AUG-2011',
                             '5710 Bartlett Street','Pittsburgh','PA',15217,1010,null);
INSERT INTO employee VALUES (10021,'Chukwuma','Obianozo','obiano@andrew.cmu.edu','03-APR-1995','02-AUG-2015',
                             '5738 Darlington','Pittsburgh','PA',15217 ,1010,10020);
INSERT INTO employee VALUES (10022,'Clarke','Dylan','dylan@andrew.cmu.edu','27-FEB-1994','01-AUG-2015',
                             '4750 Centre Avenue','Pittsburgh','PA',15213,1011,null);
INSERT INTO employee VALUES (10023,'Cruz','Julissa','julis@andrew.cmu.edu','27-FEB-1994','01-AUG-2015',
                             '4750 Centre Avenue','Pittsburgh','PA',15213,1011,10022);

-- instructor
INSERT INTO instructor VALUES (9501,'Szczypula','Janusz',4122686096,'Database');
INSERT INTO instructor VALUES (9502,'Esmall','Zadeh',1881109911,'Management');
INSERT INTO instructor VALUES (9503,'Dwivedi','Neelam',4122687246,'Java');
INSERT INTO instructor VALUES (9504,'Pastor','Lynne',4122686725,'Finance');
INSERT INTO instructor VALUES (9505,'Alessandro','Acquisti',4122686101,'Economics');
INSERT INTO instructor VALUES (9506,'Crane','John',4122686065,'Management');
INSERT INTO instructor VALUES (9507,'Pastor','Lynn',1881109943,'Finance');
INSERT INTO instructor VALUES (9508,'Labash','Chris',4122687256,'Management');
INSERT INTO instructor VALUES (9509,'Rosenberg','Haley',4122686723,'Management');
INSERT INTO instructor VALUES (9510,'Baron','Raymond',4122686176,'Management');
INSERT INTO instructor VALUES (9511,'Szczypula','Janusz',4122686096,'Database');

-- grade_score
INSERT INTO grade_score VALUES ('A+',4.33);
INSERT INTO grade_score VALUES ('A',4.00);
INSERT INTO grade_score VALUES ('A-',3.67);
INSERT INTO grade_score VALUES ('B+',3.33);
INSERT INTO grade_score VALUES ('B',3.00);
INSERT INTO grade_score VALUES ('B-',2.67);
INSERT INTO grade_score VALUES ('C+',2.33);
INSERT INTO grade_score VALUES ('C',2.00);
INSERT INTO grade_score VALUES ('C-',1.67);
INSERT INTO grade_score VALUES ('R',0.00);

--course
INSERT INTO course VALUES (95703,'Database Mngt','DBM','Heinz',1800);
INSERT INTO course VALUES (95705,'Telecommunications Management','EXTC','Heinz',0);
INSERT INTO course VALUES (95706,'Object Oriented Analysis and Design','CS','Heinz',0);
INSERT INTO course VALUES (95716,'Principles of Finance','Finance','Heinz',900);
INSERT INTO course VALUES (95710,'Economic Analysis','Finance','Heinz',null);
INSERT INTO course VALUES (95701,'Marketing Digital Media','Finance','Heinz',1800);
INSERT INTO course VALUES (95702,'Financial Accounting','Finance','Heinz',2700);
INSERT INTO course VALUES (95704,'Professional Speaking','English','Heinz',1800);
INSERT INTO course VALUES (95707,'Professional Writing','English','Heinz',2700);
INSERT INTO course VALUES (95708,'Managing Disruptive Technologies','CS','Heinz',null);
INSERT INTO course VALUES (95722,'Data Structures','CS','School of Computer Science',2700);
INSERT INTO course VALUES (95723,'Machine Learning','CS','School of Computer Science',900);

-- class
INSERT INTO class VALUES (95706,'A1','Spring 2013',9503);
INSERT INTO class VALUES (95716,'A2','Spring 2013',9504);
INSERT INTO class VALUES (95710,'A2','Spring 2013',9505);
INSERT INTO class VALUES (95701,'A1','Fall 2013',9506);
INSERT INTO class VALUES (95702,'A1','Fall 2013',9507);
INSERT INTO class VALUES (95708,'A2','Fall 2013',9510);
INSERT INTO class VALUES (95722,'A2','Fall 2013',9501);
INSERT INTO class VALUES (95723,'A2','Fall 2013',9502);
INSERT INTO class VALUES (95703,'A1','Spring 2014',9501);
INSERT INTO class VALUES (95716,'A2','Spring 2014',9504);
INSERT INTO class VALUES (95710,'A2','Spring 2014',9505);
INSERT INTO class VALUES (95701,'A1','Fall 2014',9506);
INSERT INTO class VALUES (95702,'A1','Fall 2014',9507);
INSERT INTO class VALUES (95704,'A1','Fall 2014',9508);
INSERT INTO class VALUES (95722,'A2','Fall 2014',9501);
INSERT INTO class VALUES (95723,'A2','Fall 2014',9502);
INSERT INTO class VALUES (95705,'A1','Spring 2014',9502);
INSERT INTO class VALUES (95703,'A1','Spring 2015',9501);
INSERT INTO class VALUES (95705,'A1','Spring 2015',9502);
INSERT INTO class VALUES (95710,'A2','Spring 2015',9505);
INSERT INTO class VALUES (95701,'A1','Fall 2015',9506);
INSERT INTO class VALUES (95702,'A1','Fall 2015',9507);
INSERT INTO class VALUES (95704,'A1','Fall 2015',9508);
INSERT INTO class VALUES (95707,'A2','Fall 2015',9509);
INSERT INTO class VALUES (95723,'A2','Fall 2015',9502);
INSERT INTO class VALUES (95716,'A2','Spring 2015',9504);
INSERT INTO class VALUES (95703,'A1','Spring 2016',9501);
INSERT INTO class VALUES (95705,'A1','Spring 2016',9502);
INSERT INTO class VALUES (95706,'A1','Spring 2016',9503);
INSERT INTO class VALUES (95701,'A1','Fall 2016',9506);
INSERT INTO class VALUES (95702,'A1','Fall 2016',9507);
INSERT INTO class VALUES (95704,'A1','Fall 2016',9508);
INSERT INTO class VALUES (95707,'A2','Fall 2016',9509);
INSERT INTO class VALUES (95708,'A2','Fall 2016',9510);

--training
INSERT INTO training VALUES (001,10018,'29-NOV-2012',95710,'A2','Spring 2013','A');
INSERT INTO training VALUES (002,10019,'29-NOV-2012',95710,'A2','Spring 2013','B');
INSERT INTO training VALUES (003,10014,'29-MAR-2013',95701,'A1','Fall 2013','B-');
INSERT INTO training VALUES (004,10014,'29-MAR-2013',95702,'A1','Fall 2013','B');
INSERT INTO training VALUES (005,10001,'29-MAR-2013',95701,'A1','Fall 2013','A');
INSERT INTO training VALUES (006,10001,'29-MAR-2013',95702,'A1','Fall 2013','B');
INSERT INTO training VALUES (007,10012,'29-MAR-2013',95723,'A2','Fall 2013','R');
INSERT INTO training VALUES (008,10013,'29-MAR-2013',95723,'A2','Fall 2013','B');
INSERT INTO training VALUES (009,10012,'29-MAR-2014',95723,'A2','Fall 2014','A');
INSERT INTO training VALUES (010,10001,'29-NOV-2013',95703,'A1','Spring 2014','C-');
INSERT INTO training VALUES (011,10003,'29-NOV-2013',95716,'A2','Spring 2014','B+');
INSERT INTO training VALUES (012,10004,'29-NOV-2013',95710,'A2','Spring 2014','A');
INSERT INTO training VALUES (013,10005,'29-NOV-2013',95710,'A2','Spring 2014','B');
INSERT INTO training VALUES (014,10006,'29-NOV-2013',95716,'A2','Spring 2014','R');
INSERT INTO training VALUES (015,10001,'29-MAR-2014',95701,'A1','Fall 2014','A');
INSERT INTO training VALUES (016,10002,'29-MAR-2014',95702,'A1','Fall 2014','B');
INSERT INTO training VALUES (017,10003,'29-MAR-2014',95704,'A1','Fall 2014','R');
INSERT INTO training VALUES (018,10004,'29-MAR-2014',95701,'A1','Fall 2014','A');
INSERT INTO training VALUES (019,10005,'29-MAR-2014',95702,'A1','Fall 2014','B');
INSERT INTO training VALUES (020,10009,'29-MAR-2014',95723,'A2','Fall 2014','C');
INSERT INTO training VALUES (021,10010,'29-MAR-2014',95723,'A2','Fall 2014','B');
INSERT INTO training VALUES (022,10006,'29-NOV-2014',95716,'A2','Spring 2015','C');
INSERT INTO training VALUES (023,10003,'29-MAR-2015',95704,'A1','Fall 2015','B+');
INSERT INTO training VALUES (024,10011,'29-NOV-2014',95703,'A1','Spring 2015','R');
INSERT INTO training VALUES (025,10012,'29-NOV-2014',95705,'A1','Spring 2015','A-');
INSERT INTO training VALUES (026,10015,'29-NOV-2014',95710,'A2','Spring 2015','B');
INSERT INTO training VALUES (027,10019,'29-NOV-2014',95710,'A2','Spring 2015','C-');
INSERT INTO training VALUES (028,10011,'29-MAR-2015',95701,'A1','Fall 2015','C-');
INSERT INTO training VALUES (029,10012,'29-MAR-2015',95702,'A1','Fall 2015','B');
INSERT INTO training VALUES (030,10014,'29-MAR-2015',95701,'A1','Fall 2015','A');
INSERT INTO training VALUES (031,10015,'29-MAR-2015',95702,'A1','Fall 2015','R');
INSERT INTO training VALUES (032,10017,'29-MAR-2015',95707,'A2','Fall 2015','R');
INSERT INTO training VALUES (033,10015,'29-MAR-2016',95702,'A1','Fall 2016','B');
INSERT INTO training VALUES (034,10017,'29-MAR-2016',95707,'A2','Fall 2016','B');
INSERT INTO training VALUES (035,10011,'29-NOV-2015',95703,'A1','Spring 2016','B');
INSERT INTO training VALUES (036,10001,'29-NOV-2015',95703,'A1','Spring 2016','A');
INSERT INTO training VALUES (037,10006,'29-NOV-2015',95703,'A1','Spring 2016','A');
INSERT INTO training VALUES (038,10002,'29-NOV-2015',95705,'A1','Spring 2016','A-');
INSERT INTO training VALUES (039,10006,'29-MAR-2016',95701,'A1','Fall 2016','R');
INSERT INTO training VALUES (040,10022,'29-MAR-2016',95702,'A1','Fall 2016','B');
INSERT INTO training VALUES (041,10023,'29-MAR-2016',95704,'A1','Fall 2016','B+');
INSERT INTO training VALUES (042,10009,'29-MAR-2016',95701,'A1','Fall 2016','A');
INSERT INTO training VALUES (043,10009,'29-MAR-2016',95702,'A1','Fall 2016','R');

--ADD DEPT_MNGR
-- department_deptMngr
UPDATE department SET dept_Mngr = 10001 WHERE dept_ID = 1001;
UPDATE department SET dept_Mngr = 10004 WHERE dept_ID = 1002;
UPDATE department SET dept_Mngr = 10006 WHERE dept_ID = 1003;
UPDATE department SET dept_Mngr = 10008 WHERE dept_ID = 1004;
UPDATE department SET dept_Mngr = 10010 WHERE dept_ID = 1005;
UPDATE department SET dept_Mngr = 10012 WHERE dept_ID = 1006;
UPDATE department SET dept_Mngr = 10014 WHERE dept_ID = 1007;
UPDATE department SET dept_Mngr = 10016 WHERE dept_ID = 1008;
UPDATE department SET dept_Mngr = 10018 WHERE dept_ID = 1009;
UPDATE department SET dept_Mngr = 10020 WHERE dept_ID = 1010;
UPDATE department SET dept_Mngr = 10022 WHERE dept_ID = 1011;

COMMIT;