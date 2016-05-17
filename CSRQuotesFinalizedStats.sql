--Finds the total pieces of quote or order that a rep placed, alongside the total number of them which finalized as orders eventually, and then gives a percent
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
begin tran

Declare @date1 datetime
set @date1 = '8/1/2014 00:00:01';
Declare @date2 datetime
set @date2 = '1/31/2015 23:59:59';


with cte as (
select agent.Id, count(*) Created, sum(case ord.OrderType when 4 then 1.0 else 0.0 end) ThatFinalized
from OrderView ord
inner join EmployeeView agent on agent.Id=ord.CreatedById
where ord.OrderType<>8 and ord.CreatedDate between @date1 and @date2 and agent.AffiliateId=1
group by agent.Id
)
select agent.Id, agent.FirstName, agent.LastName, cte.Created, cte.ThatFinalized, cte.ThatFinalized / cte.Created [Percent]
from Employee agent
inner join cte on cte.Id=agent.Id
order by 6 desc

commit tran
