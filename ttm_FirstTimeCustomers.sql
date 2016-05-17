declare @yearAgo date = dateadd(year, -1, getdate())
declare @now date = getdate()

select c.name, c.OrderCustomerSince
from customer c
where c.OrderCustomerSince between @yearAgo and @now