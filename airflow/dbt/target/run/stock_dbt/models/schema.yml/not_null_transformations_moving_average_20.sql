select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select moving_average_20
from dev.raw_data.transformations
where moving_average_20 is null



      
    ) dbt_internal_test