with airports as (
    select airport_code,
        airport_name::json->> '{{ var('name_lang') }}' AS airport_name,
        city,
        coordinates,
        timezone
    from {{ source('bookings_data', 'airports_data') }}
  )
select * 
from airports