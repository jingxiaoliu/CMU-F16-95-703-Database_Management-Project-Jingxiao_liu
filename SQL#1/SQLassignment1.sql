connect casteel/tiger
SET ECHO ON
START C:\DBM\SQL#1\CellTell_SQL1.txt
SPOOL C:\DBM\SQL#1\Assignment#1.txt
SET pagesize 50
SET linesize 150
--Part1
--Q1.1
ALTER TABLE manufacturer ADD (website VARCHAR2(50));
UPDATE manufacturer SET website = 'http://www.apple.com' WHERE manuf_id = '567000';
UPDATE manufacturer SET website = 'http://www.motorola.com/us' WHERE manuf_id = '567001';
UPDATE manufacturer SET website = 'http://www.htc.com/us' WHERE manuf_id = '567002';
UPDATE manufacturer SET website = 'http://www.samsung.com/us' WHERE manuf_id = '567003';
UPDATE manufacturer SET website = 'http://www.LG.com/us' WHERE manuf_id = '567004';
UPDATE manufacturer SET website = 'http://company.nokia.com' WHERE manuf_id = '567005';
UPDATE manufacturer SET website = 'http://us.blackberry.com/home.html' WHERE manuf_id = '567006';
UPDATE manufacturer SET website = 'http://www.otterbox.com' WHERE manuf_id = '567007';
UPDATE manufacturer SET website = 'https://www.pielframa.com/es/index.htm' WHERE manuf_id = '567008';
UPDATE manufacturer SET website = 'http://www.microsoft.com/en-us' WHERE manuf_id = '567009';
--Q1.2
INSERT INTO product VALUES ('89001','iPhone','567000','649','749','CellPhone');
INSERT INTO product VALUES ('89002','iPhone','567000','769','869','CellPhone');
INSERT INTO product VALUES ('89003','Galaxy','567003','645','695','CellPhone');
INSERT INTO cellphone VALUES ('89001','iPhone 7','4G','iOS 10.0');
INSERT INTO cellphone VALUES ('89002','iPhone 7 Plus','4G','iOS 10.0');
INSERT INTO cellphone VALUES ('89003', 'Galaxy S7','4G','Andriod');
INSERT INTO phone_access VALUES ('89003','87647');
INSERT INTO phone_access VALUES ('89003','87648');
INSERT INTO phone_access VALUES ('89002','87548');
INSERT INTO phone_access VALUES ('89002','11256');
INSERT INTO phone_access VALUES ('89001','87459');
INSERT INTO phone_access VALUES ('89001','11256');
--Part2
--Q2.1
CLEAR COLUMNS
COLUMN Customer FORMAT A30
COLUMN Model FORMAT A20
COLUMN Manuf_Name FORMAT A15
COLUMN PaidPrice FORMAT $9,999
SELECT DISTINCT ID || ' - ' || Lname || ', ' || Fname AS "Customer", Model, PaidPrice, manufacturer.Manuf_ID, Manuf_Name
FROM customer JOIN contract ON customer.ID = contract.Customer_ID
			  JOIN contract_cellphone cc ON cc.Contract_ID = contract.Contract_ID
			  JOIN cellphone ON cellphone.Phone_ID = cc.Phone_ID
			  JOIN product ON product.Product_ID = cellphone.Phone_ID
			  JOIN manufacturer ON manufacturer.Manuf_ID = product.Manuf_ID
WHERE PaidPrice > 300
  AND End_Date IS NULL
ORDER BY Manuf_ID, Model;
--Q2.2
CLEAR COLUMNS
COLUMN Customer FORMAT A30
COLUMN Start_date FORMAT A15
COLUMN End_date FORMAT A15
SELECT ID || ' - ' || Lname || ', ' || Fname
	   AS "Customer",
	   Start_Date, End_Date
FROM   customer JOIN contract ON customer.ID = contract.Customer_ID
WHERE  vPlan_ID IS NOT NULL
INTERSECT
SELECT ID || ' - ' || Lname || ', ' || Fname
	   AS "Customer",
	   Start_Date, End_Date
FROM   customer JOIN contract ON customer.ID = contract.Customer_ID
WHERE  tPlan_ID IS NOT NULL
INTERSECT
SELECT ID || ' - ' || Lname || ', ' || Fname
	   AS "Customer",
	   Start_Date, End_Date
FROM   customer JOIN contract ON customer.ID = contract.Customer_ID
WHERE  dPlan_ID IS NOT NULL;
--Q2.3
CLEAR COLUMNS
COLUMN Customer FORMAT A30
SELECT ID || ' - ' || Lname || ', ' || Fname AS "Customer"
FROM   customer JOIN contract ON customer.ID = contract.Customer_ID
				LEFT OUTER JOIN voice ON voice.vPlan_ID = contract.vPlan_ID
				LEFT OUTER JOIN text ON text.tPlan_ID = contract.tPlan_ID
				LEFT OUTER JOIN data ON data.dPlan_ID = contract.dPlan_ID
WHERE  contract.End_Date IS NULL
  AND  0.1 < ANY(voice.OverageFee, text.MmsOverage,text.TextOverage, data.OverageFee);
--Q2.4
CLEAR COLUMNS
COLUMN Customer FORMAT A30
COLUMN Model FORMAT A20
SELECT DISTINCT ID || ' - ' || Lname || ', ' || Fname AS "Customer", cellphone.Phone_ID, Model
FROM   customer JOIN contract ON customer.ID = contract.Customer_ID
				JOIN contract_cellphone cc ON cc.Contract_ID = contract.Contract_ID
				JOIN cellphone ON cellphone.Phone_ID = cc.Phone_ID
WHERE  dPlan_ID IS NOT NULL
  AND  NetworkTechnology = '3G';
--Q2.5
CLEAR COLUMNS
COLUMN Customer FORMAT A30
COLUMN Address FORMAT A50
SELECT ID || ' - ' || Lname || ', ' || Fname AS "Customer",
	   Street || ', ' || CITY || ', ' || State || ', ' || ZipCode AS "Address",
	   Phone
FROM   customer JOIN contract ON customer.ID = contract.Customer_ID
				JOIN contract_cellphone cc ON cc.Contract_ID = contract.Contract_ID
				JOIN cellphone ON cellphone.Phone_ID = cc.Phone_ID
WHERE  dPlan_ID IS NULL
  AND  NetworkTechnology <> 'NO';
--Q2.6
CLEAR COLUMNS
COLUMN NetworkTechnology FORMAT A20
COLUMN Model FORMAT A20
COLUMN Manuf_Name FORMAT A15
SELECT cellphone.Phone_ID, Model, NetworkTechnology, OS, Manuf_Name
FROM   customer JOIN contract ON customer.ID = contract.Customer_ID
				JOIN contract_cellphone cc ON cc.Contract_ID = contract.Contract_ID
				JOIN cellphone ON cellphone.Phone_ID = cc.Phone_ID
				JOIN product ON product.Product_ID = cellphone.Phone_ID
				JOIN manufacturer ON manufacturer.Manuf_ID = Product.Manuf_ID
WHERE  Fname = 'Peter'
  AND  Lname = 'Smith';
--Q2.7
CLEAR COLUMNS
COLUMN Customer FORMAT A30
COLUMN Address FORMAT A50
SELECT ID || ' - ' || Lname || ', ' || Fname AS "Customer",
	   Street || ', ' || CITY || ', ' || State || ', ' || ZipCode AS "Address"
FROM   customer JOIN contract ON contract.Customer_ID = customer.ID
				JOIN contract_cellphone cc ON cc.Contract_ID = contract.Contract_ID
				JOIN cellphone ON cellphone.Phone_ID = cc.Phone_ID
WHERE  dPlan_ID IS NULL
  AND  City = 'Erie'
  AND  State = 'PA'
  AND  NetworkTechnology = '4G';
--Q2.8
CLEAR COLUMNS
COLUMN Name FORMAT A20
COLUMN hasvoicemail FORMAT A15
COLUMN hasthreeway FORMAT A15
COLUMN Overagefee FORMAT $90.90
SELECT Lname || ', ' || Fname AS "Name", voice.vPlan_ID, NumMin, hasvoicemail, hasthreeway, Overagefee
FROM   customer JOIN contract ON contract.Customer_ID = customer.ID
				JOIN voice ON voice.vPlan_ID = contract.vPlan_ID
WHERE  City = 'New York City'
  AND  contract.end_date IS NULL;
--Q2.9
CLEAR COLUMNS
COLUMN Customer FORMAT A30
SELECT ID || ' - ' || Lname || ', ' || Fname AS "Customer", dataLimit AS PLanLimit, 'DATA' AS "Type"
FROM   customer JOIN contract ON contract.Customer_ID = customer.ID
				JOIN data ON data.dPlan_ID = contract.dPlan_ID
WHERE  contract.dPlan_ID IS NOT NULL
  AND  contract.start_date >= SYSDATE - 365
  AND  contract.end_date IS NULL
UNION
SELECT ID || ' - ' || Lname || ', ' || Fname AS "Customer", textLimit AS PlanLimit, 'TEXT' AS "Type"
FROM   customer JOIN contract ON contract.Customer_ID = customer.ID
				JOIN text ON text.tPlan_ID = contract.tPlan_ID
WHERE  contract.tPlan_ID IS NOT NULL
  AND  contract.start_date >= SYSDATE - 365
  AND  contract.end_date IS NULL;
SPOOL OUT
