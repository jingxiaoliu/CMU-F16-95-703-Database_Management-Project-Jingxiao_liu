connect casteel/tiger
SET ECHO ON
START C:\DBM\SQL#2\CellTell_SQL2.txt
SPOOL C:\DBM\SQL#2\Assignment#2.txt
SET pagesize 50
SET linesize 150
--Q1
CLEAR COLUMNS
COLUMN Manuf_Name FORMAT A15
COLUMN Name FORMAT A30
COLUMN "Original Price" FORMAT $990.00
COLUMN "Promotion Price" FORMAT $990.00
SELECT Manuf_Name, Product_ID, Name, BasePrice AS "Original Price",
	   CASE Manuf_Name
			WHEN 'Apple' THEN 0.90*BasePrice
			WHEN 'Samsung' THEN 0.90*BasePrice
			WHEN 'HTC' THEN 0.85*BasePrice
			WHEN'LG' THEN 0.85*BasePrice
			ELSE 0.80*BasePrice
	   END AS "Promotion Price"
FROM   Manufacturer JOIN Product ON Manufacturer.Manuf_ID = Product.Manuf_ID
WHERE  Type = 'Accessory'
ORDER BY Manuf_Name, "Promotion Price";
--Q2
CLEAR COLUMNS
COLUMN Phone FORMAT A25
COLUMN "Earliest Contract" FORMAT A18
COLUMN "Recent Contract" FORMAT A15
SELECT Cellphone.Phone_ID || ', ' || Model AS "Phone",
	   COUNT(Contract.Contract_ID) AS "# of Contract",
	   MIN(Start_Date) AS "Earliest Contract",
	   MAX(Start_Date) AS "Recent Contract"
FROM   Contract JOIN Contract_Cellphone ON Contract.Contract_ID = Contract_Cellphone.Contract_ID
				JOIN CellPhone ON CellPhone.Phone_ID = Contract_Cellphone.Phone_ID
GROUP BY CellPhone.Phone_ID, Model
HAVING   COUNT(Contract.Contract_ID) > 3;
--Q3
CLEAR COLUMNS
COLUMN Network FORMAT A10
SELECT Data.NetworkTechnology AS "Network",
	   SUM(DECODE(Manuf_Name,'Apple',1)) AS "Apple",
	   SUM(DECODE(Manuf_Name,'Samsung',1)) AS "Samsung"
FROM   Contract JOIN Data ON Data.dPlan_ID = Contract.dPlan_ID
				JOIN Contract_Cellphone cc ON cc.Contract_ID = Contract.Contract_ID
				JOIN CellPhone ON CellPhone.Phone_ID = cc.Phone_ID
				JOIN Product ON Product.Product_ID = CellPhone.Phone_ID
				JOIN Manufacturer ON Product.Manuf_ID = Manufacturer.Manuf_ID
WHERE  Contract.End_date IS NULL
GROUP BY Data.NetworkTechnology;
--Q4
CLEAR COLUMNS
COLUMN "CUSTOMER" FORMAT A30
SELECT Customer_ID || '-' || Lname || ', ' || Fname AS "CUSTOMER",
	   COUNT(Phone_ID) AS "# of Phones",
	   COUNT(DISTINCT Contract.Contract_ID) AS "# of Contract"
FROM   Customer JOIN Contract ON Contract.Customer_ID = Customer.ID
				JOIN Contract_Cellphone cc ON cc.Contract_ID = Contract.Contract_ID
GROUP BY Customer_ID || '-' || Lname || ', ' || Fname
ORDER BY 2 DESC, 3 DESC;
--Q5
CLEAR COLUMNS
COLUMN Plan_Type FORMAT A10
SELECT Plan.Plan_ID, Plan.Plan_Type
FROM   Plan
MINUS
SELECT DISTINCT Plan.Plan_ID, Plan.Plan_Type
FROM   Customer JOIN Contract ON Contract.Customer_ID = Customer.ID
				JOIN Plan ON Plan.Plan_ID = Contract.vPlan_ID
				OR Plan.Plan_ID = Contract.tPlan_ID
				OR Plan.Plan_ID = Contract.dPlan_ID;
--Q6
CLEAR COLUMNS
COLUMN Manuf_Name FORMAT A15
COLUMN Model FORMAT A25
SELECT Manuf_Name, Model,
	   COUNT(DISTINCT Contract.Contract_ID) AS "# of Contracts",
	   COUNT(DISTINCT Customer_ID) AS "# of Customers",
	   COUNT(DISTINCT CASE
			 WHEN end_date IS NULL
			 THEN Customer_ID 
			 ELSE NULL END) AS "Current Customer"
FROM   Contract JOIN Contract_Cellphone cc ON cc.Contract_ID = Contract.Contract_ID
				JOIN CellPhone ON CellPhone.Phone_ID = cc.Phone_ID
				JOIN Product ON Product.Product_ID = CellPhone.Phone_ID
				JOIN Manufacturer ON Manufacturer.Manuf_ID = Product.Manuf_ID
GROUP BY Manuf_Name, Model
ORDER BY "# of Contracts" DESC;
--Q7
CLEAR COLUMNS
COLUMN Model FORMAT A20
SELECT Model, COUNT(CASE 
					WHEN Contract.Start_Date >= ADD_MONTHS(SYSDATE,-15)
					THEN CellPhone.Phone_ID
					ELSE NULL
					END) AS "# of Units"
FROM   Contract JOIN Contract_Cellphone cc ON cc.Contract_ID = Contract.Contract_ID
				JOIN CellPhone ON cc.Phone_ID = CellPhone.Phone_ID
GROUP BY Model
ORDER BY 2 DESC;
--Q8
CLEAR COLUMNS
COLUMN Name FORMAT A20
COLUMN Address FORMAT A50
SELECT Lname || ', ' ||Fname AS "Name",
	   Street || ', ' || CITY || ', ' || State || ', ' || ZipCode AS "Address",
	   NumMin AS VoiceLimit, TextLimit, DataLimit
FROM   Customer JOIN Contract ON Contract.Customer_ID = Customer.ID
				JOIN Voice ON Voice.vPlan_ID = Contract.vPlan_ID
				JOIN Text ON Text.tPlan_ID = Contract.tPlan_ID
				JOIN Data ON Data.dPlan_ID = Contract.dPlan_ID
WHERE  Contract.End_Date IS NULL
  AND  (NumMin > (SELECT AVG(NumMin) FROM Voice)
		OR TextLimit > (SELECT AVG(TextLimit) FROM Text)
		OR DataLimit > (SELECT AVG(DataLimit) FROM Data));
--Q9
CLEAR COLUMNS
COLUMN "CUSTOMER" FORMAT A30
COLUMN City FORMAT A15
COLUMN state FORMAT A5
SELECT ID || ' - ' || Lname || ', ' || Fname AS "Customer",
	   City, state,Contract.Contract_ID
FROM   Customer JOIN Contract ON Contract.Customer_ID = Customer.ID
				JOIN Voice ON Voice.vPlan_ID = Contract.vPlan_ID
				JOIN Plan ON Plan.Plan_ID = Voice.vPlan_ID
WHERE  Contract.End_Date IS NULL
  AND  BasePrice*(1-DiscountPerc/100) > (SELECT AVG(BasePrice*(1-DiscountPerc/100)) 
					  FROM Customer JOIN Contract ON Contract.Customer_ID = Customer.ID
									JOIN Voice ON Voice.vPlan_ID = Contract.vPlan_ID
									JOIN Plan ON Plan.Plan_ID = Voice.vPlan_ID);
SPOOL OUT
