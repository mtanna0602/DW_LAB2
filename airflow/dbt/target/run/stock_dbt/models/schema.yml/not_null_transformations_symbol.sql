select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select symbol
from dev.raw_data.transformations
where symbol is null



      
    ) dbt_internal_test