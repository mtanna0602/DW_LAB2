
    
    

with all_values as (

    select
        min_value as value_field,
        count(*) as n_records

    from DEV.raw_data.raw_data_model
    group by min_value

)

select *
from all_values
where value_field not in (
    '0','10000'
)


