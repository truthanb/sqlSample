Select avg(js.quantity) as AvgQuantity, S.DisplayName as Name, Count(O.Id) as Orders
	from JobServiceView js
	inner join JobView j on j.Id = js.JobId
	inner join OrderView o on o.id = j.OrderId
	inner join ServiceView S on S.id = js.ServiceId 
where O.OrderType in(4) and js.quantity > 24 and O.FinalizedDate > '2012/12/13' and js.ServiceId in(74, 183, 184, 185, 186, 187, 188, 189, 261, 262, 263, 278, 279, 280, 475)
group by s.DisplayName

/*** may wish to change the date and service id's ***/

Select O.Id
	from JobServiceView js
	inner join JobView j on j.Id = js.JobId
	inner join OrderView o on o.id = j.OrderId
	inner join ServiceView S on S.id = js.ServiceId 
where O.OrderType in(4) and js.quantity > 24 and O.FinalizedDate > '2012/12/13' and js.ServiceId in(74, 183, 184, 185, 186, 187, 188, 189, 261, 262, 263, 278, 279, 280, 475)