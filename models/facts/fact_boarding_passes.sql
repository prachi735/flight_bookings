

with ticket_flights as (
    select tf_id,ticket_no, flight_id, fare_conditions, amount
    from {{ ref('dim_ticket_flights') }}
  ),
  boarding_passes as (
    select bp_id,ticket_no, flight_id, boarding_no, seat_no
        ,dbt_time
    from {{ ref('dim_boarding_passes') }}
  )
select 
    concat(tf_id,'-',bp_id,'-',seat_no) as pass_key
    ,t.ticket_no, t.flight_id, t.fare_conditions, t.amount, 
    b.boarding_no, b.seat_no, b.dbt_time
from boarding_passes b
join ticket_flights t on b.ticket_no = t.ticket_no and b.flight_id = t.flight_id
where 1=1
{% if is_incremental() %}
    and dbt_time > (select max(dbt_time) from {{ this }})
{% endif%}