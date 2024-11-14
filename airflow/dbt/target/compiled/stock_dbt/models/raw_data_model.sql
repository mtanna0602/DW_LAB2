-- raw_data_model.sql

WITH raw_data AS (
    SELECT
        date,
        symbol,
        open,
        max_value AS high,
        min_value AS low,
        close,
        volume
    FROM 
        DEV.raw_data.stock_data  -- Refers to the source defined in schema.yml
)

SELECT
    date,
    symbol,
    open,
    high,
    low,
    close,
    volume
FROM raw_data