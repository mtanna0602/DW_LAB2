select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select min_value
from DEV.raw_data.raw_data_model
where min_value is null



      
    ) dbt_internal_test