/**/
Declare @date1 datetime
set @date1 = '7/1/2015 00:00:01';
Declare @date2 datetime
set @date2 = '7/31/2015 23:59:59';

with cte_correctservice (employee, [artreproof]) /*This is a common table expression gathering the employee initials and number of correct service tasks assigned to them*/
as
	(
		Select E.username as employee, count(*) as [artreproof]
		from Employee E
		inner join WorkflowTask WT on WT.AssignedAgentId = E.Id
		inner join WorkflowTemplateTask WTT on WTT.Id = WT.TemplateTaskId
		inner join WorkflowMasterTask WMT on WMT.ID = WTT.MasterTaskId
		where 
		E.DepartmentId in(5, 6, 37) /*relevant cs/sales depts*/ and
		 E.IsEmployed =1 and E.EMail != '' /*filters out some old employees who are left emp for whatever reasons*/and 
		 WMT.Id in(61, 75) /*art reproof master tasks*/ and 
		 E.AffiliateId = 1 /*ares*/ and 
		 wt.CreatedDate between @date1 and @date2 /*when the workflow started*/ 
		group by E.username
		
	),

cte_totalthreads (employee, workflows) /*this is a commone table expression that gets the employee initials and number of workflow threads they started*/
as
	(
		Select E.username as employee, count(*) as workflows
		from Employee E
		inner join WorkflowTask WT on WT.AssignedAgentId = E.Id
		inner join WorkflowTemplateTask WTT on WTT.Id = WT.TemplateTaskId
		inner join WorkflowMasterTask WMT on WMT.ID = WTT.MasterTaskId
		where E.DepartmentId in(5, 6, 37) and 
		E.IsEmployed =1 and E.EMail != '' and 
		WMT.Id in(3, 74, 1174) and 
		E.AffiliateId = 1 and 
				WT.CreatedDate between @date1 and @date2
		group by E.username
		
	)
/*this does some math and joins the previous two common table expressions*/
select E.username as Username, error.[artreproof] as [CSR ART REPROOFS], total.workflows as [CSR ART PROOFS], convert(decimal(10, 2), 100*(convert(decimal(10, 2), error.[artreproof] ))/(convert(decimal(10, 2), total.workflows))) as [%] --dividing error count by total count
from Employee E
left join cte_correctservice error on error.employee = e.Username
left join cte_totalthreads total on total.employee = e.Username
where E.DepartmentId in(5, 6, 37) and 
E.IsEmployed =1 and E.EMail != '' and
E.AffiliateId = 1
order by [%] desc