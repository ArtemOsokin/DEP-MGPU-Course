-- Динамика  дохода и прибыли
select  
    extract (YEAR from order_date) as Year,
    extract(MONTH from order_date) as Month,
    sum(sales) as total_sales,
    sum(profit) as total_profit
from 
    orders o
group by 
    Year, Month
order by 
    Year, Month;

-- Доля продаж по категориям
select
	category, 
	round((sum(sales) * 100.0) / (select sum(sales) from orders), 2) as category_percent
from
	orders o
group by
	category

-- Месячные продажи по сегментам
select  
    extract(MONTH from order_date) as Month,
    segment,
    round(sum(sales), 2)
from 
    orders o
group by 
    Month, segment
order by 
    Month;

-- Продажи по регионам
select
	region,
	round(sum(sales), 2)
from
	orders o 
group by
	region
	
-- Возвраты по менеджерам
select
	p.person as person,
	case when r.returned is not null then r.returned else 'No' end as returned,
	count(p.person)
from
	people p
join
	orders o on o.region = p.region
left join
	 (select distinct * from "returns") r  on r.order_id = o.order_id
group by 
	person,
	returned
order by
	person

-- Доли по доставке
select
	o.ship_mode,
	round((count(o.ship_mode) * 100.0) / (select count(*) from orders), 2) as ship_percent
from
	orders o
group by
	o.ship_mode


	