select wf.ReferenceDescription, wf.CompletedDate, 'WorkflowTask<'+cast([wt].[Id] as varchar)+'>' Find, wt.Quantity, [wt].[RecordLastUpdatedDate],  wt.id
from workflowtask wt
inner join workflowthread wf on wf.id = wt.ThreadId
inner join workflowtemplatetask wtt on wtt.id = wt.TemplateTaskId
inner join WorkflowMasterTask wmt on wmt.id = wtt.MasterTaskId
where wmt.id in(9, 19, 20, 21, 22, 23, 24, 25, 26, 27, 697, 698)
and wt.assignedAgentId is null
and wf.[Status] = 4
and wt.CompletedDate between '12/31/2014' and '8/6/2015'
order by wt.CompletedDate, wt.Quantity desc