declare @yearAgo date = dateadd(year, -1, getdate())
declare @now date = getdate()

select c.name, c.CreatedDate
from customer c
where c.CreatedDate between @yearAgo and @now