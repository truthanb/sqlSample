Select avg(js.quantity) as AvgQuantity, S.DisplayName as Name, Count(O.Id) as Orders
	from JobServiceView js
	inner join JobView j on j.Id = js.JobId
	inner join OrderView o on o.id = j.OrderId
	inner join ServiceView S on S.id = js.ServiceId 
where O.OrderType in(4) and js.quantity > 72 and O.FinalizedDate > '2012/12/13' and js.ServiceId in(334, 335, 336, 337, 338, 339, 340, 341, 342, 348, 349, 350, 351, 352, 353, 354, 356, 357, 358, 439, 442)
group by s.DisplayName

/*** may wish to change the date and service id's ***/

Select O.Id
	from JobServiceView js
	inner join JobView j on j.Id = js.JobId
	inner join OrderView o on o.id = j.OrderId
	inner join ServiceView S on S.id = js.ServiceId 
where O.OrderType in(4) and js.quantity > 72 and O.FinalizedDate > '2012/12/13' and js.ServiceId in(334, 335, 336, 337, 338, 339, 340, 341, 342, 348, 349, 350, 351, 352, 353, 354, 356, 357, 358, 439, 442)
