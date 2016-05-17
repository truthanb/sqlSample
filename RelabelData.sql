select count(*), sum(wft.quantity)
from workflowthread wft
inner join workflowtask wt on wt.ThreadId = wft.id
inner join workflowtemplatetask wtt on wtt.Id = wt.TemplateTaskId
inner join WorkflowMasterTask wmt on wmt.id = wtt.MasterTaskId
inner join JobService js on js.id = wft.ReferenceId
inner join job j on j.id = js.JobId
inner join orderview o on o.id = j.OrderId
inner join customer c on c.id = o.CustomerId
where wmt.Id in(1507, 1564)
and o.Ordertype in(4, 8)
and c.id = 1573579 --Dyenomite Backstock Customer