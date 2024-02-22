## 1. provide a list of product with base price greater than 500 and that are featured in promo type of 'BOGOF';

select product_code , base_price
from fact_events
where promo_type = 'BOGOF' and base_price > 500;

