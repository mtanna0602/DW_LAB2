select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select date
from DEV.raw_data.raw_data_model
where date is null



      
    ) dbt_internal_test