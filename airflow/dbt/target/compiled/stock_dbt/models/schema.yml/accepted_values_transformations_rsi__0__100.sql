
    
    

with all_values as (

    select
        rsi as value_field,
        count(*) as n_records

    from DEV.raw_data.transformations
    group by rsi

)

select *
from all_values
where value_field not in (
    '0','100'
)


