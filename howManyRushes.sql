-- This will find out how many orders were placed on shorter than 4 day rush in the past year. A subsequent query will find how many orders were placed in the same time, for comparison.
select count(o.id)
from orderview o
inner join customer c on c.id = o.CustomerId
inner join Institution i on i.id = c.InstitutionId
where DATEDIFF(day, o.FinalizedDate, o.OrderDueToShipDate) < 4
and o.FinalizedDate between DATEADD(year, -1, GETDATE()) and getdate()
and i.AffiliateId = 1
and o.IsCanceled = 0 
and o.OrderType in(4)

select count(o.id)
from orderview o
inner join customer c on c.id = o.CustomerId
inner join Institution i on i.id = c.InstitutionId
--where DATEDIFF(day, o.FinalizedDate, o.OrderDueToShipDate) < 4
and o.FinalizedDate between DATEADD(year, -1, GETDATE()) and getdate()
and i.AffiliateId = 1
and o.IsCanceled = 0 
and o.OrderType in(4)