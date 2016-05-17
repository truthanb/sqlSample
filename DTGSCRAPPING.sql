Declare @date1 datetime
set @date1 = '1/1/2015 00:00:01';
Declare @date2 datetime
set @date2 = '12/31/2015 23:59:59';

with cte as (
select e.Username, t.Id TaskId, t.Quantity, wmt.Id MasterTaskId, js.JobId
from employee e
inner join workflowtask t on t.AssignedAgentId = e.Id
inner join WorkflowThread wt on wt.id = t.ThreadId
inner join JobService js on js.id = wt.ReferenceId
inner join [service] s on s.id = js.ServiceId
inner join ServiceType st on st.id = s.ServiceType
inner join job j on j.id = js.JobId
inner join orderview o on o.id = j.OrderId
inner join workflowtemplatetask wtt on wtt.id = t.TemplateTaskId
inner join WorkflowMasterTask wmt on wmt.id = wtt.MasterTaskId
where o.OrderType in(4, 8) --order, fix order
and t.CreatedDate between @date1 and @date2
and j.IsCanceled = 0 and o.IsCanceled=0
and st.Id = 131072 --DTG servicetype)
), cte_agentThreads (agent,thread)
as
	(
		select cte.Username, count(cte.TaskId)
		from cte
		where cte.MasterTaskId in(65, 1494)
		group by cte.Username
	),

cte_totalThreads (agent,thread)
as
	(
		select Username,count(TaskId)
		from cte
		where cte.MasterTaskId in(1493) --dtg print
		group by Username
	), 

cte_scrapQuantity (agent, qty)
as
	(
		select Username, sum(spcz.Quantity)
		from cte
		left join scrap sc on sc.JobId = cte.JobId
		inner join ScrapProductColorSize spcz on spcz.ScrapId = sc.Id
		where  cte.MasterTaskId in(65, 1494)
		group by Username
	),

cte_totalDTGQuantity (agent, total)
as
	(
		select Username,sum(cte.Quantity)
		from cte
		where cte.MasterTaskId in(1493) --dtg print
		group by Username
	)

select e.username, thread.thread as [Scrapped Threads], totalthread.thread as [Total Threads], quantity.qty as [Scrapped Quantity], pcQty.total as [Total DTG Quantity], cast(100.0 * quantity.qty / pcQty.total as decimal(10,2)) as [Scrap %]
from employee e
inner join cte_agentThreads thread on thread.agent = e.Username
inner join cte_scrapQuantity quantity on quantity.agent = e.Username
inner join cte_totalThreads totalthread on totalthread.agent = e.Username
inner join cte_totalDTGQuantity pcQTY on pcQTY.agent = e.Username