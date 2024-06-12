--Year_2010_2011
WITH RFM AS
(
SELECT
        [Customer ID],
        MAX(InvoiceDate) as Last_order_date,
        (select MAX(InvoiceDate) as Last_order_date from [dbo].[df_order_2010_2011]) Max_Transaction_Date,
        DATEDIFF(DD,MAX(InvoiceDate),(select MAX(InvoiceDate) as Last_order_date from [dbo].[df_order_2010_2011])) Recency,
        COUNT(Invoice) Frequency,
        SUM(Quantity*Price) MonetaryValue
        --AVG(list_price)AvgMonetaryValue
    FROM [dbo].[df_order_2010_2011]
    GROUP BY [Customer ID]
	)
,rfm_calc AS(
 SELECT RFM.*,
        NTILE(4) OVER (ORDER BY Recency) rfm_recency,
        NTILE(4) OVER (ORDER BY Frequency) rfm_frequency,
        NTILE(4) OVER (ORDER BY MonetaryValue) rfm_monetary
FROM RFM )

SELECT 
    c.*, rfm_recency+rfm_frequency+rfm_monetary as rfm_cell,
    CAST(rfm_recency as varchar)+CAST(rfm_frequency as varchar)+CAST(rfm_monetary as varchar) rfm_score
INTO rfm_matrix_2010_2011
from rfm_calc c

--CUSTOMER SEGMENTATION

SELECT [Customer ID], rfm_recency,rfm_frequency,rfm_monetary,rfm_score,
    case 
        when rfm_score in (444,443,434,433) then 'churned best customer' --they have transacted a lot and frequent but it has been a long time since last transaction
        when rfm_score in (421,422,423,424,434,432,433,431) then 'lost customer'
        when rfm_score in (342,332,341,331) then 'declining customer'
        when rfm_score in (344,343,334,333) then 'slipping best customer'--they are best customer that have not purchased in a while
        when rfm_score in (142,141,143,131,132,133,242,241,243,231,232,233) then 'active loyal customer' -- they have purchased recently, frequently, but have low monetary value
        when rfm_score in (112,111,113,114,211,213,214,212) then 'new customer' 
        when rfm_score in (144) then 'best customer'-- they have purchase recently and frequently, with high monetary value
        when rfm_score in (411,412,413,414,313,312,314,311) then 'one time customer'
        when rfm_score in (222,221,223,224) then 'Potential customer'
        else 'customer'
    end rfm_segment
into CUSTOMER_SEGMENTATION_2010_2011
FROM rfm_matrix_2010_2011

--Year_2009_2010
WITH RFM AS
(
SELECT
        [Customer ID],
        MAX(InvoiceDate) as Last_order_date,
        (select MAX(InvoiceDate) as Last_order_date from [dbo].[df_order_2009_2010]) Max_Transaction_Date,
        DATEDIFF(DD,MAX(InvoiceDate),(select MAX(InvoiceDate) as Last_order_date from [dbo].[df_order_2009_2010])) Recency,
        COUNT(Invoice) Frequency,
        SUM(Quantity*Price) MonetaryValue
        --AVG(list_price)AvgMonetaryValue
    FROM [dbo].[df_order_2009_2010]
    GROUP BY [Customer ID]
	)
,rfm_calc AS(
 SELECT RFM.*,
        NTILE(4) OVER (ORDER BY Recency) rfm_recency,
        NTILE(4) OVER (ORDER BY Frequency) rfm_frequency,
        NTILE(4) OVER (ORDER BY MonetaryValue) rfm_monetary
FROM RFM )

SELECT 
    c.*, rfm_recency+rfm_frequency+rfm_monetary as rfm_cell,
    CAST(rfm_recency as varchar)+CAST(rfm_frequency as varchar)+CAST(rfm_monetary as varchar) rfm_score
INTO rfm_matrix_2009_2010
from rfm_calc c

--CUSTOMER SEGMENTATION

SELECT [Customer ID], rfm_recency,rfm_frequency,rfm_monetary,rfm_score,
    case 
        when rfm_score in (444,443,434,433) then 'churned best customer' --they have transacted a lot and frequent but it has been a long time since last transaction
        when rfm_score in (421,422,423,424,434,432,433,431) then 'lost customer'
        when rfm_score in (342,332,341,331) then 'declining customer'
        when rfm_score in (344,343,334,333) then 'slipping best customer'--they are best customer that have not purchased in a while
        when rfm_score in (142,141,143,131,132,133,242,241,243,231,232,233) then 'active loyal customer' -- they have purchased recently, frequently, but have low monetary value
        when rfm_score in (112,111,113,114,211,213,214,212) then 'new customer' 
        when rfm_score in (144) then 'best customer'-- they have purchase recently and frequently, with high monetary value
        when rfm_score in (411,412,413,414,313,312,314,311) then 'one time customer'
        when rfm_score in (222,221,223,224) then 'Potential customer'
        else 'customer'
    end rfm_segment
into CUSTOMER_SEGMENTATION_2009_2010
FROM rfm_matrix_2009_2010

