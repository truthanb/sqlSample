--Find the number of products with a given string in the description (ie: poly, cotton, etc.) which had a screen print service applied to them.
select sum(jp.ProductQuantity)
from jobProduct jp
inner join job j on j.Id = jp.JobId
inner join jobService js on js.JobId = j.Id
inner join orderView o on o.Id = j.OrderId
inner join serviceView s on s.Id = js.ServiceId
inner join productColor pc on pc.Id = jp.ProductColorId
inner join product p on p.Id = pc.ProductId
where o.OrderType in(4,8) --4: Order, 8: Fix Order
and s.ServiceType = 64 --64: Screen Printing
and p.[Description] like '%poly%'
and j.IsCanceled = 0 --False
and o.IsCanceled = 0 --False
and o.DateLastJobShipped > DATEADD(year, -1, getdate())


--Find the screen services quantity involving a productwith a given string in the description (ie: poly, cotton, etc.)
select sum(js.Quantity)
from jobProduct jp
inner join job j on j.Id = jp.JobId
inner join jobService js on js.JobId = j.Id
inner join orderView o on o.Id = j.OrderId
inner join serviceView s on s.Id = js.ServiceId
inner join productColor pc on pc.Id = jp.ProductColorId
inner join product p on p.Id = pc.ProductId
where o.OrderType in(4,8) --4: Order, 8: Fix Order
and s.ServiceType = 64 --64: Screen Printing
and p.[Description] like '%poly%'
and j.IsCanceled = 0 --False
and o.IsCanceled = 0 --False
and o.DateLastJobShipped > DATEADD(year, -1, getdate())