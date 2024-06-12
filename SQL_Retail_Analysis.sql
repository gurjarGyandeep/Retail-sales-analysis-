--1. Optimized Data Structure: Updated data types and field lengths for efficient storage and retrieval.
--2.Data Cleansing: Performed data cleaning and preprocessing using Python to ensure data quality.
--3.Table Creation: Created a new table to store the cleaned and optimized dataset.
CREATE TABLE [dbo].[df_order_2010_2011](
	
	[Invoice] [varchar](15)NULL,
	[StockCode] [varchar](20) NULL,
	[Description] [nvarchar](200) NULL,
	[Quantity] [bigint] NULL,
	[InvoiceDate] [datetime] NULL,
	[Price] [float] NULL,
	[Customer ID] [float] NULL,
	[Country] [varchar](30) NULL
) 
GO
---Year_2010_2011
select * 
from [dbo].[df_order_2010_2011]

select count(distinct Country) as unique_country
from [dbo].[df_order_2010_2011]

select  count (distinct StockCode) as unique_StockCode
from [dbo].[df_order_2010_2011]

select  count (distinct [Customer ID]) as unique_Customer_ID
from [dbo].[df_order_2010_2011]

---Sales trend
select InvoiceDate,Country,StockCode,sum(Quantity*Price) as Total_revenue,sum(Quantity) as Total_quantity
into Sales_Year_2010_2011
FROM [dbo].[df_order_2010_2011]
where Price <>0
group by InvoiceDate ,Country,StockCode
order by StockCode


---customer retention
select InvoiceDate,[Customer ID]
into Customer_2010_2011
from [dbo].[df_order_2010_2011]



SELECT FORMAT(this_month.InvoiceDate, 'yyyy-MM') AS YearMonth,COUNT(DISTINCT this_month.[Customer ID]) AS DistinctCustomerCount,
COUNT(DISTINCT last_month.[Customer ID]) AS RetainCustomerCount
Into Customer_Retain_2010_2011
FROM Customer_2010_2011 this_month
LEFT JOIN Customer_2010_2011 last_month ON this_month.[Customer ID] = last_month.[Customer ID] AND DATEDIFF(month, last_month.InvoiceDate, this_month.InvoiceDate) = 1
GROUP BY FORMAT(this_month.InvoiceDate, 'yyyy-MM')
order by FORMAT(this_month.InvoiceDate, 'yyyy-MM');

---Year_2009_2010
CREATE TABLE [dbo].[df_order_2009_2010](
	[Invoice] [varchar](15) NULL,
	[StockCode] [varchar](20) NULL,
	[Description] [nvarchar](100) NULL,
	[Quantity] [bigint] NULL,
	[InvoiceDate] [datetime] NULL,
	[Price] [float] NULL,
	[Customer ID] [float] NULL,
	[Country] [varchar](30) NULL
) 
GO

select *
from [dbo].[df_order_2009_2010]

select * 
from [dbo].[df_order_2009_2010]

select count(distinct Country) as unique_country
from [dbo].[df_order_2009_2010]

select  count (distinct StockCode) as unique_StockCode
from [dbo].[df_order_2009_2010]

select  count (distinct [Customer ID]) as unique_Customer_ID
from [dbo].[df_order_2009_2010]

---Sales trend
select InvoiceDate,Country,StockCode,sum(Quantity*Price) as Total_revenue,sum(Quantity) as Total_quantity
into Sales_2009_2010
FROM [dbo].[df_order_2009_2010]
where Price <>0
group by InvoiceDate ,Country,StockCode
order by StockCode

select InvoiceDate,[Customer ID]
into Customer_2009_2010
from [dbo].[df_order_2009_2010]

---Customer retention
SELECT FORMAT(this_month.InvoiceDate, 'yyyy-MM') AS YearMonth,COUNT(DISTINCT this_month.[Customer ID]) AS DistinctCustomerCount,
COUNT(DISTINCT last_month.[Customer ID]) AS RetainCustomerCount
Into Customer_Retain_2009_2010
FROM Customer_2009_2010 this_month
LEFT JOIN Customer_2009_2010 last_month ON this_month.[Customer ID] = last_month.[Customer ID] AND DATEDIFF(month, last_month.InvoiceDate, this_month.InvoiceDate) = 1
GROUP BY FORMAT(this_month.InvoiceDate, 'yyyy-MM')
order by FORMAT(this_month.InvoiceDate, 'yyyy-MM');

select *
from Customer_Retentaion_2009_2010

select FORMAT(InvoiceDate, 'yyyy-MM') AS YearMonth, count(distinct [Customer ID])
from Customer_2009_2010
group by FORMAT(InvoiceDate, 'yyyy-MM') 




