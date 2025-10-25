# DS-2002 Midterm Project - Chinook Data Mart

## Overview
This project builds a small data mart using data from:
- MySQL database `chinook`
- MongoDB JSON file `chinook_customer.json`
- CSV file `mediatype.csv`

The mart is loaded into MySQL (`chinook_dw`) and includes:
- dim_customer
- dim_track
- fact_sales

## Setup Instructions

### 1. Clone this repo
```bash
git clone https://github.com/echiino/chinook_data_mart.git
cd chinook_data_mart
