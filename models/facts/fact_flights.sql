with flights as (
select * from {{ ref('dim_flights') }}
  )
select *, 
 case when flight_duration > flight_duration_expected then 'longer' 
    when flight_duration < flight_duration_expected then 'shorter' 
    else 'expected' end as flight_duration_desc
from flights
where 1=1
{% if is_incremental() %}
    and dbt_time > (select max(dbt_time) from {{ this }})
{% endif%}