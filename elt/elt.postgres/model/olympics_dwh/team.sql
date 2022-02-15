with distinct_teams as (
	select distinct 
			"Team"::varchar(50) as team_name
		from "olympics_stage"."athlete_events"
)
select 
	    row_number() over (order by "team_name" asc) as team_id,
	    team_name 
    from distinct_teams