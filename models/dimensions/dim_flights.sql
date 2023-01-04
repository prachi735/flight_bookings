{{ config(materialized='ephemeral') }}

select flight_id
    ,flight_no
    ,scheduled_departure
    ,scheduled_arrival
    ,departure_airport
    ,arrival_airport
    ,status
    ,aircraft_code
    ,actual_departure
    ,actual_arrival
    ,scheduled_departure - scheduled_arrival as flight_duration_expected
    ,actual_departure - actual_arrival as flight_duration
    ,'{{ run_started_at.strftime("%Y-%m-%d %H:%M:%S")}}' as dbt_time
from {{ source('bookings_data', 'flights_v') }}