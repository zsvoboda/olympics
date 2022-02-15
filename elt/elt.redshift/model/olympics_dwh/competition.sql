with competitions_distinct as (
	select 
			a.athlete_id					as athlete_id,
			n.noc_id						as noc_id,
			m.medal_id						as medal_id,
			s.sport_id						as sport_id,
			e.event_id						as event_id,
			g.games_id						as games_id,
			t.team_id						as team_id,
			ae."Sex"::char(1) 				as competition_athlete_sex,
			lpad(ae."Age"::char(3),3,'0') 	as competition_athlete_age,
			ae."Age"::decimal(3,0) 			as competition_athlete_age_fact,
			ae."Height"::decimal(13,2) 		as competition_athlete_height,
			ae."Weight"::decimal(13,2) 		as competition_athlete_weight		
		from "olympics_stage"."athlete_events" ae  
		join "olympics_dwh"."athlete" a on a."athlete_original_id" = ae."ID"
		join "olympics_dwh"."noc" n on n."noc_code" = ae."NOC"
		join "olympics_dwh"."medal" m on m."medal_name" = coalesce("Medal", 'None')
		join "olympics_dwh"."sport" s on s."sport_name" = ae."Sport"
		join "olympics_dwh"."event" e on e."event_name" = ae."Event"
		join "olympics_dwh"."team" t on t."team_name" = ae."Team"
		join "olympics_dwh"."games" g on g."games_name" = ae."Games" 
			and g."games_year"::integer = ae."Year" 
			and g."games_city" = ae."City" 
			and g."games_season" = ae."Season"
)
select 
        row_number() over (order by "athlete_id" asc)   as competition_id,
		athlete_id,
		noc_id,
		medal_id,
		sport_id,
		event_id,
		games_id,
		team_id,
		competition_athlete_sex,
		competition_athlete_age,
		competition_athlete_age_fact,
		competition_athlete_height,
		competition_athlete_weight
	from competitions_distinct