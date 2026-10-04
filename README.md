\# Olist E-Commerce Customer \& Logistics Analytics



\## Overview



An end-to-end e-commerce analytics project using the Brazilian

E-Commerce Public Dataset by Olist.



The project analyzes sales performance, customer behavior,

product/category performance, logistics, payments and customer satisfaction.



\## Business Questions



\- How is revenue performing over time?

\- Which categories and products generate the most revenue?

\- Which states generate the most sales?

\- What proportion of customers are repeat customers?

\- How does freight cost vary across categories?

\- How long do customers wait for delivery?

\- Which states have higher late-delivery rates?

\- Is late delivery associated with customer satisfaction?

\- Which payment methods are most frequently used?

\- Which sellers generate the most revenue?



\## Tools



\- MySQL

\- Excel

\- Power BI

\- GitHub



\## Data



Brazilian E-Commerce Public Dataset by Olist.



Approximately 100,000 orders covering the 2016–2018 period.



\## Data Preparation



SQL analytical views were created to:



\- create an order-level analytical dataset

\- aggregate order items

\- aggregate reviews

\- aggregate payments

\- handle missing date values

\- prevent duplicated revenue

\- flag delivery-sequence anomalies



\## Data Quality



The final analytical order view contains 99,441 unique orders.



Revenue reconciliation between the analytical view and source order-item

data produced a difference of 0.00.



One review record was not loaded compared with the expected source count.

This represents approximately 0.001% of review records.



\## Dashboard



\### Executive Overview



![Executive Overview](Images/Executive_Overview.png)


\### Customer \& Product Analysis



![Customer Product Analysis](Images/Customer_Product_Analysis.png)



\### Logistics \& Delivery



![Logistics Delivery](Images/Logistics_Delivery.png)


\### Customer Satisfaction



![Customer Satisfaction](Images/Customer_Satisfaction.png)



\## Key Insights



Final business insights will be added after dashboard analysis.



\## Recommendations



Final recommendations will be based on validated analytical findings.



\## Project Structure



```text

Data/

SQL/

Excel/

PowerBI/

Documentation/

Images/

