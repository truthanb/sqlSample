Select avg(js.quantity) as AvgQuantity, S.DisplayName as Name, Count(O.Id) as Orders
	from JobServiceView js
	inner join JobView j on j.Id = js.JobId
	inner join OrderView o on o.id = j.OrderId
	inner join ServiceView S on S.id = js.ServiceId 
where O.OrderType in(4) and js.quantity > 24 and O.FinalizedDate > '2014/03/26' and S.AffiliateId = 3
group by s.DisplayName
