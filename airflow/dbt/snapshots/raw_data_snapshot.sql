{% snapshot raw_data_snapshot %}

    {{
        config(
            target_database='dev', 
            target_schema='raw_data',
            unique_key='date', 
            strategy='timestamp',
            updated_at='date'                 
        )
    }}

    SELECT 
        date,
        symbol,
        open,
        max_value AS high,
        min_value AS low,
        close,
        volume
    FROM {{ source('raw_data', 'stock_data') }}

{% endsnapshot %}
