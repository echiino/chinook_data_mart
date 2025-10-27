# DS-2002 Midterm Project - Chinook Data Mart

## About Chinook

The Chinook data model represents a digital media store. It includes tables for artists, albums, media tracks, invoices, and customers.

https://github.com/lerocha/chinook-database

## Project Overview
This project builds a small data mart using data from:
- MySQL database `chinook_mysql.sql`
- MongoDB JSON file `chinook_customer.json`
- CSV file `chinook_mediatype.csv`

The mart is loaded into MySQL (`chinook_dw`) and includes:
- dim_customer
- dim_track
- fact_sales

## ETL Pipeline

### Extract:

Data was extracted from three different sources to satisfy project requirements:

- **Relational Database (MySQL):**  
  I extracted data from the Chinook database tables:  
  `track`, `album`, `artist`, `genre`, `invoice`, and `invoiceline`.
  
- **NoSQL Database (MongoDB):**  
  I imported a JSON file (`chinook_customer.json`) into a MongoDB collection and queried it into a Pandas DataFrame using `pymongo`.

- **File System (CSV):**  
  I imported `chinook_mediatype.csv` from the local file system using `pandas.read_csv()`.

---

### Transform:

- Cleaned and renamed columns for clarity and consistency.  
- Merged `track`, `album`, `artist`, `genre`, and `mediatype` into a unified dimension table: **`dim_track`**.  
- Created incremental surrogate keys (`customer_key`, `track_key`) for each dimension table
- Combined `invoice` and `invoiceline` into a fact table: **`fact_sales`**.  
- Joined fact and dimension tables using foreign keys:  
  - `customer_key` → `dim_customer`  
  - `track_key` → `dim_track`  
  - `date_key` → `dim_date`
- Converted date columns (e.g., `InvoiceDate`) to the `datetime64[ns]` format to align with the `dim_date` table.

---

### Load:

- Created a new MySQL data mart called **`chinook_dw`**.  
- Loaded the transformed DataFrames into the database using `SQLAlchemy` and the custom helper function `set_dataframe()`.  
- Each dimension and fact table was defined with a primary key:
  - `dim_date (date_key)`
  - `dim_customer (customer_key)`
  - `dim_track (track_key)`
  - `fact_sales (fact_sale_key)`
- Verified data integrity by running test queries in MySQL to ensure correct joins and aggregate results.

---

### Deployment Strategy:

- The ETL pipeline is implemented in a Jupyter Notebook: **`chinook_ETL.ipynb`**.  
- Running the notebook end-to-end will recreate the data mart.
  - However, make sure to execute the included SQL script **`populate_dim_date.sql`** when prompted so you can successfully generate `dim_date`!  
- Required dependencies:
  - `pandas`
  - `sqlalchemy`
  - `pymysql`
  - `pymongo`
- MongoDB can run locally or via a hosted instance (e.g., MongoDB Atlas).
  - Make sure to change the username, password, cluster name, cluster subnet, and cluster location to your own. By default, they are configured to mine.
- MySQL must be running and accessible at the configured host.
  - Make sure the username and password are your own! By default, they are configured to mine.  

## Instructions

### 1. Clone this repo
```bash
git clone https://github.com/echiino/chinook_data_mart.git
cd chinook_data_mart
```

### 2. Execute **`chinook_mysql.sql`** (found in the data folder) in MySQL to create the chinook database.

### 3. Before running the notebook, update the following connection parameters:

```python
# MySQL connection settings
host_name = "localhost"
port = "3306"
uid = "your_mysql_username"
pwd = "your_mysql_password"

# MongoDB connection settings
mongodb_args = {
    "user_name" : "your_mongodb_username",
    "password" : "your_mongodb_password",
    "cluster_name" : "your_cluster_name",
    "cluster_subnet" : "your_cluster_subnet",
    "cluster_location" : "atlas",  # or "local" if running MongoDB locally
    "db_name" : "chinook_customer"
}
```

### 4. Run the **`chinook_ETL.ipynb`** notebook and **`populate_dim_date.sql`** script.

### 5. Verify data integrity by executing **`chinook_queries.sql`**.
