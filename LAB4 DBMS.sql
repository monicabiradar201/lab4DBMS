-- 3)	Display the total number of customers based on gender who have placed orders of worth at least Rs.3000.
-- select C.CUS_GENDER,O.ORD_AMOUNT FROM customer AS C INNER JOIN `order` AS O ON C.CUS_ID=O.CUS_ID AND O.ORD_AMOUNT> 3000;
 
-- 4)	Display all the orders along with product name ordered by a customer having Customer_Id=2

SELECT* FROM (SELECT product.PRO_NAME,product.PRO_ID,supplier_pricing.PRICING_ID FROM supplier_pricing INNER JOIN product ON supplier_pricing.PRO_ID= product.PRO_ID)AS Supp_Pro
INNER JOIN `order` AS O ON O.PRICING_ID=SUPP_PRO.PRICING_ID AND O.CUS_ID="2";

-- 5)Display the Supplier details who can supply more than one product.
SELECT S.SUPP_NAME,S.SUPP_ID,COUNT(S.SUPP_ID), SP.PRO_ID FROM supplier AS S INNER JOIN supplier_pricing AS SP ON S.SUPP_ID=SP.SUPP_ID GROUP BY S.SUPP_ID HAVING COUNT(S.SUPP_ID) > 1;

-- 6)	Find the least expensive product from each category and print the table with category id, name, product name and price of the product
SELECT C.CAT_NAME,sup_pro.minSP, sup_pro.PRO_ID,sup_pro.PRO_NAME,sup_pro.CAT_ID FROM (SELECT MIN(SP.SUPP_PRICE)AS minsp,P.PRO_ID,P.PRO.NAME,P.CAT_ID FROM supplier_pricing AS SP INNER JOIN product AS P ON SP.PRO_ID=P.PRO_ID GROUP BY P.CAT_ID) AS sup_pro
INNER JOIN category AS C ON C.CAT_ID= sup_pro.CAT_ID;
-- 7)	Display the Id and Name of the Product ordered after “2021-10-05”.
SELECT Supp_pro.PRO_ID, Supp_pro.PRO_NAME, O.ORD_DATE,O.ORD_ID FROM (SELECT product.PRO_NAME, product.PRO_ID,supplier_pricing.PRICING_ID FROM supplier_pricing INNER JOIN product ON supplier_pricing.PRO_ID=product.PRO_ID)AS Supp_pro
INNER JOIN `order` AS O ON O.PRICING_ID=Supp_pro.PRICING_ID AND O.ORD_DATE>"2021-10-05" ;

-- 8)Display customer name and gender whose names start or end with character 'A'.
 SELECT C.CUS_NAME, C.CUS_GENDER FROM customer AS C WHERE C.CUS_NAME LIKE 'A%';
 
 CALL Service_Rating ();
 
-- 9)Create a stored procedure to display supplier id, name, rating and Type_of_Service. For Type_of_Service, If rating =5, print “Excellent Service”,If rating >4 print “Good Service”, If rating >2 print “Average Service” else print “Poor Service”.
 SELECT SOP.SUPP_ID, R.RAT_RATSTARS,
 CASE
 WHEN R.RAT_RATSTARS=5 THEN'EXCELLENT Services'
 WHEN R.RAT_RATSTARS=4 THEN'GOOD Services'
 WHEN R.RAT_RATSTARS=2 THEN'AVERAGE Services'
 ELSE 'POOR SERVICES'
 END AS TYPE_of_services
 FROM(SELECT Supp_pro.Supp_id,O.ORD_ID FROM(SELECT supplier_pricing.PRICING_ID,supplier_pricing.SUPP_ID FROM supplier_pricing INNER JOIN product ON supplier_pricing.PRO_ID=product.PRO_ID)AS Supp_Pro
 INNER JOIN`order`AS O ON O.PRICING_ID =Supp_pro.PRICING_ID) AS SOP
INNER JOIN rating AS R ON R.ORD_ID=SOP.ORD_ID
