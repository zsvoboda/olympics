with distinct_nocs as (
    select distinct 
            "NOC"::char(3)          as noc_code,
            "region"::varchar(20)   as noc_name,
            "notes"::varchar(50)    as noc_notes
        from "olympics_stage"."noc_regions"
)
select 
        row_number() over (order by "noc_name" asc)          as noc_id,
        noc_code,
        noc_name,
        noc_notes
    from distinct_nocs