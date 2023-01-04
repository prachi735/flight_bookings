with aircrafts as (
    select aircraft_code,
        model::json->> '{{ var('name_lang') }}' AS model,
        range
        ,case when "range" > 5600 then 'high' else 'low'end as range_category
    from {{ source('bookings_data', 'aircrafts_data') }}
  ),
  seats as (
    select aircraft_code, seat_no, fare_conditions 
    from {{source('bookings_data','seats')}}
  )
select concat(a.aircraft_code,s.seat_no) as aircraft_seat_key,
    a.aircraft_code,
    a.model,
    a.range,
    a.range_category,
    s.seat_no,
    s.fare_conditions
from aircrafts a
join seats s on a.aircraft_code = s.aircraft_code 