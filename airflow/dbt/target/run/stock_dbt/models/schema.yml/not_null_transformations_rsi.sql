select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select rsi
from dev.raw_data.transformations
where rsi is null



      
    ) dbt_internal_test