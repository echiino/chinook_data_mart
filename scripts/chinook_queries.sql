USE chinook_dw;

-- QUERY 1: TOTAL SALES PER CUSTOMER
SELECT 
    c.FirstName AS first_name,
    c.LastName AS last_name,
    SUM(f.Quantity) AS total_quantity,
    SUM(f.Quantity * f.UnitPrice) AS total_sales
FROM chinook_dw.fact_sales f
JOIN chinook_dw.dim_customer c
    ON f.customer_key = c.customer_key
GROUP BY c.FirstName, c.LastName
ORDER BY total_sales DESC;


-- QUERY 2: TOTAL SALES PER TRACK (TOP SONGS)
SELECT 
    t.TrackName AS track_name,
    SUM(f.Quantity) AS total_quantity_sold,
    SUM(f.Quantity * f.UnitPrice) AS total_revenue
FROM chinook_dw.fact_sales f
JOIN chinook_dw.dim_track t
    ON f.track_key = t.track_key
GROUP BY t.TrackName
ORDER BY total_revenue DESC
LIMIT 10;

-- QUERY 3: SALES OVER TIME (BY MONTH)
SELECT 
    d.calendar_year,
    d.month_name,
    COUNT(f.Quantity) AS monthly_sales,
    SUM(f.Quantity * f.UnitPrice) AS monthly_revenue
FROM chinook_dw.fact_sales f
JOIN chinook_dw.dim_date d
    ON f.invoice_date_key = d.date_key
GROUP BY d.calendar_year, d.month_name
ORDER BY d.calendar_year, MIN(d.full_date);
