Declare @date1 datetime
set @date1 = '1/1/2014 00:00:01';
Declare @date2 datetime
set @date2 = '1/1/2015 23:59:59';

with cte_productsales(productId, sales)
as
	(
		select p.ProductNumber as productId, sum(jp.SubtotalPrice) as sales
		from Product p
		inner join ProductColor pc on pc.ProductId = p.id
		inner join JobProduct jp on jp.ProductColorId = pc.id
		inner join Job j on j.id = jp.JobId
		inner join [Order] o on o.id = j.OrderId
		where jp.CreatedDate between @date1 and @date2 and
		p.affiliateId = 1 and
		o.OrderType = 4
		group by p.ProductNumber
	)

select p.ProductNumber, p.RecommendationScore, a.sales as [gross sales], p.CreatedDate, p.CreatedById
from Product p
inner join cte_productsales a on a.productId = p.ProductNumber
where p.IsEnabled = 1
and p.IsWebVisible = 1
order by a.sales desc