select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

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



      
    ) dbt_internal_test