declare @now date = getdate();
select (cast(o.id as varchar)+'/'+j.JobName) Job, e.username, o.JobTypes
from job j
inner join JobService js on js.JobId = j.Id
inner join OrderView o on o.Id = j.OrderId
inner join WorkflowThread thread on thread.ReferenceId = js.Id
inner join WorkflowTask threadtask on threadtask.ThreadId = thread.Id
inner join WorkflowTemplateTask wtt on wtt.id = threadtask.TemplateTaskId
inner join WorkflowMasterTask wmt on wmt.Id = wtt.MasterTaskId
inner join WorkflowTemplateTaskView activettask on activettask.Id=thread.ActiveTaskId
inner join customer c on c.id = o.CustomerId
inner join institution i on i.Id = c.InstitutionId
inner join Employee e on e.id = o.finalizedbyId
where thread.[Status] in(1, 2)
and wmt.Id = 6
and (j.IsInventoryPulled = 1 or j.InventoryToArriveDate = @now)
and threadtask.CompletedDate is null
and activettask.MasterTaskId in(1, 2, 3, 4, 11, 12, 14, 16, 61, 62, 678, 1182, 1355)
and i.affiliateId = 1
and o.OrderDueToShipDate <= dateadd(day, 3, @now) --add a case in the dateadd when the index of jobtypes includes srt to then 3, else 1. 
and j.IsCanceled =0
and o.OrderType in(4,8)