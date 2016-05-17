Select avg(js.quantity) as AvgQuantity, S.DisplayName as Name, Count(O.Id) as Orders
	from JobServiceView js
	inner join JobView j on j.Id = js.JobId
	inner join OrderView o on o.id = j.OrderId
	inner join ServiceView S on S.id = js.ServiceId 
where O.OrderType in(4) and js.quantity > 24 and O.FinalizedDate > '2012/12/13' and js.ServiceId in(162, 163, 164, 165, 168, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 276, 277, 355)
group by s.DisplayName

/*** may wish to change the date and service id's ***/

Select O.Id
	from JobServiceView js
	inner join JobView j on j.Id = js.JobId
	inner join OrderView o on o.id = j.OrderId
	inner join ServiceView S on S.id = js.ServiceId 
where O.OrderType in(4) and js.quantity > 24 and O.FinalizedDate > '2012/12/13' and js.ServiceId in(162, 163, 164, 165, 168, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 276, 277, 355)
