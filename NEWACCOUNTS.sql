--Accounting uses this for budgeting. Each pay period they like to know the TTM count of new customers created,
--the TTM count of new customers who placed a quote or order, and the TTM count of all accounts that placed a quote or order. 

Declare @date1 datetime
set @date1 = '5/9/2015 00:00:01'; 
Declare @date2 datetime
set @date2 = '5/8/2016 23:59:59';
Declare @affiliate int
set @affiliate = 3;


select count( distinct c.id) as [Total New Customers]
from Customer c	
inner join Institution i on i.id = c.InstitutionId
where c.CreatedDate between @date1 and @date2 and i.AffiliateId = @affiliate and
c.IsDisabled = 0

select count( distinct c.id) as [New Customers that placed Quote or Order]
from Customer c	
inner join Institution i on i.id = c.InstitutionId
inner join OrderView o on o.CustomerId = c.Id
where c.CreatedDate between @date1 and @date2 and
o.CreatedDate between @date1 and @date2 and
--o.OrderType = 2 and
i.AffiliateId = @affiliate and
c.IsDisabled = 0

select count( distinct c.id) as [Total Customers who placed Quote or Order]
from Customer c
inner join Institution i on i.id = c.InstitutionId
inner join OrderView o on o.CustomerId = c.Id
where o.CreatedDate between @date1 and @date2 and
i.AffiliateId = @affiliate and
c.IsDisabled = 0

/*select distinct c.name, count(o.id) orders
from Customer c
inner join Institution i on i.id = c.InstitutionId
left join OrderView o on o.CustomerId = c.Id
where c.CreatedDate between @date1 and @date2 and
i.AffiliateId = 1 and
o.id is null
group by c.name
order by orders asc*/
