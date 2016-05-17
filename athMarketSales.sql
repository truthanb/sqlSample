select i.name as institution, c.name as [customer name], sum(o.totalordercost) as sales
from customer c
inner join orderview o on o.CustomerId = c.Id
inner join Institution i on i.id = c.InstitutionId
where o.OrderType = 4 --order
and o.IsCanceled = 0
and c.MarketId = 18 --ath market
and o.DateLastJobShipped between dateadd(year, -1, getdate()) and getdate()
group by i.name, c.name
order by sales desc