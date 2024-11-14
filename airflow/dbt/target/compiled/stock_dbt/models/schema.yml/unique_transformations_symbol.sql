
    
    

select
    symbol as unique_field,
    count(*) as n_records

from DEV.raw_data.transformations
where symbol is not null
group by symbol
having count(*) > 1


