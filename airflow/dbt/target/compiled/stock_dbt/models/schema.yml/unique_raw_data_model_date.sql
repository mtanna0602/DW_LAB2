
    
    

select
    date as unique_field,
    count(*) as n_records

from DEV.raw_data.raw_data_model
where date is not null
group by date
having count(*) > 1


