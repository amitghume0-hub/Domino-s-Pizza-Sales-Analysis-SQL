![dominoz pizza](https://traidev.com/thumb/dominos.png)





# 🍕 Domino’s Pizza Store Analysis SQL Project

## Project Overview

**Project Title**: Domino’s Pizza Store Analysis  
**Level**: Beginner to Intermediate  
**Database**: `p1_dominos_db`

This project demonstrates SQL techniques used by analysts to explore, clean, and analyze pizza sales and customer data. The analysis focuses on understanding order patterns, revenue, customer behavior, and menu performance to support business decision-making.

---

## Objectives

1. **Set up a Domino’s pizza database**: Create and populate the database with orders, pizzas, and customers.  
2. **Data Cleaning**: Identify and remove null or inconsistent records.  
3. **Exploratory Data Analysis (EDA)**: Understand customer behavior, order trends, and menu performance.  
4. **Business Analysis**: Answer stakeholder-driven questions to derive actionable insights.

---

## Database Structure

**Tables**:

- `orders`: Contains order-level information (order_id, custId, order_date, order_time).  
- `order_details`: Contains details of each order (order_detail_id, order_id, pizza_id, quantity).  
- `pizzas`: Contains pizza information (pizza_id, pizza_type_id, size, price).  
- `pizza_types`: Contains pizza type info (pizza_type_id, name, category).  
- `customers`: Contains customer info (custId, first_name, last_name).

---

## Data Cleaning & Exploration

- Verify total records in each table.  
- Check for null or missing values in critical columns.  
- Remove incomplete or inconsistent records.

---
## Key Findings

- **Customer Behavior**: High-value and repeat customers identified.  
- **Order Trends**: Peak hours, weekends, and seasonal patterns discovered.  
- **Menu Insights**: Top-selling pizzas, revenue contributors, and popular sizes identified.  
- **Revenue Analysis**: Monthly revenue, cumulative trends, and category-wise contributions analyzed.  
- **Operational Insights**: Average order size, daily pizzas, and staffing optimization recommendations provided.

