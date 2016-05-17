--Sometimes customers send their cust provided goods in without a proper identification, so we don't know what order it might belong to.
select o.id, j.jobname
from orderview o
inner join job j on j.OrderId = o.id
inner join JobProduct jp on jp.JobId = j.id
inner join Customer c on c.id = o.CustomerId
inner join Institution i on i.id = c.InstitutionId
where i.AffiliateId = 3 --dyenomite
and j.IsInventoryPulled = 0
and j.IsReadyToShip = 0
and j.IsCanceled = 0
and j.IsShipped = 0
and jp.IsCustomerSupplied = 1
and o.OrderType in(4,8) --order, fix order
order by o.id asc