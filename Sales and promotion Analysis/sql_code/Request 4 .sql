## 4. produce a report that calculates the incremental sold quantity (ISU%) for each category during diwali

SELECT category, ISU,
RANK() OVER (ORDER BY ISU DESC) AS category_rank
from(
     select p.category,
     concat(round((sum(`Quantity_sold`) - sum(`quantity_sold(before_promo)`))*100 / sum(`quantity_sold(before_promo)`),0), ' %')  as 'ISU'
     from fact_events f
     join dim_products p 
     on p.product_code = f.product_code
     where campaign_id = 'CAMP_DIW_01'
     group by category
     order by ISU desc
) AS category_ISU;
