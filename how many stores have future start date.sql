select o.id, o.QuoteDueToFinalize
from orderview o
inner join showroomprogram sp on sp.OrderId = o.Id
where o.OrderType in(2, 4) and o.QuoteDueToFinalize <> '' and sp.[Status] in (1, 4, 6, 32)
order by o.QuoteDueToFinalize desc