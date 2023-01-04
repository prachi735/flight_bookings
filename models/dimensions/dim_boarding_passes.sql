select 
    concat(ticket_no,'-',flight_id) as bp_id,
    ticket_no, 
    flight_id, 
    boarding_no, 
    seat_no,
    '{{ run_started_at.strftime("%Y-%m-%d %H:%M:%S")}}'::timestamp as dbt_time
from {{ source('bookings_data', 'boarding_passes') }}
