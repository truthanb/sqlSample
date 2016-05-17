declare @yesterday date = '4/29/2015'--dateadd(day, -1, getdate())
declare @twoDaysAgo date = '1/1/2015'--dateadd(day, -2, getdate())


--This shows how many products from each product group shipped for a given time period, by job shipped date, for specific brands involved.
select pg.Name, sum(jp.ProductQuantity) Qty
from productgroup pg
inner join product p on p.ProductGroupId = pg.id
inner join ProductColor pc on pc.ProductId = p.id
inner join jobProduct jp on jp.ProductColorId = pc.Id
inner join job j on j.Id = jp.JobId
inner join orderview o on o.Id = j.OrderId
inner join customer c on c.Id = o.CustomerId
inner join institution i on i.id = c.InstitutionId
inner join affiliate a on a.id = i.AffiliateId
where o.OrderType = 4 
	and a.Id = 3
	and j.IsShipped = 1
	and p.BrandId in(12, 13, 54, 89, 94, 102, 244, 316)
	and j.ShipDate between @twoDaysAgo and @yesterday
group by pg.Name