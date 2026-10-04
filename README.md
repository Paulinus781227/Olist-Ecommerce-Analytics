## Dashboard

The Power BI dashboard is organized into four analytical pages:

### Executive Overview

High-level view of e-commerce performance, order activity, revenue, and key business indicators.

![Executive Overview](Images/Executive_Overview.png)

### Customer & Product Analysis

Explores customer behavior, product and category performance, and sales distribution.

![Customer and Product Analysis](Images/Customer_Product_Analysis.png)

### Logistics & Delivery

Examines delivery performance, delivery delays, freight costs, and geographic differences.

![Logistics and Delivery](Images/Logistics_Delivery.png)

### Customer Satisfaction

Explores review scores and the relationship between delivery performance and customer feedback.

![Customer Satisfaction](Images/Customer_Satisfaction.png)

## Key Insights

The analysis investigates revenue trends, customer purchasing behavior, product and category performance, payment preferences, delivery delays, and customer satisfaction.

The analytical order view contains **99,441 unique orders**. Revenue reconciliation between the analytical view and source order-item records produced a **0.00 difference**, confirming that the analytical transformation preserved the underlying product-revenue values.

Based on the completed SQL analysis and Power BI dashboard, the following key trends were identified:

* **Fulfillment Performance:** The analysis recorded an average delivery time of approximately **12 days**, with a **7.65% late-delivery rate** among orders included in the applicable delivery analysis. Delivery performance varies considerably across customer states.

* **Customer Retention Opportunity:** **93.84% of customers were one-time purchasers**, while repeat customers represented approximately **6.16%**. This indicates a significant opportunity to improve repeat purchasing and customer lifetime value.

* **Category & Revenue Performance:** Revenue is concentrated across leading product categories, with the dashboard highlighting the categories and products contributing most significantly to sales performance.

* **Customer Satisfaction:** The overall average review score was approximately **4.0 out of 5**. The analysis also shows an observable relationship between delivery performance and customer feedback, with late deliveries associated with a greater concentration of lower review scores.

* **Geographic Delivery Differences:** Late-delivery performance varies across customer states. States showing higher late-delivery rates should be investigated alongside their order volumes before operational decisions are made.

## Recommendations

* **Improve Delivery Performance:** Investigate high late-delivery states and shipping corridors to identify carrier, processing, distance, and fulfillment bottlenecks.

* **Increase Customer Retention:** Develop targeted post-purchase engagement and loyalty initiatives for one-time customers to encourage repeat purchases and increase customer lifetime value.

* **Introduce Proactive Delivery Monitoring:** Identify orders approaching their estimated delivery dates and intervene early when delays become likely.

* **Monitor Customer Satisfaction:** Track review scores alongside delivery performance to identify service issues that may negatively affect customer experience.

* **Prioritize High-Performing Categories:** Use category-level revenue and order-volume analysis to guide marketing, merchandising, and inventory decisions.

* **Establish Continuous KPI Monitoring:** Regularly monitor revenue, order volume, customer retention, delivery performance, and customer satisfaction to identify emerging business trends.

> **Analytical note:** The relationships identified in this project represent observed associations and should not be interpreted as proof of causation.

## Project Structure

```text
Olist-Ecommerce-Analytics/
├── Documentation/
├── Excel/
├── Images/
├── PowerBI/
├── SQL/
└── README.md
```

## Dataset

Source: [Brazilian E-Commerce Public Dataset by Olist on Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

The dataset contains anonymized Brazilian e-commerce transactions and related customer, product, payment, review, and logistics information.

## Limitations

* One review record was not loaded compared with the expected source count.
* Missing or invalid delivery dates were handled in the analytical layer.
* Delivery-sequence anomalies were flagged rather than silently corrected.
* Observed relationships between delivery performance and satisfaction do not establish causation.
