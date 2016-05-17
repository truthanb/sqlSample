Declare @date1 datetime
set @date1 = '8/1/2015 00:00:01';
Declare @date2 datetime
set @date2 = '8/13/2015 23:59:59';

DECLARE @MasterTaskId bigint = 6;

SELECT e.Username, count(*) Reburns
	FROM WorkflowMasterTask wmt
	INNER JOIN WorkflowTemplateTask wtt ON wtt.MasterTaskId = wmt.Id
	INNER JOIN WorkflowTask wt ON wt.TemplateTaskId = wtt.Id
	INNER JOIN WorkflowThread thread ON thread.id = wt.ThreadId
	INNER JOIN Jobservice js ON js.id = thread.ReferenceId
	INNER JOIN Job j ON j.Id = js.JobId
	INNER JOIN OrderView o ON o.Id = j.OrderId
	INNER JOIN Employee e ON e.Id = o.FinalizedById
	WHERE wmt.name LIKE '%reburn%'
	and wt.CreatedDate between @date1 and @date2
	and wt.CompletedDate is not Null
	GROUP BY e.Username, e.id
	HAVING COUNT(*) > 1
	ORDER BY 2 DESC