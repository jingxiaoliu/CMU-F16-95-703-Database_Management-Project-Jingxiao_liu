connect casteel/tiger
SET ECHO ON
START C:\DBM\SQL#3\CellTell_SQL2.txt
SPOOL C:\DBM\SQL#3\Assignment#3.txt
SET pagesize 50
SET linesize 150
--Q1.a
CLEAR COLUMNS
COLUMN Manuf_Name FORMAT A10
SELECT * 
FROM (SELECT Manuf_Name, COUNT(DISTINCT Contract.Contract_ID) AS ContractNum,
			 Rank() OVER (ORDER BY COUNT(DISTINCT Contract.Contract_ID) DESC) AS Rank
	  FROM   Manufacturer JOIN Product ON Manufacturer.Manuf_ID = Product.Manuf_ID
							JOIN CellPhone ON CellPhone.Phone_ID = Product.Product_ID
							JOIN Contract_CellPhone cc ON cc.Phone_ID = CellPhone.Phone_ID
							JOIN Contract ON Contract.Contract_ID = cc.Contract_ID
	  WHERE  Contract.End_Date IS NULL
	  GROUP BY Manufacturer.Manuf_ID, Manuf_Name)
WHERE rank <= 5;
--Q1.b
CLEAR COLUMNS
COLUMN 'Manufacturers' FORMAT A20
SELECT DECODE(Category, Null, 'Manufacturer total', Category) "Manufacturers",
       SUM(DECODE(LOWER(Manuf_Name),'samsung',1,0)) "Samsung",
	   SUM(DECODE(LOWER(Manuf_Name),'apple',1,0)) "Apple",
	   SUM(DECODE(LOWER(Manuf_Name),'htc',1,0)) "HTC",
	   SUM(DECODE(LOWER(Manuf_Name),'motorola',1,0)) "Motorola",
	   SUM(DECODE(LOWER(Manuf_Name),'nokia',1,0)) "Nokia",
	   COUNT(Access_ID) AS "Category total"
FROM   Accessory JOIN Product ON Access_ID = Product_ID
                 JOIN Manufacturer ON Product.Manuf_ID = Manufacturer.Manuf_ID
GROUP BY GROUPING SETS (category, ())
ORDER BY category;   
--Q2
CLEAR COLUMNS
COLUMN Phone FORMAT A30
SELECT Phone, Num_of_Phone, Num_of_Contract, Average_Price
FROM   (SELECT Manuf_Name || ' - ' || Model AS Phone, Num_of_Phone, Num_of_Contract,
               RANK() OVER (PARTITION BY Manuf_Name ORDER BY (Num_of_Contract) DESC) AS RANK, Average_Price
		FROM   (SELECT Manuf_Name, Model, COUNT(CellPhone.Phone_ID) AS Num_of_Phone,
		               COUNT(DISTINCT Contract_ID) AS Num_of_Contract, TO_CHAR(AVG(PaidPrice), '$999.99') AS Average_Price
		        FROM   Contract_CellPhone cc JOIN CellPhone ON cc.Phone_ID = CellPhone.Phone_ID
							                 JOIN Product ON CellPhone.Phone_ID = Product.Product_ID
							                 JOIN Manufacturer ON Manufacturer.Manuf_ID = Product.Manuf_ID
											 GROUP BY Manuf_Name, Model))
WHERE Rank = 1
ORDER BY 1;
--Q3
CLEAR COLUMNS
SELECT vPlan_ID AS Plan_ID, SelectedNum, Type
FROM   (SELECT * 
	    FROM (SELECT vPlan_ID, COUNT(vPlan_ID) AS SelectedNum, Plan_Type AS Type, Rank() OVER (ORDER BY COUNT(vPlan_ID) DESC) AS RANK
			  FROM   Contract JOIN Plan ON　vPlan_ID = Plan_ID
			  GROUP BY vPlan_ID, Plan_Type)
		WHERE Rank = 1)
UNION
SELECT tPlan_ID AS Plan_ID, SelectedNum, Type
FROM   (SELECT * 
	    FROM (SELECT tPlan_ID, COUNT(tPlan_ID) AS SelectedNum, Plan_Type AS Type, Rank() OVER (ORDER BY COUNT(tPlan_ID) DESC) AS RANK
			  FROM   Contract JOIN Plan ON　tPlan_ID = Plan_ID
			  GROUP BY tPlan_ID, Plan_Type)
		WHERE Rank = 1)
UNION
SELECT dPlan_ID AS Plan_ID, SelectedNum, Type
FROM   (SELECT * 
	    FROM (SELECT dPlan_ID, COUNT(dPlan_ID) AS SelectedNum, Plan_Type AS Type, Rank() OVER (ORDER BY COUNT(dPlan_ID) DESC) AS RANK
			  FROM   Contract JOIN Plan ON　dPlan_ID = Plan_ID
			  GROUP BY dPlan_ID, Plan_Type)
		WHERE Rank = 1);
--Q4
CLEAR COLUMNS
SELECT Category, COUNT(ID) AS CustomerNum,
	   TO_CHAR(100 * COUNT(ID)/(SELECT COUNT(ID) FROM Customer), '990.99') || '%' AS "Percent"
FROM   (SELECT (CASE
	            WHEN CreditScore >= 300 AND CreditScore <= 499 THEN 'Poor Credit'
		        WHEN CreditScore >= 500 AND CreditScore <= 699 THEN 'Acceptable Credit'
		        WHEN CreditScore >= 700 AND CreditScore <= 850 THEN 'Good/Excellent Credit'
		        ELSE NULL END) AS Category, ID
		FROM    Customer)
        RIGHT OUTER JOIN 
		(SELECT 'Poor Credit' AS Category FROM customer
         UNION 
	     SELECT 'Acceptable Credit' AS Category FROM customer
	     UNION
	     SELECT 'Good/Excellent Credit' AS Category FROM customer) USING(Category)
GROUP BY Category;
--Q5
CLEAR COLUMNS 
COLUMN Customer FORMAT A30
COLUMN Period FORMAT A25
COLUMN Model FORMAT A15
SELECT ID || ' - ' || Lname || ', ' || Fname AS "Customer", start_date||' - '||end_date as Period,
       (CASE 
	    WHEN End_Date IS NULL THEN 'Active'
		ELSE 'Inactive' END) AS "Status", Model
FROM   Customer JOIN Contract ON ID = Customer_ID
                JOIN Contract_CellPhone cc ON cc.Contract_ID = Contract.Contract_ID
				JOIN CellPhone ON CellPhone.Phone_ID = cc.Phone_ID
WHERE  REGEXP_LIKE(LOWER(Model), 'iphone')
ORDER BY 3,1;
--Q6
CLEAR COLUMNS
COLUMN Model FORMAT A20
COLUMN Total_Profit FORMAT A15
COLUMN Average_Profit FORMAT A15
SELECT Model,
       TO_CHAR((CASE 
	            WHEN COUNT(DISTINCT Contract.Contract_ID) = 0
		        THEN 0
		        ELSE SUM(PaidPrice-CostPaid) END),'$9999.99') AS Total_Profit,
	   TO_CHAR((CASE 
	            WHEN COUNT(DISTINCT Contract.Contract_ID) = 0
		        THEN 0
		        ELSE AVG(PaidPrice-CostPaid) END),'$9999.99') AS Average_Profit,
	   COUNT(DISTINCT Contract.Contract_ID) AS "# of Contract"
FROM   Contract JOIN Contract_CellPhone cc ON cc.Contract_ID = Contract.Contract_ID
                RIGHT OUTER JOIN CellPhone ON CellPhone.Phone_ID = cc.Phone_ID
				JOIN Product ON Product.Product_ID = CellPhone.Phone_ID
GROUP BY Model
ORDER BY Total_Profit DESC;
--Q7
CLEAR COLUMNS
COLUMN State FORMAT A5
COLUMN Percent_Points FORMAT A15
SELECT State AS "State", 
       COUNT(DISTINCT CASE
	         WHEN Plan.end_date IS NULL
			  AND Data.dPlan_ID IS NOT NULL
			 THEN ID
			 ELSE NULL END) AS "Customers with data",
       COUNT(DISTINCT ID) AS "Total # of customers",
	   TO_CHAR(100 * COUNT(DISTINCT CASE
						   WHEN Plan.end_date IS NULL
			               AND Data.dPlan_ID IS NOT NULL
			               THEN ID ELSE NULL END)/COUNT(DISTINCT ID), '9990.99') || '%' AS Percent_Points
FROM   Customer JOIN Contract ON ID = Customer_ID
                LEFT OUTER JOIN Data ON Contract.dPlan_ID = Data.dPlan_ID
				JOIN Plan ON Plan.Plan_ID = Data.dPlan_ID
WHERE  Contract.End_date IS NULL
GROUP BY State
ORDER BY 4 DESC;
--Q8
CLEAR COLUMNS 
COLUMN "Manufacture" FORMAT A30
SELECT Manuf_ID || ' - ' || Manuf_Name AS "Manufacture"
FROM   Manufacturer
WHERE  REGEXP_LIKE(LOWER(Manuf_Name),'([aeiou]{1})([a-z]{1})\1');
--Bonus
CLEAR COLUMNS
COLUMN Plan FORMAT A35
SELECT *
FROM(SELECT Plan_ID || ', ' || start_date || ' - ' || end_date AS Plan, 
            TO_CHAR(SUM(NVL((BasePrice*(1-DiscountPerc/100))*Period,0)),'$99990.99') AS "Revenue"
     FROM   (SELECT Plan_ID, Plan.start_date, Plan.end_date, baseprice, discountperc,
                    CEIL(MONTHS_BETWEEN(NVL(contract.end_date, SYSDATE), contract.start_date)) AS Period
		     FROM Contract RIGHT OUTER JOIN Plan ON Plan.Plan_ID = Contract.vPlan_ID
				           OR Plan.Plan_ID = Contract.tPlan_ID
				           OR Plan.Plan_ID = Contract.dPlan_ID)
     GROUP BY Plan_ID, start_date, end_date
     ORDER BY "Revenue" DESC)
UNION ALL
SELECT 'Total' AS Plan, TO_CHAR(SUM(Revenue), '$99990.99') AS "Revenue"
FROM(SELECT Plan_ID || ', ' || start_date || ' - ' || end_date AS Plan, 
            SUM(NVL((BasePrice*(1-DiscountPerc/100))*Period,0)) AS Revenue
     FROM   (SELECT Plan_ID, Plan.start_date, Plan.end_date, baseprice, discountperc,
                    CEIL(MONTHS_BETWEEN(NVL(contract.end_date, SYSDATE), contract.start_date)) AS Period
		     FROM Contract RIGHT OUTER JOIN Plan ON Plan.Plan_ID = Contract.vPlan_ID
				           OR Plan.Plan_ID = Contract.tPlan_ID
				           OR Plan.Plan_ID = Contract.dPlan_ID)
     GROUP BY Plan_ID, start_date, end_date);
SPOOL OUT
