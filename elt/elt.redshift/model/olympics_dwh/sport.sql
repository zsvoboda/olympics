with distinct_sports as (
	select distinct 
			"Sport"::varchar(50) as sport_name
		from "olympics_stage"."athlete_events"
)
select 
	    row_number() over (order by "sport_name" asc) as sport_id,
	    sport_name 
    from distinct_sports