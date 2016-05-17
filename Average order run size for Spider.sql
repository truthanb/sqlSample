Select avg(js.quantity) as AvgQuantity, S.DisplayName as Name, Count(O.Id) as Orders
	from JobServiceView js
	inner join JobView j on j.Id = js.JobId
	inner join OrderView o on o.id = j.OrderId
	inner join ServiceView S on S.id = js.ServiceId 
where O.OrderType in(4) and js.quantity > 24 and O.FinalizedDate > '2012/12/13' and js.ServiceId in(52, 83, 128, 420, 424)
group by s.DisplayName

/*** may wish to change the date and service id's ***/

Select O.Id
	from JobServiceView js
	inner join JobView j on j.Id = js.JobId
	inner join OrderView o on o.id = j.OrderId
	inner join ServiceView S on S.id = js.ServiceId 
where O.OrderType in(4) and js.quantity > 24 and O.FinalizedDate > '2012/12/13' and js.ServiceId in(52, 83, 128, 420, 424)