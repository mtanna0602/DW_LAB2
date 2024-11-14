
    
    

with all_values as (

    select
        moving_average_50 as value_field,
        count(*) as n_records

    from DEV.raw_data.transformations
    group by moving_average_50

)

select *
from all_values
where value_field not in (
    '0','10000'
)


