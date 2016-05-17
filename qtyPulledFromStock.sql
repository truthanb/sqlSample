--Should find how many stock pieces were pulled, grouped by order. 
Declare @date1 datetime
set @date1 = '10/5/2015 00:00:01'; 
Declare @date2 datetime
set @date2 = '10/9/2015 23:59:59';

select distinct o.id, sum(it.Quantity)
from inventorytransaction it
inner join jobproductcolorsize jpcs on jpcs.id = it.JobProductColorSizeId
inner join JobProduct jp on jp.id = jpcs.JobProductId
inner join productcolor pc on pc.id = jp.ProductColorId
inner join job j on j.id = jp.JobId
inner join orderview o on o.id = j.orderid
inner join customer c on c.id = o.CustomerId
inner join Institution i on i.id = c.InstitutionId
where o.DateLastJobShipped between @date1 and @date2
and it.TransactionState = 4096 --picked
and o.ordertype = 4 --normal order
and i.AffiliateId = 3 --dyenomite
and it.IsReceived = 1 --received
and pc.StockType = 2 --permanent
group by o.id