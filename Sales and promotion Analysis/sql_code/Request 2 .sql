## 2. generate a report that provides an overview of the number of stores in each city 

select city , count(store_id) as 'Total_stores' 
from dim_stores 
group by city 
order by Total_stores desc;
