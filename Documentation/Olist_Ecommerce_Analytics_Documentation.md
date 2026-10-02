\# Olist E-Commerce Analytics — Documentation



\## 1. Project Overview



Analysis of the Brazilian E-Commerce Public Dataset by Olist.



\## 2. Business Objective



Evaluate marketplace sales performance, customer behavior,

product/category performance, logistics, payments and customer satisfaction.



\## 3. Dataset



Approximately 100,000 orders from the Brazilian E-Commerce Public Dataset.



\## 4. Tools



\- MySQL

\- Excel

\- Power BI

\- GitHub



\## 5. Data Preparation



Raw data was preserved.



Analytical views were created in MySQL to:



\- standardize missing dates

\- aggregate order items

\- aggregate reviews

\- aggregate payments

\- prevent join duplication

\- create order-level analytical metrics



\## 6. Data Quality Findings



\- 99,441 orders

\- 99,441 analytical order records

\- Revenue reconciliation difference: 0.00

\- 1 review record discrepancy

\- 1,783 zero carrier dates

\- 2,965 zero customer-delivery dates

\- 23 delivery sequence anomalies

\- 0 impossible delivery-before-purchase records

\- 0 invalid estimated delivery dates



\## 7. Metric Definitions



Revenue = Sum of product price.



AOV = Revenue / distinct orders.



Repeat customer = customer\_unique\_id with more than one order.



Delivery days = delivered customer date minus purchase date.



Late delivery = delivered customer date later than estimated delivery date.



\## 8. Limitations



The review table contains one fewer loaded record than the source count.



Zero-date values were treated as missing rather than valid dates.



Delivery sequence anomalies were flagged rather than modified.



Findings represent associations and should not automatically be interpreted as causal relationships.



\## 9. Business Recommendations



\[List final recommendations based on dashboard findings.]

