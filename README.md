## Dashboard

The Power BI dashboard is organized into four analytical pages:

### Executive Overview

High-level view of e-commerce performance, order activity, revenue, and key business indicators.

![Executive Overview](Images/Executive_Overview.png)

### Customer & Product Analysis

Explores customer behavior, product and category performance, and sales distribution.

![Customer & Product Analysis](Images/Customer_Product_Analysis.png)

### Logistics & Delivery

Examines delivery performance, delivery delays, freight costs, and geographic differences.

![Logistics & Delivery](Images/Logistics_Delivery.png)

### Customer Satisfaction

Explores review scores and the relationship between delivery performance and customer feedback.

![Customer Satisfaction](Images/Customer_Satisfaction.png)

## Key Insights

The analysis investigates revenue trends, customer purchasing behavior, product and category performance, payment preferences, delivery delays, and customer satisfaction.

The analytical order view contains **99,441 unique orders**. Revenue reconciliation between the analytical view and source order-item records produced a difference of 0.00. Based on the dashboard visualizations, the following specific trends have been identified:

* **Fulfillment Barriers:** The system tracks a high **Average Delivery Time of 12 Days**, driving a **Late Delivery Rate of 7.65%** (translating to 371 totally delayed orders). Regional breakdown reveals that shipping corridors into **AM and AL** experience extreme delivery friction, reaching up to **50.00% late delivery rates**.
* **Retention Deficit:** Customer purchasing patterns show an extremely high attrition floor, with **One-Time Customers accounting for 93.84%** of total buyers, leaving repeat shoppers at just 6.16%.
* **Core Revenue Drivers:** Overall sales reached **\$2 Million** across the operational view, maintaining an **Average Order Value (AOV) of \$419.69**, heavily anchored by volume in the bed/bath, health, and sports categories.
* **Fulfillment vs Sentiment:** While the baseline **Average Review Score holds at a 4 out of 5**, localized visual analytics prove that late delivery status strongly correlates with 1 and 2-star feedback spikes.

## Recommendations

* **Address High-Delay Corridors:** Prioritize operational deep-dives into the **AM and AL logistics lanes** to renegotiate third-party carrier SLAs or re-route high-delay dispatch segments.
* **Deploy Retention Campaigns:** Design targeted loyalty initiatives or post-purchase triggers focusing on the **93.84% one-time buyer demographic** to drive repeat traction.
* **Proactive Support Interventions:** Create automated customer support alerts that flag orders exceeding the standard transit windows, deploying apology incentives *before* delivery to protect the **4.0 average review score**.
* **Capitalize on Top Categories:** Allocate optimized digital marketing spend toward the specific category lines showing dominant volume trends to systematically protect the **\$2M top-line base**.

## Project Structure

```text
Olist-Ecommerce-Analytics/
├── README.md
├── Images/
│   ├── Executive_Overview.png
│   ├── Customer_Product_Analysis.png
│   ├── Logistics_Delivery.png
│   └── Customer_Satisfaction.png
├── Olist_Ecommerce_Analytics.pbix
└── SQL_Scripts/
```

## Dataset

Source: [Brazilian E-Commerce Public Dataset by Olist on Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

The dataset contains anonymized Brazilian e-commerce transactions and related customer, product, payment, review, and logistics information.

## Limitations

* One review record was not loaded compared with the expected source count.
* Missing or invalid delivery dates were handled in the analytical layer.
* Delivery-sequence anomalies were flagged rather than silently corrected.
* Observed relationships between delivery performance and satisfaction do not establish causation.
