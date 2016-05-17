select ord.Id, job.JobName, mtask.Name, task.AssignedAgentId, task.MachineId, task.ScheduledDuration, task.ScheduledFor, machine.Name, loc.Name Loc
from OrderView ord
inner join JobView job on job.OrderId=ord.Id
inner join JobServiceView js on js.JobId=job.Id
inner join WorkflowThreadView thread on thread.ReferenceId=js.Id
inner join WorkflowTemplateView template on template.Id=thread.TemplateId
inner join WorkflowTaskView task on task.ThreadId=thread.Id
inner join WorkflowTemplateTaskView ttask on ttask.Id=task.TemplateTaskId
inner join WorkflowMasterTaskView mtask on mtask.Id=ttask.MasterTaskId
left join MachineView machine on machine.Id=task.MachineId
inner join DesignLocationView loc on loc.Id=js.ServiceLocationId
where ord.Id=349147 and job.JobName='a' 
and mtask.IsCloneablePiecemeal=1