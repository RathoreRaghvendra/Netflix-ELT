# 🎬 Netflix ELT Project (SQL + Python)

This project demonstrates an **end-to-end ELT (Extract, Load, Transform)** pipeline on the **Netflix dataset** using **Python** and **PostgreSQL**. The dataset is cleaned, structured, and analyzed to extract meaningful insights using **SQL**.

---

## 📂 Folder Structure

netflix-elt-sql-python/
│
├── netflix_titles.csv # Raw Netflix dataset
├── netflix_data_extract.py # Python script to load data into PostgreSQL
├── netflix_raw.sql # SQL queries for cleaning and transforming data
├── netflix_table_creation.sql # SQL script to create the initial table
├── netflix_data_analysis.sql # Analytical SQL queries for insights
└── README.md # Project documentation

---

## 🧰 Tech Stack

- **Language:** Python, SQL
- **Database:** PostgreSQL
- **Libraries:** `pandas`, `sqlalchemy`, `psycopg2`

---

## 📥 1. Extract & Load

**File:** `netflix_data_extract.py`

- Reads the `netflix_titles.csv` dataset using pandas.
- Connects to a local PostgreSQL database using SQLAlchemy.
- Loads the raw dataset into a table named `netflix_raw`.

```bash
pip install pandas sqlalchemy psycopg2-binary

🧼 2. Data Cleaning & Transformation
File: netflix_raw.sql

Key tasks:

Removed duplicates using ROW_NUMBER() and CTEs.

Handled missing values in country and duration using related tables.

Extracted and normalized multi-valued fields (like director, country, cast, listed_in) into separate tables:

netflix_directors

netflix_country

netflix_cast

netflix_genre

Converted date_added to proper date type and standardized duration.

Final cleaned table: netflix
Columns: show_id, type, title, date_added, release_year, rating, duration, description

📊 3. Data Analysis
File: netflix_data_analysis.sql

🚀 Getting Started
1. Clone the repo:
git clone https://github.com/your-username/netflix-elt-sql-python.git

2. Set up PostgreSQL:

Create database: Netflix_Analytics

Run netflix_table_creation.sql

3. Run Python script:
python netflix_data_extract.py

4. Run SQL scripts in order:

netflix_raw.sql

netflix_data_analysis.sql

🙌 Acknowledgements
Netflix dataset from Kaggle

PostgreSQL for relational transformations

SQLAlchemy & pandas for Python integration


