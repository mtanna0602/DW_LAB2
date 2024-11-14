
    
    

with all_values as (

    select
        volume as value_field,
        count(*) as n_records

    from DEV.raw_data.raw_data_model
    group by volume

)

select *
from all_values
where value_field not in (
    '0','1000000000'
)


