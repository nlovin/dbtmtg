{{ config(materialized='table') }}

select 
	name, 
	set_name, 
	set_type,
	to_timestamp(date*86400)::date as price_date, 
	(to_date(date_released, 'YYYY-MM-DD')+INTERVAL '60 days')::date as rel_60, 
	date_released::date,
	phn.price, 
	phn.setcard_id 
from cards c
join price_history_new phn 
	on c.card_id = phn.card_id 
where rarity = 'rare'
and (to_date(date_released, 'YYYY-MM-DD')+INTERVAL '60 days')::date > to_timestamp(date*86400)::date
and to_timestamp(date*86400)::date > date_released::date