-- What is the total sales?
select sum(sales) from orders


--What is the total profit?
select sum(Profit) from orders

--How many unique orders are there?
SELECT COUNT(DISTINCT `Order ID`) AS Unique_Orders
FROM orders;

--How many unique customers are there?
SELECT COUNT(DISTINCT `Customer ID`) AS Unique_Customers
FROM orders;

--What is the total quantity of products sold?
SELECT SUM(Quantity) AS Total_Quantity
FROM orders;

--What is the average sales per order?
SELECT AVG(Total_Sales) AS Average_Sales_Per_Order
FROM (
    SELECT `Order ID`, SUM(Sales) AS Total_Sales
    FROM orders
    GROUP BY `Order ID`
) AS order_sales;

--Which category generates the highest total sales?
select Category,sum(Sales) from orders group by Category order by sum(Sales) desc;

--Which category generates the highest total profit?
select Category,sum(Profit) from orders group by Category order by sum(Profit) desc;

--Which region generates the highest total sales?
select Region,sum(Sales) from orders group by Region Order By sum(Sales) desc limit 1;

--Which region generates the highest total profit?
 select Region,sum(Profit) from orders group by Region Order By sum(Profit) desc limit 1;


--What is the average order value?
SELECT 
    SUM(Sales) / COUNT(DISTINCT `Order ID`) AS Average_Order_Value
FROM orders;


--Which are the top 10 customers by total sales?
 select `Customer Name`,sum(Sales) from orders group by `Customer Name` order by sum(Sales) desc limit 10;

--Which products have generated a loss?
 select `Product Name`,sum(Profit) from orders group by `Product Name` having sum(profit)<0 limit 10;

--Which category has the highest profit margin?
SELECT
    Category,
    SUM(Profit) / SUM(Sales) * 100 AS Profit_Margin
FROM orders
GROUP BY Category
ORDER BY Profit_Margin DESC
LIMIT 1;

--Which sub-category has the highest profit margin?
 select `Sub-Category`,sum(Profit)/sum(Sales)*100 as Profit_Margin from orders group by `Sub-Category` order by Profit_Margin desc limit 1;

--Which customers have placed more than 5 orders?
select `Customer Name`,count(distinct `Order ID`) as Customer_Order from orders group by `Customer Name` having Customer_Order>5;

--Rank customers based on total sales.
select `Customer Name`,sum(Sales),rank() over (order by sum(Sales) desc) as `Sales_Rank` from orders group by `Customer Name` ORDER BY Sales_Rank;

--Find the top-selling product in each category.
SELECT
    Category,
    `Product Name`,
    SUM(Sales) AS Total_Sales,
    RANK() OVER (
        PARTITION BY Category
        ORDER BY SUM(Sales) DESC
    ) AS Sales_Rank
FROM orders
GROUP BY Category, `Product Name`;

--What is the year-over-year sales growth?
WITH yearly_sales AS (
    SELECT
        Year,
        SUM(Sales) AS Total_Sales
    FROM orders
    GROUP BY Year
)

SELECT
    Year,
    Total_Sales,
    LAG(Total_Sales) OVER (ORDER BY Year) AS Previous_Year_Sales,
    ROUND(
        (Total_Sales - LAG(Total_Sales) OVER (ORDER BY Year))
        / LAG(Total_Sales) OVER (ORDER BY Year) * 100,
        2
    ) AS YoY_Growth_Percent
FROM yearly_sales
ORDER BY Year;

--Which customers have made repeat purchases?
SELECT
    `Customer Name`,
    COUNT(DISTINCT `Order ID`) AS Total_Orders
FROM orders
GROUP BY `Customer Name`
HAVING COUNT(DISTINCT `Order ID`) > 1
ORDER BY Total_Orders DESC;

--Which sub-categories are generating a loss?
 select `Sub-Category`,SUM(Profit) as loss from orders group by `Sub-Category` having loss<0 order by loss limit 10;


--Which month had the highest total sales?
 select Month,sum(Sales) as total_sales from orders group by Month order by sum(Sales) desc limit 1;