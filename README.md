# Advance-Analytics-Project

# 📊 Advanced SQL Analysis Project

A collection of advanced SQL scripts for performing real-world business analysis on sales and customer data. This project covers six core analytical techniques used in data analytics and business intelligence.

---

## 📁 Project Structure

```
├── CHANGE_OVER_TIME_ANALYSIS.sql   # Trend analysis over time
├── CUMULATIVE_ANALYSIS.sql         # Running totals & moving averages
├── PERFORMANCE_ANALYSIS.sql        # YoY & MoM performance comparisons
├── PROPOTIONAL_ANALYSIS.sql        # Part-to-whole / contribution analysis
├── DATA_SEGMENTATION.sql           # Customer & product segmentation
└── CUSTOMER_REPORT.sql             # Final consolidated customer view
```

---

## 🗂️ Modules Overview

### 1. 📈 Change Over Time Analysis
Tracks how key metrics evolve over time to identify trends and seasonality.
- Total sales by day, month, and year
- Monthly trend using `DATETRUNC` and `FORMAT`
- Customer count and quantity trends over time

### 2. 📊 Cumulative Analysis
Progressively aggregates data to understand business growth or decline.
- Running total of sales over time
- Cumulative totals partitioned by year
- Moving average of product prices by month

### 3. ⚡ Performance Analysis
Compares current performance against benchmarks and prior periods.
- Year-over-Year (YoY) product sales comparison
- Month-over-Month (MoM) analysis
- Difference from average sales using window functions
- Uses `LAG()` to pull previous period values

### 4. 🥧 Proportional Analysis
Measures how much each category contributes to the overall business.
- Category-level sales contribution
- Percentage of total using `SUM() OVER()`
- Identifies top-performing product categories

### 5. 🔎 Data Segmentation
Groups data into meaningful ranges for pattern discovery.
- Products segmented by cost range (Below 100, 100–500, etc.)
- Customers segmented into **VIP**, **Regular**, and **New** based on lifespan and spending
- Count of customers per segment

### 6. 👤 Customer Report (View)
Consolidates all customer metrics and KPIs into a single SQL View, ready for Power BI reporting.

**Key Fields:**
- Customer name, age, age group
- Customer segmentation (VIP / Regular / New)
- Total orders, sales, quantity, and products

**KPIs Calculated:**
| KPI | Description |
|-----|-------------|
| Recency | Months since last order |
| Avg Order Value | Total sales ÷ total orders |
| Avg Monthly Spend | Total sales ÷ lifespan (months) |
| Lifespan | Months between first and last order |

---

## 🛠️ SQL Concepts Used

| Concept | Used In |
|--------|---------|
| CTEs (Common Table Expressions) | Customer Report, Segmentation |
| Window Functions (`SUM OVER`, `AVG OVER`, `LAG`) | Cumulative, Performance |
| `DATETRUNC` & `FORMAT` | Change Over Time |
| `CASE WHEN` | Segmentation, Customer Report |
| `DATEDIFF` & `GETDATE` | Customer Report |
| SQL Views | Customer Report |
| Aggregate Functions | All modules |

---

## 🗄️ Database Schema

The project uses three core tables:

```
sales       → order_number, product_key, customer_key, order_date, sales_amount, quantity, price
customers   → customer_key, customer_number, first_name, last_name, birthdate
products    → product_key, product_id, product_name, category, cost
```

---

## 🚀 How to Use

1. Clone this repository
2. Connect to your SQL Server instance (T-SQL / Microsoft SQL Server)
3. Make sure the `sales`, `customers`, and `products` tables exist and are populated
4. Run each `.sql` file independently, or start with `CUSTOMER_REPORT.sql` to create the view
5. Connect the `dbo.report_customers` view to **Power BI** for interactive dashboards

---

## 💡 Key Insights This Project Can Generate

- Which customers are VIP vs at-risk (New)?
- Which product categories drive the most revenue?
- How is the business trending month-over-month?
- Which products are underperforming vs their historical average?
- What is each customer's average monthly spend and recency?

---

## 🧰 Tools & Technologies

- **Microsoft SQL Server** (T-SQL)
- **SQL Server Management Studio (SSMS)**
- **Power BI** (for visualization using the Customer Report view)

---

## 👨‍💻 Author

**Nikhil Dubey**  
📧 nikhildubey17033@gmail.com

---

## 📌 Status

✅ Complete — All 6 modules built and tested.  
🔜 Next step: Power BI dashboard on top of `dbo.report_customers` view.

---

*If you found this project helpful, feel free to ⭐ star the repository!*
