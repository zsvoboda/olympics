with distinct_medals as (
	select distinct 
			coalesce("Medal"::varchar(10), 'None') as medal_name
		from "olympics_stage"."athlete_events"
)
select 
	    row_number() over (order by "medal_name" asc) as medal_id,
	    medal_name 
    from distinct_medals