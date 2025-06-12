# 🏡 Airbnb Listings SQL Project

This project involves cleaning an Airbnb listings dataset using **Pandas**, loading the cleaned data into **SQL**, and drawing data-driven insights using **SQL queries**.

---

## 📁 Folder Structure

airbnb_listings_sql_project/
├── data/
│   ├── listings_raw.csv.gz              # Original uploaded file
│   └── listings_cleaned.csv             # Cleaned output from pandas
├── notebooks/
│   └── 01_clean_data.ipynb              # Pandas cleaning & export
│   └── 02_load_to_sql.ipynb             # Loading into SQLite or other RDBMS
│   └── 03_sql_analysis.ipynb            # SQL insights
├── sql/
│   └── insights_queries.sql             # SQL queries for analysis
├── output/
│   └── listings.sqlite                  # SQLite database file (optional)
│   └── insights_report.csv              # (Optional) Export of final insights
├── README.md                            # Project description and instructions

