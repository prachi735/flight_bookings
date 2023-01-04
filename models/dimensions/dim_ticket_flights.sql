select
    concat(ticket_no,'-',flight_id) as tf_id,
    ticket_no, 
    flight_id, 
    fare_conditions, 
    amount
from {{ source('bookings_data','ticket_flights') }}
