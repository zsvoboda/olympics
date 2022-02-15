with distinct_games as (
    select distinct 
            "Games"::varchar(20)    as games_name,
	        "Year"::char(4)         as games_year,
	        "Season"::varchar(10)   as games_season,
	        "City"::varchar(50)     as games_city
        from "olympics_stage"."athlete_events"
)
select 
	    row_number() over (order by "games_name" asc)  as games_id,
	    games_name,
	    games_year,
	    games_season,
	    games_city
    from distinct_games