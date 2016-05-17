/*This should find the total number of workflows with a correct service task, the total number of production workflow threads in the same time period
then display them and give a % grouped by employee.*/

Declare @date1 datetime
set @date1 = '6/1/2015 00:00:01';
Declare @date2 datetime
set @date2 = '6/30/2015 23:59:59';

with cte_correctservice (employee, [correct service count])/*Finding threads that have a correct service task and grouping by employee*/
as
	(
		Select E.username as employee, count(WT.Id) as [correct service count]
		from WorkflowThread WT
		inner join Employee E on E.ID = WT.CreatedById
		inner join WorkflowTemplate WTEM on WTEM.ID = WT.TemplateId
		inner join WorkflowTask WFT on WFT.ThreadId = WT.Id
		inner join WorkflowTemplateTask WTT on WTT.Id = WFT.TemplateTaskId
		where E.DepartmentId in(5, 6, 37) and 
		WTT.MasterTaskId in(11,71) and
		WTEM.WorkflowTemplateType =1 and /*production wf only*/
		E.IsEmployed =1 and 
		E.EMail != '' and 
		E.AffiliateId = 1 and 
		WT.CreatedDate between @date1 and @date2 and
		WT.[Status] in(2, 4) --in progress, completed (not deleted)
		group by E.username
		
		
	),

cte_totalthreads (employee, workflows)
as
	(
		Select E.username as employee, count(distinct(WT.Id)) as [workflows] /*total production wf threads by employee for the designated period*/
		from WorkflowThread WT
		inner join Employee E on E.ID = WT.CreatedById
		inner join WorkflowTemplate WTEM on WTEM.ID = WT.TemplateId
		inner join WorkflowTask WFT on WFT.ThreadId = WT.Id
		--inner join WorkflowTemplateTask WTT on WTT.Id = WFT.TemplateTaskId
		where E.DepartmentId in(5, 6, 37) and 
		--WTT.MasterTaskId in(11,71) and
		WTEM.WorkflowTemplateType =1 and /*production wf only*/
		E.IsEmployed =1 and 
		E.EMail != '' and 
		E.AffiliateId = 1 and 
		WT.CreatedDate between @date1 and @date2 and
		WT.[Status] in(2, 4) --in progress, completed (not deleted)
		group by E.username
		
	)
/*Combining results of previous CTE's and giving a percent*/
select E.username as USERNAME, a.[correct service count] as [WF with Correct Service Task], b.workflows as [Total Production Workflows], convert(decimal(10, 2), 100*(convert(decimal(10, 2), a.[correct service count] ))/(convert(decimal(10, 2), b.workflows))) as [%]
from Employee E
left join cte_correctservice a on a.employee = E.Username 
left join cte_totalthreads b on b.employee = E.Username
where E.DepartmentId in(5, 6, 37) and 
E.IsEmployed =1 and E.EMail != '' and
E.AffiliateId = 1
order by [%] desc