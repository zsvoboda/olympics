with distinct_athlete as (
    select distinct 
            "ID"::integer                   as athlete_original_id,
            "Name"::varchar(120)            as athlete_name
        from "olympics_stage"."athlete_events"
)           
select 
        row_number() over (order by "athlete_name" asc)   as athlete_id,
        athlete_original_id,
        athlete_name
    from distinct_athlete
    