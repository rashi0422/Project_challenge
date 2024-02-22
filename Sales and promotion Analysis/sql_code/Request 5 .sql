## 5. Create a report featuring the top 5 products, ranked by incremental revenue percentage(IR%), across all campaign

  with after_rev as (
    select product_code,
    SUM(base_price * `quantity_sold(after_promo)`) AS 'after_rev'
    from fact_events
    group by product_code
),
before_rev as (
select product_code,
    SUM(base_price * `quantity_sold(before_promo)`) AS 'before_rev'
    from fact_events
    group by product_code
)
select product_name,category,
round(((after_rev - before_rev)/before_rev)*100,0) as 'Incremental_revenue'
from after_rev ar
join before_rev br 
on ar.product_code = br.product_code
join dim_products d
on d.product_code = br.product_code
group by product_name
order by Incremental_revenue desc
limit 5;
