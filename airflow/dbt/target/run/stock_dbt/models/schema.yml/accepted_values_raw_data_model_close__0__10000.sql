select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

with all_values as (

    select
        close as value_field,
        count(*) as n_records

    from DEV.raw_data.raw_data_model
    group by close

)

select *
from all_values
where value_field not in (
    '0','10000'
)



      
    ) dbt_internal_test