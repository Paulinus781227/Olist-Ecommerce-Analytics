-- =====================================================
-- OLIST E-COMMERCE ANALYTICS
-- SQL BUSINESS ANALYSIS
-- =====================================================

USE olist_ecommerce_analysis;


-- =====================================================
-- 1. EXECUTIVE KPIs
-- =====================================================


-- -----------------------------------------------------
-- 1.1 Executive KPI Summary
-- -----------------------------------------------------

SELECT
    COUNT(DISTINCT oi.order_id) AS total_orders,
    COUNT(DISTINCT o.customer_id) AS total_customers,
    ROUND(SUM(oi.price), 2) AS total_revenue,
    ROUND(
        SUM(oi.price) / COUNT(DISTINCT oi.order_id),
        2
    ) AS average_order_value,
    ROUND(AVG(oi.price), 2) AS average_item_price,
    ROUND(SUM(oi.freight_value), 2) AS total_freight
FROM olist_order_items oi
JOIN olist_orders o
    ON oi.order_id = o.order_id;


-- -----------------------------------------------------
-- 1.2 Total Orders by Order Status
-- -----------------------------------------------------

SELECT
    order_status,
    COUNT(*) AS total_orders
FROM olist_orders
GROUP BY order_status
ORDER BY total_orders DESC;


-- -----------------------------------------------------
-- 1.3 Customer Count
-- -----------------------------------------------------

SELECT
    COUNT(DISTINCT customer_unique_id) AS total_unique_customers
FROM olist_customers;


-- -----------------------------------------------------
-- 1.4 Total Products and Sellers
-- -----------------------------------------------------

SELECT
    (SELECT COUNT(DISTINCT product_id)
     FROM olist_products) AS total_products,

    (SELECT COUNT(DISTINCT seller_id)
     FROM olist_sellers) AS total_sellers;


-- =====================================================
-- 2. REVENUE ANALYSIS
-- =====================================================


-- -----------------------------------------------------
-- 2.1 Revenue by Year
-- -----------------------------------------------------

SELECT
    YEAR(o.order_purchase_timestamp) AS purchase_year,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS revenue,
    ROUND(
        SUM(oi.price) / COUNT(DISTINCT o.order_id),
        2
    ) AS average_order_value
FROM olist_orders o
JOIN olist_order_items oi
    ON o.order_id = oi.order_id
GROUP BY YEAR(o.order_purchase_timestamp)
ORDER BY purchase_year;


-- -----------------------------------------------------
-- 2.2 Monthly Revenue Trend
-- -----------------------------------------------------

SELECT
    DATE_FORMAT(
        o.order_purchase_timestamp,
        '%Y-%m'
    ) AS purchase_month,

    COUNT(DISTINCT o.order_id) AS total_orders,

    ROUND(SUM(oi.price), 2) AS revenue,

    ROUND(
        SUM(oi.price) /
        COUNT(DISTINCT o.order_id),
        2
    ) AS average_order_value

FROM olist_orders o
JOIN olist_order_items oi
    ON o.order_id = oi.order_id

GROUP BY
    DATE_FORMAT(
        o.order_purchase_timestamp,
        '%Y-%m'
    )

ORDER BY purchase_month;


-- -----------------------------------------------------
-- 2.3 Revenue by Order Status
-- -----------------------------------------------------

SELECT
    o.order_status,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS revenue
FROM olist_orders o
JOIN olist_order_items oi
    ON o.order_id = oi.order_id
GROUP BY o.order_status
ORDER BY revenue DESC;


-- -----------------------------------------------------
-- 2.4 Average Order Value by Year
-- -----------------------------------------------------

SELECT
    YEAR(o.order_purchase_timestamp) AS purchase_year,

    COUNT(DISTINCT o.order_id) AS total_orders,

    ROUND(SUM(oi.price), 2) AS revenue,

    ROUND(
        SUM(oi.price) /
        COUNT(DISTINCT o.order_id),
        2
    ) AS average_order_value

FROM olist_orders o
JOIN olist_order_items oi
    ON o.order_id = oi.order_id

GROUP BY YEAR(o.order_purchase_timestamp)

ORDER BY purchase_year;


-- -----------------------------------------------------
-- 2.5 Revenue by Customer State
-- -----------------------------------------------------

SELECT
    c.customer_state,

    COUNT(DISTINCT o.order_id) AS total_orders,

    COUNT(DISTINCT c.customer_unique_id) AS customers,

    ROUND(SUM(oi.price), 2) AS revenue,

    ROUND(
        SUM(oi.price) /
        COUNT(DISTINCT o.order_id),
        2
    ) AS average_order_value

FROM olist_customers c

JOIN olist_orders o
    ON c.customer_id = o.customer_id

JOIN olist_order_items oi
    ON o.order_id = oi.order_id

GROUP BY c.customer_state

ORDER BY revenue DESC;


-- -----------------------------------------------------
-- 2.6 Freight Cost vs Product Revenue
-- -----------------------------------------------------

SELECT
    ROUND(SUM(price), 2) AS product_revenue,

    ROUND(SUM(freight_value), 2) AS freight_cost,

    ROUND(
        SUM(freight_value) /
        SUM(price) * 100,
        2
    ) AS freight_to_revenue_percentage

FROM olist_order_items;


-- -----------------------------------------------------
-- 2.7 Revenue by Payment Type
-- -----------------------------------------------------

SELECT
    payment_type,

    COUNT(DISTINCT order_id) AS total_orders,

    ROUND(SUM(payment_value), 2) AS payment_value

FROM olist_order_payments

GROUP BY payment_type

ORDER BY payment_value DESC;


-- -----------------------------------------------------
-- 2.8 Payment Installment Analysis
-- -----------------------------------------------------

SELECT
    payment_installments,

    COUNT(DISTINCT order_id) AS total_orders,

    ROUND(SUM(payment_value), 2) AS payment_value

FROM olist_order_payments

GROUP BY payment_installments

ORDER BY payment_installments;


-- =====================================================
-- 3. CUSTOMER ANALYSIS
-- =====================================================


-- -----------------------------------------------------
-- 3.1 Top 10 Customers by Revenue
-- -----------------------------------------------------

SELECT
    o.customer_id,

    c.customer_unique_id,

    COUNT(DISTINCT o.order_id) AS total_orders,

    ROUND(SUM(oi.price), 2) AS total_spend

FROM olist_orders o

JOIN olist_customers c
    ON o.customer_id = c.customer_id

JOIN olist_order_items oi
    ON o.order_id = oi.order_id

GROUP BY
    o.customer_id,
    c.customer_unique_id

ORDER BY total_spend DESC

LIMIT 10;


-- -----------------------------------------------------
-- 3.2 Repeat Customer Analysis
-- -----------------------------------------------------

WITH customer_orders AS (

    SELECT
        c.customer_unique_id,

        COUNT(DISTINCT o.order_id) AS order_count

    FROM olist_customers c

    JOIN olist_orders o
        ON c.customer_id = o.customer_id

    GROUP BY c.customer_unique_id
)

SELECT

    COUNT(*) AS total_customers,

    SUM(order_count = 1) AS one_time_customers,

    SUM(order_count > 1) AS repeat_customers,

    ROUND(
        SUM(order_count > 1) /
        COUNT(*) * 100,
        2
    ) AS repeat_customer_rate

FROM customer_orders;


-- -----------------------------------------------------
-- 3.3 Customers by Number of Orders
-- -----------------------------------------------------

WITH customer_orders AS (

    SELECT
        c.customer_unique_id,

        COUNT(DISTINCT o.order_id) AS order_count

    FROM olist_customers c

    JOIN olist_orders o
        ON c.customer_id = o.customer_id

    GROUP BY c.customer_unique_id
)

SELECT

    CASE

        WHEN order_count = 1
            THEN '1 Order'

        WHEN order_count = 2
            THEN '2 Orders'

        WHEN order_count BETWEEN 3 AND 5
            THEN '3-5 Orders'

        ELSE '6+ Orders'

    END AS customer_order_group,

    COUNT(*) AS customer_count

FROM customer_orders

GROUP BY

    CASE

        WHEN order_count = 1
            THEN '1 Order'

        WHEN order_count = 2
            THEN '2 Orders'

        WHEN order_count BETWEEN 3 AND 5
            THEN '3-5 Orders'

        ELSE '6+ Orders'

    END

ORDER BY customer_count DESC;


-- -----------------------------------------------------
-- 3.4 Average Spend: One-Time vs Repeat Customers
-- -----------------------------------------------------

WITH customer_metrics AS (

    SELECT

        c.customer_unique_id,

        COUNT(DISTINCT o.order_id) AS total_orders,

        ROUND(SUM(oi.price), 2) AS total_spend

    FROM olist_customers c

    JOIN olist_orders o
        ON c.customer_id = o.customer_id

    JOIN olist_order_items oi
        ON o.order_id = oi.order_id

    GROUP BY c.customer_unique_id
)

SELECT

    CASE

        WHEN total_orders = 1
            THEN 'One-Time'

        ELSE 'Repeat'

    END AS customer_type,

    COUNT(*) AS customers,

    ROUND(
        AVG(total_spend),
        2
    ) AS average_customer_spend,

    ROUND(
        SUM(total_spend),
        2
    ) AS total_revenue

FROM customer_metrics

GROUP BY

    CASE

        WHEN total_orders = 1
            THEN 'One-Time'

        ELSE 'Repeat'

    END;


-- -----------------------------------------------------
-- 3.5 Customer Revenue Concentration
-- -----------------------------------------------------

WITH customer_revenue AS (

    SELECT

        c.customer_unique_id,

        ROUND(
            SUM(oi.price),
            2
        ) AS total_spend

    FROM olist_customers c

    JOIN olist_orders o
        ON c.customer_id = o.customer_id

    JOIN olist_order_items oi
        ON o.order_id = oi.order_id

    GROUP BY c.customer_unique_id
),

ranked_customers AS (

    SELECT

        customer_unique_id,

        total_spend,

        RANK() OVER (
            ORDER BY total_spend DESC
        ) AS revenue_rank

    FROM customer_revenue
),

total_revenue AS (

    SELECT

        SUM(total_spend) AS company_revenue

    FROM customer_revenue
),

top_customers AS (

    SELECT

        SUM(total_spend) AS top_10_revenue,

        COUNT(*) AS top_10_customers

    FROM ranked_customers

    WHERE revenue_rank <= 10
)

SELECT

    tc.top_10_customers,

    ROUND(
        tc.top_10_revenue,
        2
    ) AS top_10_revenue,

    ROUND(
        tc.top_10_revenue /
        tr.company_revenue * 100,
        2
    ) AS top_10_revenue_percentage

FROM top_customers tc

CROSS JOIN total_revenue tr;


-- =====================================================
-- 4. PRODUCT & CATEGORY ANALYSIS
-- =====================================================


-- -----------------------------------------------------
-- 4.1 Top 10 Categories by Revenue
-- -----------------------------------------------------

SELECT

    COALESCE(
        t.product_category_name_english,
        p.product_category_name
    ) AS category,

    COUNT(DISTINCT oi.order_id) AS orders,

    ROUND(
        SUM(oi.price),
        2
    ) AS revenue

FROM olist_order_items oi

JOIN olist_products p
    ON oi.product_id = p.product_id

LEFT JOIN product_category_translation t
    ON p.product_category_name =
       t.product_category_name

GROUP BY

    COALESCE(
        t.product_category_name_english,
        p.product_category_name
    )

ORDER BY revenue DESC

LIMIT 10;


-- -----------------------------------------------------
-- 4.2 Top 10 Products by Revenue
-- -----------------------------------------------------

SELECT

    oi.product_id,

    COALESCE(
        t.product_category_name_english,
        p.product_category_name
    ) AS category,

    COUNT(*) AS units_sold,

    ROUND(
        SUM(oi.price),
        2
    ) AS revenue

FROM olist_order_items oi

JOIN olist_products p
    ON oi.product_id = p.product_id

LEFT JOIN product_category_translation t
    ON p.product_category_name =
       t.product_category_name

GROUP BY

    oi.product_id,

    COALESCE(
        t.product_category_name_english,
        p.product_category_name
    )

ORDER BY revenue DESC

LIMIT 10;


-- -----------------------------------------------------
-- 4.3 Category Freight Burden
-- -----------------------------------------------------

SELECT

    COALESCE(
        t.product_category_name_english,
        p.product_category_name
    ) AS category,

    ROUND(
        AVG(oi.freight_value),
        2
    ) AS average_freight,

    ROUND(
        AVG(oi.price),
        2
    ) AS average_item_price,

    ROUND(
        AVG(oi.freight_value) /
        AVG(oi.price) * 100,
        2
    ) AS freight_price_ratio

FROM olist_order_items oi

JOIN olist_products p
    ON oi.product_id = p.product_id

LEFT JOIN product_category_translation t
    ON p.product_category_name =
       t.product_category_name

GROUP BY

    COALESCE(
        t.product_category_name_english,
        p.product_category_name
    )

HAVING COUNT(*) >= 50

ORDER BY freight_price_ratio DESC

LIMIT 15;


-- -----------------------------------------------------
-- 4.4 Category Ranking by Revenue
-- -----------------------------------------------------

WITH category_revenue AS (

    SELECT

        COALESCE(
            t.product_category_name_english,
            p.product_category_name
        ) AS category,

        ROUND(
            SUM(oi.price),
            2
        ) AS revenue

    FROM olist_order_items oi

    JOIN olist_products p
        ON oi.product_id = p.product_id

    LEFT JOIN product_category_translation t
        ON p.product_category_name =
           t.product_category_name

    GROUP BY

        COALESCE(
            t.product_category_name_english,
            p.product_category_name
        )
)

SELECT

    category,

    revenue,

    RANK() OVER (
        ORDER BY revenue DESC
    ) AS revenue_rank

FROM category_revenue

ORDER BY revenue_rank;


-- =====================================================
-- 5. LOGISTICS & DELIVERY
-- =====================================================


-- -----------------------------------------------------
-- 5.1 Average Delivery Time
-- -----------------------------------------------------

SELECT

    ROUND(
        AVG(
            DATEDIFF(
                order_delivered_customer_date,
                order_purchase_timestamp
            )
        ),
        2
    ) AS average_delivery_days

FROM olist_orders

WHERE order_delivered_customer_date IS NOT NULL;


-- -----------------------------------------------------
-- 5.2 Late Delivery Rate
-- -----------------------------------------------------

SELECT

    COUNT(*) AS delivered_orders,

    SUM(
        order_delivered_customer_date >
        order_estimated_delivery_date
    ) AS late_orders,

    ROUND(

        SUM(
            order_delivered_customer_date >
            order_estimated_delivery_date
        )

        / COUNT(*) * 100,

        2

    ) AS late_delivery_rate

FROM olist_orders

WHERE order_delivered_customer_date IS NOT NULL

AND order_estimated_delivery_date IS NOT NULL;


-- -----------------------------------------------------
-- 5.3 Delivery Performance by Customer State
-- -----------------------------------------------------

SELECT

    c.customer_state,

    COUNT(DISTINCT o.order_id) AS delivered_orders,

    ROUND(

        AVG(
            DATEDIFF(
                o.order_delivered_customer_date,
                o.order_purchase_timestamp
            )
        ),

        2

    ) AS average_delivery_days

FROM olist_customers c

JOIN olist_orders o
    ON c.customer_id = o.customer_id

WHERE o.order_delivered_customer_date IS NOT NULL

GROUP BY c.customer_state

ORDER BY average_delivery_days DESC;


-- -----------------------------------------------------
-- 5.4 Late Delivery Rate by Customer State
-- -----------------------------------------------------

SELECT

    c.customer_state,

    COUNT(*) AS delivered_orders,

    SUM(

        o.order_delivered_customer_date >
        o.order_estimated_delivery_date

    ) AS late_orders,

    ROUND(

        SUM(

            o.order_delivered_customer_date >
            o.order_estimated_delivery_date

        )

        / COUNT(*) * 100,

        2

    ) AS late_delivery_rate

FROM olist_customers c

JOIN olist_orders o
    ON c.customer_id = o.customer_id

WHERE o.order_delivered_customer_date IS NOT NULL

AND o.order_estimated_delivery_date IS NOT NULL

GROUP BY c.customer_state

ORDER BY late_delivery_rate DESC;


-- =====================================================
-- 6. CUSTOMER SATISFACTION
-- =====================================================


-- -----------------------------------------------------
-- 6.1 Review Score Distribution
-- -----------------------------------------------------

SELECT

    review_score,

    COUNT(*) AS review_count,

    ROUND(

        COUNT(*) /
        (SELECT COUNT(*)
         FROM olist_order_reviews) * 100,

        2

    ) AS percentage_of_reviews

FROM olist_order_reviews

GROUP BY review_score

ORDER BY review_score;


-- -----------------------------------------------------
-- 6.2 Overall Review Score
-- -----------------------------------------------------

SELECT

    COUNT(*) AS total_reviews,

    ROUND(
        AVG(review_score),
        2
    ) AS average_review_score

FROM olist_order_reviews;


-- -----------------------------------------------------
-- 6.3 Late Delivery vs Customer Satisfaction
-- -----------------------------------------------------

WITH order_reviews AS (

    SELECT

        order_id,

        ROUND(
            AVG(review_score),
            2
        ) AS average_review_score

    FROM olist_order_reviews

    GROUP BY order_id
),

delivery_analysis AS (

    SELECT

        o.order_id,

        CASE

            WHEN
                o.order_delivered_customer_date >
                o.order_estimated_delivery_date

            THEN 'Late'

            ELSE 'On Time'

        END AS delivery_status,

        orv.average_review_score

    FROM olist_orders o

    LEFT JOIN order_reviews orv

        ON o.order_id = orv.order_id

    WHERE o.order_delivered_customer_date IS NOT NULL

    AND o.order_estimated_delivery_date IS NOT NULL
)

SELECT

    delivery_status,

    COUNT(*) AS total_orders,

    ROUND(
        AVG(average_review_score),
        2
    ) AS average_review_score

FROM delivery_analysis

WHERE average_review_score IS NOT NULL

GROUP BY delivery_status;


-- =====================================================
-- 7. SELLER PERFORMANCE
-- =====================================================


-- -----------------------------------------------------
-- 7.1 Top Sellers by Revenue
-- -----------------------------------------------------

SELECT

    oi.seller_id,

    s.seller_city,

    s.seller_state,

    COUNT(DISTINCT oi.order_id) AS total_orders,

    ROUND(
        SUM(oi.price),
        2
    ) AS revenue

FROM olist_order_items oi

JOIN olist_sellers s
    ON oi.seller_id = s.seller_id

GROUP BY

    oi.seller_id,

    s.seller_city,

    s.seller_state

ORDER BY revenue DESC

LIMIT 20;


-- -----------------------------------------------------
-- 7.2 Seller Performance with Reviews
-- -----------------------------------------------------

WITH order_reviews AS (

    SELECT

        order_id,

        ROUND(
            AVG(review_score),
            2
        ) AS average_review_score

    FROM olist_order_reviews

    GROUP BY order_id
),

seller_performance AS (

    SELECT

        oi.seller_id,

        COUNT(DISTINCT oi.order_id)
            AS total_orders,

        ROUND(
            SUM(oi.price),
            2
        ) AS revenue,

        ROUND(
            AVG(orv.average_review_score),
            2
        ) AS average_review_score

    FROM olist_order_items oi

    JOIN olist_orders o
        ON oi.order_id = o.order_id

    LEFT JOIN order_reviews orv
        ON o.order_id = orv.order_id

    GROUP BY oi.seller_id
)

SELECT

    s.seller_id,

    s.seller_city,

    s.seller_state,

    sp.total_orders,

    sp.revenue,

    sp.average_review_score,

    RANK() OVER (
        ORDER BY sp.revenue DESC
    ) AS revenue_rank

FROM seller_performance sp

JOIN olist_sellers s
    ON sp.seller_id = s.seller_id

ORDER BY revenue_rank

LIMIT 20;


-- =====================================================
-- 8. ADVANCED WINDOW FUNCTION ANALYSIS
-- =====================================================


-- -----------------------------------------------------
-- 8.1 Monthly Revenue Growth
-- -----------------------------------------------------

WITH monthly_revenue AS (

    SELECT

        DATE_FORMAT(
            o.order_purchase_timestamp,
            '%Y-%m'
        ) AS purchase_month,

        ROUND(
            SUM(oi.price),
            2
        ) AS revenue

    FROM olist_orders o

    JOIN olist_order_items oi
        ON o.order_id = oi.order_id

    GROUP BY

        DATE_FORMAT(
            o.order_purchase_timestamp,
            '%Y-%m'
        )
)

SELECT

    purchase_month,

    revenue,

    LAG(revenue) OVER (
        ORDER BY purchase_month
    ) AS previous_month_revenue,

    ROUND(

        (

            revenue -

            LAG(revenue) OVER (
                ORDER BY purchase_month
            )

        )

        /

        LAG(revenue) OVER (
            ORDER BY purchase_month
        )

        * 100,

        2

    ) AS month_over_month_growth

FROM monthly_revenue

ORDER BY purchase_month;


-- -----------------------------------------------------
-- 8.2 Category Revenue Ranking
-- -----------------------------------------------------

WITH category_revenue AS (

    SELECT

        COALESCE(
            t.product_category_name_english,
            p.product_category_name
        ) AS category,

        ROUND(
            SUM(oi.price),
            2
        ) AS revenue

    FROM olist_order_items oi

    JOIN olist_products p
        ON oi.product_id = p.product_id

    LEFT JOIN product_category_translation t
        ON p.product_category_name =
           t.product_category_name

    GROUP BY

        COALESCE(
            t.product_category_name_english,
            p.product_category_name
        )
)

SELECT

    category,

    revenue,

    RANK() OVER (
        ORDER BY revenue DESC
    ) AS revenue_rank,

    DENSE_RANK() OVER (
        ORDER BY revenue DESC
    ) AS dense_revenue_rank,

    ROW_NUMBER() OVER (
        ORDER BY revenue DESC
    ) AS row_number_rank

FROM category_revenue

ORDER BY revenue_rank;


-- -----------------------------------------------------
-- 8.3 Seller Revenue Ranking
-- -----------------------------------------------------

WITH seller_revenue AS (

    SELECT

        oi.seller_id,

        ROUND(
            SUM(oi.price),
            2
        ) AS revenue

    FROM olist_order_items oi

    GROUP BY oi.seller_id
)

SELECT

    seller_id,

    revenue,

    RANK() OVER (
        ORDER BY revenue DESC
    ) AS revenue_rank

FROM seller_revenue

ORDER BY revenue_rank

LIMIT 20;


-- -----------------------------------------------------
-- 8.4 Customer Spending Ranking
-- -----------------------------------------------------

WITH customer_revenue AS (

    SELECT

        c.customer_unique_id,

        ROUND(
            SUM(oi.price),
            2
        ) AS total_spend

    FROM olist_customers c

    JOIN olist_orders o
        ON c.customer_id = o.customer_id

    JOIN olist_order_items oi
        ON o.order_id = oi.order_id

    GROUP BY c.customer_unique_id
)

SELECT

    customer_unique_id,

    total_spend,

    RANK() OVER (
        ORDER BY total_spend DESC
    ) AS spending_rank

FROM customer_revenue

ORDER BY spending_rank

LIMIT 20;


-- -----------------------------------------------------
-- 8.5 Revenue by Category with Running Total
-- -----------------------------------------------------

WITH category_revenue AS (

    SELECT

        COALESCE(
            t.product_category_name_english,
            p.product_category_name
        ) AS category,

        ROUND(
            SUM(oi.price),
            2
        ) AS revenue

    FROM olist_order_items oi

    JOIN olist_products p
        ON oi.product_id = p.product_id

    LEFT JOIN product_category_translation t
        ON p.product_category_name =
           t.product_category_name

    GROUP BY

        COALESCE(
            t.product_category_name_english,
            p.product_category_name
        )
)

SELECT

    category,

    revenue,

    ROUND(

        SUM(revenue) OVER (
            ORDER BY revenue DESC
            ROWS BETWEEN UNBOUNDED PRECEDING
            AND CURRENT ROW
        ),

        2

    ) AS cumulative_revenue

FROM category_revenue

ORDER BY revenue DESC;


-- -----------------------------------------------------
-- 8.6 Category Revenue Percentage of Total
-- -----------------------------------------------------

WITH category_revenue AS (

    SELECT

        COALESCE(
            t.product_category_name_english,
            p.product_category_name
        ) AS category,

        SUM(oi.price) AS revenue

    FROM olist_order_items oi

    JOIN olist_products p
        ON oi.product_id = p.product_id

    LEFT JOIN product_category_translation t
        ON p.product_category_name =
           t.product_category_name

    GROUP BY

        COALESCE(
            t.product_category_name_english,
            p.product_category_name
        )
)

SELECT

    category,

    ROUND(
        revenue,
        2
    ) AS revenue,

    ROUND(

        revenue /
        SUM(revenue) OVER () * 100,

        2

    ) AS percentage_of_total_revenue

FROM category_revenue

ORDER BY revenue DESC;


