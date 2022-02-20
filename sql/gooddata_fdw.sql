create server multicorn_gooddata foreign data wrapper multicorn
  options (
    wrapper 'gooddata_fdw.GoodDataForeignDataWrapper',
    host 'http://gooddata-cn-ce:3000', -- host equal to name of container with GoodData.CN.CE
    token 'YWRtaW46Ym9vdHN0cmFwOmFkbWluMTIz', -- default gooddata-cn-ce token, documented in public DOC as well
    headers_host 'localhost'
  );
 
create schema "olympics";

call import_gooddata('olympics', 'all'); 

create foreign table athletes_by_sport (
	sport_name varchar options (id 'label/sport_name'),
    athletes_count  NUMERIC(18,0) options (id 'metric/athletes')
)
SERVER multicorn_gooddata
OPTIONS ( workspace 'olympics');

select * from athletes_by_sport;

select games_name, athletes from olympics.compute;
