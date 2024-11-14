
    
    

select
    symbol as unique_field,
    count(*) as n_records

from DEV.raw_data.raw_data_model
where symbol is not null
group by symbol
having count(*) > 1


