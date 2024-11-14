WITH source_data AS (
    SELECT 
        date,
        symbol,
        close,
        ROW_NUMBER() OVER (PARTITION BY symbol ORDER BY date) AS row_num
    FROM 
        dev.raw_data.raw_data_model  -- This refers to the raw data model created by dbt
),

-- Calculate 20-day moving average (MA)
ma_20 AS (
    SELECT
        date,
        symbol,
        close,
        AVG(close) OVER (PARTITION BY symbol ORDER BY date ROWS BETWEEN 19 PRECEDING AND CURRENT ROW) AS moving_average_20
    FROM source_data
),

-- Calculate 50-day moving average (MA)
ma_50 AS (
    SELECT
        date,
        symbol,
        close,
        AVG(close) OVER (PARTITION BY symbol ORDER BY date ROWS BETWEEN 49 PRECEDING AND CURRENT ROW) AS moving_average_50
    FROM source_data
),

-- Calculate the RSI (Relative Strength Index)
rsi_calc AS (
    SELECT 
        date,
        symbol,
        close,
        -- Calculate the gains and losses based on LAG()
        LAG(close) OVER (PARTITION BY symbol ORDER BY date) AS prev_close,
        CASE
            WHEN close > LAG(close) OVER (PARTITION BY symbol ORDER BY date) THEN close - LAG(close) OVER (PARTITION BY symbol ORDER BY date)
            ELSE 0
        END AS gain,
        CASE
            WHEN close < LAG(close) OVER (PARTITION BY symbol ORDER BY date) THEN LAG(close) OVER (PARTITION BY symbol ORDER BY date) - close
            ELSE 0
        END AS loss
    FROM source_data
),

-- Calculate the final RSI
rsi_final AS (
    SELECT
        date,
        symbol,
        -- Calculate average gains and losses
        AVG(gain) OVER (PARTITION BY symbol ORDER BY date ROWS BETWEEN 13 PRECEDING AND CURRENT ROW) AS avg_gain,
        AVG(loss) OVER (PARTITION BY symbol ORDER BY date ROWS BETWEEN 13 PRECEDING AND CURRENT ROW) AS avg_loss
    FROM rsi_calc
)

SELECT 
    s.date,
    s.symbol,
    ma_20.moving_average_20,
    ma_50.moving_average_50,
    -- Calculate RSI based on average gain and loss
    CASE
        WHEN avg_loss = 0 THEN 100
        ELSE 100 - (100 / (1 + (avg_gain / avg_loss)))
    END AS rsi
FROM source_data s
LEFT JOIN ma_20 ON s.date = ma_20.date AND s.symbol = ma_20.symbol
LEFT JOIN ma_50 ON s.date = ma_50.date AND s.symbol = ma_50.symbol
LEFT JOIN rsi_final ON s.date = rsi_final.date AND s.symbol = rsi_final.symbol