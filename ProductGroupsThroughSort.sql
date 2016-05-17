declare @yesterday date = dateadd(day, -2, getdate());
declare @today date = dateadd(day, -1, getdate());



--This shows how many products from each product group shipped for a given time period, by job shipped date, for specific brands involved.
select pg.Name, sum(jp.ProductQuantity) Qty
from productgroup pg
inner join product p on p.ProductGroupId = pg.id
inner join ProductColor pc on pc.ProductId = p.id
inner join jobProduct jp on jp.ProductColorId = pc.Id
inner join job j on j.Id = jp.JobId
inner join orderview o on o.Id = j.OrderId
inner join customer c on c.Id = o.CustomerId
inner join institution i on i.id = c.InstitutionId
inner join affiliate a on a.id = i.AffiliateId
inner join JobService js on js.JobId = j.Id
inner join WorkflowThread wft on wft.ReferenceId = js.Id
inner join WorkflowTask wt on wt.ThreadId = wft.Id
inner join WorkflowTemplateTask wtt on wtt.Id = wt.TemplateTaskId
inner join WorkflowMasterTask wmt on wmt.Id = wtt.MasterTaskId
where wmt.Id = 86 --sort/box required task
	and a.Id = 3
	and wt.CompletedDate between @yesterday and @today
group by pg.Name