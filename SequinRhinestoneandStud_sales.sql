select s.name as NAME, sum(js.Quantity) as [QTY SOLD]
from jobservice js
inner join [service] s on s.id = js.ServiceId
inner join job j on j.id = js.JobId
inner join OrderView o on o.id = j.OrderId
where o.OrderType = 4 
and o.IsCanceled = 0
and j.IsCanceled = 0
and js.ServiceId in(289,456,425)
and o.FinalizedDate between DATEADD(day, -712, getdate()) and getdate()
group by s.Name
order by 2