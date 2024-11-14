
      begin;
    merge into "DEV"."RAW_DATA"."RAW_DATA_SNAPSHOT" as DBT_INTERNAL_DEST
    using "DEV"."RAW_DATA"."RAW_DATA_SNAPSHOT__dbt_tmp" as DBT_INTERNAL_SOURCE
    on DBT_INTERNAL_SOURCE.dbt_scd_id = DBT_INTERNAL_DEST.dbt_scd_id

    when matched
     
       and DBT_INTERNAL_DEST.dbt_valid_to is null
     
     and DBT_INTERNAL_SOURCE.dbt_change_type in ('update', 'delete')
        then update
        set dbt_valid_to = DBT_INTERNAL_SOURCE.dbt_valid_to

    when not matched
     and DBT_INTERNAL_SOURCE.dbt_change_type = 'insert'
        then insert ("DATE", "SYMBOL", "OPEN", "HIGH", "LOW", "CLOSE", "VOLUME", "DBT_UPDATED_AT", "DBT_VALID_FROM", "DBT_VALID_TO", "DBT_SCD_ID")
        values ("DATE", "SYMBOL", "OPEN", "HIGH", "LOW", "CLOSE", "VOLUME", "DBT_UPDATED_AT", "DBT_VALID_FROM", "DBT_VALID_TO", "DBT_SCD_ID")

;
    commit;
  