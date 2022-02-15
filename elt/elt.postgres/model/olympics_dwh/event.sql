with distinct_events as (
	select distinct 
			"Event"::varchar(100) as event_name
		from "olympics_stage"."athlete_events"
)
select 
	    row_number() over (order by "event_name" asc) as event_id,
	    event_name 
    from distinct_events