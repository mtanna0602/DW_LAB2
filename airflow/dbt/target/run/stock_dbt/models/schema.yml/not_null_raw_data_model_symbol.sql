select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select symbol
from DEV.raw_data.raw_data_model
where symbol is null



      
    ) dbt_internal_test