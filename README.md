#NAMES & ID : 
    1) IRAKOZE NSUMBA Herve 28028
    2) Ushindi Bihame victoire 27269
    3) Muhirwa Kirenga Remy 28368

# QUESTION 1: University System Policy Enforcement Using PL/SQL Triggers

## Project Overview

This project demonstrates how to implement **university system policies** using **PL/SQL triggers** in an Oracle Database.  
The main goal is to enforce **access restrictions** based on days and working hours and to **log violations** for auditing purposes.

---

## Business Rules Implemented

1. Users **cannot access or record data** on the **Sabbath (Saturday and Sunday)**.  
2. Users can access the system **Monday to Friday, from 08:00 AM to 05:00 PM**.  
3. Any attempts outside the allowed days or hours should be **blocked and logged automatically**.

---

## Database Setup

### 1. Local User Creation
### 2. Tables
### 3. Triggers

How It Works

--Trigger 1 enforces real-time access restrictions.

--Trigger 2 records all violations for auditing.

--The access_violation_log table stores:
        -Username
        -Action type (INSERT/UPDATE/DELETE)
        -Table affected
        -Timestamp
        -Error message
        -This ensures policy enforcement and auditability.


# QUESTION 2 :🚀 HR Employee Management System – PL/SQL Package

A PL/SQL package designed to manage employee salaries, calculate RSSB tax, execute dynamic SQL operations, and demonstrate Oracle security context (`USER`, `CURRENT_USER`, Definer Rights).

---

## 📌 Project Overview

This package implements core features required for an HR Employee Management System:

- RSSB tax calculation  
- Net salary computation  
- Dynamic SQL operations  
- Security context demonstration  
- Sample execution calls  

The goal is to provide a clean, modular, and secure PL/SQL solution.

---

## 🧠 Approach & Design

The problem was solved by breaking it into four main tasks:

1. **Create a function** to calculate RSSB tax and return net salary.  
2. **Implement a dynamic procedure** using `EXECUTE IMMEDIATE`.  
3. **Demonstrate security behavior** using `USER` and `CURRENT_USER`.  
4. **Prepare sample calls** to test all features.

Everything is wrapped inside one PL/SQL package (`hr_salary_pkg`).

---

## 🧩 Package Features

### ✔ 1. Net Salary Function (`calc_net_salary`)
- Retrieves employee salary.  
- Applies **5% RSSB tax** (constant inside package).  
- Returns **net salary**.  
- Prints `USER` and `CURRENT_USER` for security context demo.

---

### ✔ 2. Dynamic SQL Procedure (`dynamic_operation`)
- Accepts any SQL statement as a string.  
- Executes it.
EXECUTE IMMEDIATE

AUTHORS COMMENTS:
IRAKOZE NSUMBA Herve 28028: "I carefully reviewed the business rules and understood how triggers enforce access and logging policies. I then implemented separate triggers for blocking unauthorized access and recording violations, testing them to ensure the system works as required."



