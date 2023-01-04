select * 
from bookings.flights
where  scheduled_arrival < scheduled_departure
    or actual_arrival < actual_departure