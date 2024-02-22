## 3. generate a report that displays each campaign along with total revenue generated before campaign and after campaign.

select campaign_name ,
concat(round(sum(f.base_price * f.`quantity_sold(before_promo)`)/1000000,1), 'M') as 'total_revenue(before_promo)',
concat(round(sum(f.base_price * f.`quantity_sold(after_promo)`)/1000000,1), ' M') as 'total_revenue(after_promo)'
from fact_events f
join dim_campaigns d
on f.campaign_id = d.campaign_id
group by f.campaign_id;
