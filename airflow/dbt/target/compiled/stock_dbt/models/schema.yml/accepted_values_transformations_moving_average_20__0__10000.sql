
    
    

with all_values as (

    select
        moving_average_20 as value_field,
        count(*) as n_records

    from DEV.raw_data.transformations
    group by moving_average_20

)

select *
from all_values
where value_field not in (
    '0','10000'
)


