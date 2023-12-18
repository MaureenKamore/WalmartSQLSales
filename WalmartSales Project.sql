
SELECT *
FROM WalmartSalesData

--Creating time of day and adding time of day into the table
SELECT Time_Of_Purchase,
  (CASE
	 WHEN DATEPART(HOUR, Time_Of_Purchase) BETWEEN 0 AND 11 THEN 'Morning'
	 WHEN DATEPART(HOUR, Time_Of_Purchase) BETWEEN 12 AND 16 THEN 'Afternoon'
	 ELSE 'Evening'
       END) AS Time_of_day
FROM WalmartSalesData

ALTER TABLE WalmartSalesData
ADD Time_of_day VARCHAR (20)

UPDATE WalmartSalesData
SET Time_of_day = (
  CASE
     WHEN DATEPART(HOUR, Time_Of_Purchase) BETWEEN 0 AND 11 THEN 'Morning'
	 WHEN DATEPART(HOUR, Time_Of_Purchase) BETWEEN 12 AND 16 THEN 'Afternoon'
	 ELSE 'Evening'
       END)

--Creating day of the week and adding day of the week into the table
SELECT Date_Of_Purchase,
DATENAME(dw, Date_Of_Purchase) AS Day_Of_The_Week
FROM WalmartSalesData

ALTER TABLE WalmartSalesData
ADD Day_Of_The_Week VARCHAR (10)

UPDATE WalmartSalesData
SET Day_Of_The_Week = DATENAME(dw, Date_Of_Purchase)

--Creating Month Name and adding month name into the table
SELECT Date_of_Purchase,
DATENAME (Month, Date_Of_Purchase) AS Month_Name
FROM WalmartSalesData

ALTER TABLE WalmartSalesData
ADD Month_Name VARCHAR (10)

UPDATE WalmartSalesData
SET Month_Name = DATENAME(month, Date_Of_Purchase)

--Find how many Unique Cities
SELECT DISTINCT City
FROM WalmartSalesData

--Which City is Each Branch
SELECT DISTINCT Branch
FROM WalmartSalesData

SELECT DISTINCT City, Branch
FROM WalmartSalesData

--Unique Product lines: How many Unique Product_line do we have?
SELECT COUNT(DISTINCT Product_line)
FROM WalmartSalesData

--Common Payment Method: What is The Most preffered Payment Method among Customers?
SELECT Payment, COUNT(Payment) AS Payment_Method_Count
FROM WalmartSalesData
GROUP BY Payment
ORDER BY Payment_Method_Count DESC

--Best Selling Product Line: What Product line is flying off the shelves?
SELECT Product_line, COUNT(Product_line) AS Product_line_Count
FROM WalmartSalesData
GROUP BY Product_line
ORDER BY Product_line_Count DESC

--Total Monthly Revenue: How much money did we make each month?
SELECT Month_Name, SUM(Total_Cost) AS Total_Revenue
FROM WalmartSalesData
GROUP BY Month_Name
ORDER BY Total_Revenue DESC

--Largest COGS (Cost of Goods Sold) : In which month did we spend most on the COGS?
SELECT Month_Name, SUM(Cost_Of_Goods) AS COGS
FROM WalmartSalesData
GROUP BY Month_Name
ORDER BY COGS DESC

--On which time of the day do we receive the most sales?
SELECT Time_of_day, ROUND(SUM(Total_Cost),2) AS Sales_by_Time
FROM WalmartSalesData
GROUP BY Time_of_day
ORDER BY Sales_by_Time DESC

--On which day of the week do we receive the most sales?
SELECT Day_Of_The_Week, ROUND(SUM(Total_Cost),2) AS Sales_Per_day
FROM WalmartSalesData
GROUP BY Day_Of_The_Week
ORDER BY Sales_Per_day DESC

--Top Revenue Product Line: Among all product line, which one brought in the most revenue?
SELECT Product_line, SUM(Total_Cost) AS Total_Revenue
FROM WalmartSalesData
GROUP BY Product_line
ORDER BY Total_Revenue DESC

--City with the largest Revenue: Where did we shine the brightest in terms of revenue?
SELECT Branch, City, SUM(Total_Cost) AS Total_Revenue
FROM WalmartSalesData
GROUP BY Branch, City
ORDER BY Total_Revenue DESC

--Largest 5% VAT by Product Line: Which product line boasts the highest VAT?(Rounded to 2 decimal places)
SELECT Product_line, ROUND(AVG(Tax_5_On_Purchase),2) AS AVG_Tax
FROM WalmartSalesData
GROUP BY Product_line
ORDER BY AVG_Tax DESC

--Branch exceeding average sales: Identify the branch that outperformed the average number of products sold?
SELECT Branch,SUM(Quantity) AS Total_Quantity
FROM WalmartSalesData
GROUP BY Branch
HAVING SUM(Quantity) > (SELECT AVG(Quantity) AS AVG_Quantity FROM WalmartSalesData)

--Most common Product line by gender: Pinpoint the product line that steals the spotlight for each gender?
SELECT DISTINCT(Gender), Product_line, COUNT(Product_line) AS Product_line_count
FROM WalmartSalesData
GROUP BY Gender, Product_line
ORDER BY Product_line_count DESC

--Average Rating by Product_line: Discover the average rating for each product line
SELECT Product_line, ROUND(AVG(Rating),2) AS AVG_Rating
FROM WalmartSalesData
GROUP BY Product_line
ORDER BY AVG_Rating DESC

--Sales by Time of Day: Breakdown of the number of sales made each time of the day across the week
SELECT Time_of_day, COUNT(Invoice_ID) AS Sales
FROM WalmartSalesData
GROUP BY Time_of_day
ORDER BY Sales DESC

--Sales by Day of the week: Which day of the week has highest number of sales
SELECT Day_Of_The_Week, COUNT(Invoice_ID) AS Sales
FROM WalmartSalesData
GROUP BY Day_Of_The_Week
ORDER BY Sales DESC

--Revenue by customer type: Which customer type contributes the most to the revenue?
SELECT Customer_type, ROUND(SUM(Total_Cost), 2) AS Revenue
FROM WalmartSalesData
GROUP BY Customer_type
ORDER BY Revenue DESC

--City with the highest VAT %: Identify the city where the VAT is at its peak
SELECT City, ROUND(AVG(Tax_5_On_Purchase), 2) AS VAT
FROM WalmartSalesData
GROUP BY City
ORDER BY VAT DESC

--Among customer types who contributes the VAT
SELECT Customer_type, ROUND(AVG(Tax_5_On_Purchase), 2) AS VAT
FROM WalmartSalesData
GROUP BY Customer_type
ORDER BY VAT DESC

--Unique Customer Types: How many distinct customer types are reflected in our data?
SELECT DISTINCT(Customer_type)
FROM WalmartSalesData
GROUP BY Customer_type

--Unique Payment Methods: How many unique payment methods do we have?
SELECT DISTINCT(Payment), COUNT(Payment) AS Payment_Method
FROM WalmartSalesData
GROUP BY Payment
ORDER BY Payment_Method DESC

--Most Common Customer Type: Which customer type stands out as the most frequent?
SELECT DISTINCT(Customer_type), COUNT(Customer_type) AS Customer_count
FROM WalmartSalesData
GROUP BY Customer_type
ORDER BY Customer_count DESC

--Top Buyer Customer Type: Which customer types, takes the lead in making the most purchases?
SELECT Customer_type, COUNT(*) AS Customer_Type_Count
FROM WalmartSalesData
GROUP BY Customer_type
ORDER BY Customer_Type_Count DESC

--Dominant Customer Gender: What is the prevailing gender among our valued customer? 
SELECT Gender, COUNT(*) AS Customers
FROM WalmartSalesData
GROUP BY Gender
ORDER BY Customers DESC

--Gender distribution per branch: What is the gender breakdown distributed across each branch?
SELECT Gender, COUNT(*) AS Count_Gender
FROM WalmartSalesData
WHERE Branch = 'A'
GROUP BY Gender
ORDER BY Count_Gender DESC

--Prime Rating Hour: During which time of the day do customers generously contribute their ratings?
SELECT Time_of_day, ROUND(AVG(Rating),2) AS Rate
FROM WalmartSalesData
GROUP BY Time_of_day
ORDER BY Rate DESC

--Branch-Wise Prime Rating Hours: Which time of the day sees the most rating per branch? Best avg rating day.
SELECT Time_of_day, ROUND(AVG(Rating),2) AS Rate_Branch
FROM WalmartSalesData
WHERE Branch = 'A'
GROUP BY Time_of_day
ORDER BY Rate_Branch DESC

--On which day of the week do we receive the best average rating overall?
SELECT Day_Of_The_Week, ROUND(AVG(Rating),2) AS Rate_day_week
FROM WalmartSalesData
GROUP BY Day_Of_The_Week
ORDER BY Rate_day_week DESC

--Branch wise Best average Rating day: Does the best avg rating day vary across branches
SELECT Day_Of_The_Week, ROUND(AVG(Rating),2) AS Rate_day_week
FROM WalmartSalesData
WHERE Branch = 'C'
GROUP BY Day_Of_The_Week
ORDER BY Rate_day_week DESC