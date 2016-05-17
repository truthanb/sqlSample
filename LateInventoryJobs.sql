declare @today date = getdate();

select o.Id as [Order], j.JobName as [Job], e.Username as [User], j.JobType [Type], convert(varchar(8),j.InventoryToArriveDate, 1) as [InventoryExpectedDate],
  convert(varchar(8),o.orderduetoshipdate, 1) as [DueDate], c.name as Customer
from job j
	inner join orderview o on o.Id = j.orderId
	inner join Employee e on e.Id = o.FinalizedById
	inner join customer c on c.id = o.CustomerId
	inner join institution i on i.id = c.InstitutionId
where o.OrderType in(4, 8) --order, fix order	
	and j.InventoryToArriveDate < @today
	and j.IsInventoryPulled = 0
	and j.IsReadyToShip = 0
	and j.IsDropShip = 0
	and j.IsCanceled = 0
	and j.IsBackOrdered = 0
	and j.InventoryToArriveDate is not null
	and i.AffiliateId = 1
order by e.Username