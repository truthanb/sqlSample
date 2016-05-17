select o.id, o.OrderDueToShipDate, j.jobname, j.JobType
from job j
inner join orderview o on o.id = j.orderid
where j.IsInventoryPulled = 0 and j.InventoryToArriveDate = '3/27/2015'
order by o.OrderDueToShipDate desc