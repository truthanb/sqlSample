select convert(date, js.CreatedDate) CreatedDate, count(*)
from JobService js
inner join job j on j.id = js.jobid
inner join orderview o on o.id = j.OrderId
inner join Customer c on c.id = o.CustomerId
inner join Institution i on i.id = c.InstitutionId
where i.AffiliateId = 1 --ares
and o.OrderType in(4, 8) --order, fix order
and j.IsCanceled = 0
and o.IsCanceled = 0
group by convert(date, js.CreatedDate)
order by CreatedDate asc