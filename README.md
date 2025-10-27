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

## Setup Instructions

### 1. Clone this repo
```bash
git clone https://github.com/echiino/chinook_data_mart.git
cd chinook_data_mart
