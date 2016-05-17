select cust.Name, count(o.id) orders
	from  CustomerView cust 
	left join OrderView o on o.customerId = cust.Id
	inner join Institution i on i.id = cust.InstitutionId
	where i.AffiliateId = 1
	and cust.IsDisabled = 0
	and i.IsDisabled = 0
	and i.IsMarketingSuppressed = 0
	group by cust.Name
	order by orders asc
	