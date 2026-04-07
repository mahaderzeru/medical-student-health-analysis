# Medical Student Health Risk Analysis
**Tools:** MySQL · Power BI · Excel  
**Dataset:** 200,000 rows · 13 columns · Simulated medical student health records

---

## 📌 Project Overview

This project analyzes health risk factors across a large medical student population to identify trends in chronic condition prevalence, cardiovascular risk, and demographic health profiles. The workflow mirrors real-world responsibilities in medical education data analysis including data cleaning, SQL-based querying, and interactive dashboard reporting.

This project was designed to simulate the kind of assessment and program evaluation work performed in academic medical settings, including data integrity validation and stakeholder-ready reporting.

---

## 🗂️ Dataset

The dataset contains 200,000 simulated medical student health records with the following fields:

| Column | Description |
|---|---|
| Student ID | Unique student identifier |
| Age | Student age (18–34) |
| Gender | Male / Female |
| Height | Height in cm |
| Weight | Weight in kg |
| Blood Type | A, B, AB, O |
| BMI | Body Mass Index |
| Temperature | Body temperature (°F) |
| Heart Rate | Beats per minute |
| Blood Pressure | Systolic blood pressure (mmHg) |
| Cholesterol | Cholesterol level (mg/dL) |
| Diabetes | Yes / No |
| Smoking | Yes / No |

**Source:** [Medical Students Dataset – Kaggle](https://www.kaggle.com/datasets/slmsshk/medical-students-dataset)

---

## 🧹 Data Cleaning

Before analysis, the following data quality issues were identified and resolved in MySQL:

| Issue | Details | Resolution |
|---|---|---|
| Duplicate records | 101,023 duplicate student IDs identified | Deduplicated using MIN(student_id) grouping |
| Missing values | Rows missing Student ID, Age, or Gender | Removed prior to analysis |
| Data type mismatches | All columns imported as VARCHAR | Converted to INT/FLOAT after null handling |
| **Final clean dataset** | **138,364 records** | Validated before analysis |

---

## 🔍 SQL Analysis

Six analytical queries were developed to surface health risk insights across the student population:

1. **Health metrics by gender** — Average BMI, cholesterol, and heart rate by gender
2. **Diabetes prevalence by age group** — Diabetes rate tracked across ages 18–34
3. **Smoking and cardiovascular risk** — Blood pressure, cholesterol, and heart rate by smoking status
4. **High-risk student identification** — Students flagged with BMI > 30, cholesterol > 220, or blood pressure > 130
5. **Blood type distribution** — Population breakdown by blood type
6. **Health profile by diabetes status** — Average BMI, cholesterol, and blood pressure for diabetic vs. non-diabetic students

📄 See [`analysis_queries.sql`](./analysis_queries.sql) for full query code.

---

## 📊 Power BI Dashboard

The interactive dashboard includes:

- **KPI Card** — High-risk student rate (% of total population)
- **Clustered Bar Chart** — Average health metrics (BMI, cholesterol, heart rate) by gender
- **Column Chart** — Diabetes prevalence rate by age group
- **Grouped Bar Chart** — Cardiovascular risk indicators by smoking status
- **Gender Slicer** — Dynamic filter applied across all visuals

![Dashboard Preview](./dashboard_preview.pdf)

🔗 [View Interactive Dashboard](https://app.powerbi.com/groups/me/reports/0f03bc13-0538-416f-ac2c-09a4673fd0d3/edc3405c44c14c3d8096?experience=power-bi)

---

## 💡 Key Findings


- 44.66% of students met at least one high-risk threshold (BMI > 30, cholesterol > 200, or blood pressure > 140
- Diabetes prevalence ranged from 8.4% to 10.0% across age groups, with age 32 showing the highest rate at 10.04%
- Smokers and non-smokers showed nearly identical cardiovascular averages, suggesting lifestyle factors alone may not drive risk in this simulated population
- Blood type distribution was approximately equal across A, AB, B, and O groups (~25% each)
- Health metrics (BMI, cholesterol, heart rate) were nearly identical between male and female students

Note: This is synthetic data. Findings like almost identical cardiovascular health between smokers and non-smokers show that the dataset is not in line with real-world clinical patterns.
---

## 🛠️ Tools Used

- **MySQL Workbench** — Data import, cleaning, and querying
- **Power BI Desktop** — Dashboard development and visualization
- **Microsoft Excel** — Initial data inspection and backup

---

## 👤 Author

**Mahader Zeru**  
BS, Data Science · MBA Candidate, Data Analytics — Indiana Wesleyan University  
[LinkedIn](https://linkedin.com/in/mahaderzeru) · [GitHub](https://github.com/mahaderzeru)
