Declare @date1 datetime
set @date1 = '6/1/2015 00:00:01';
Declare @date2 datetime
set @date2 = '12/31/2015 23:59:59';


/*This query captures the sum of job service quantity for all fusion and pinwheel services in the system as of 1/25/16*/
select s.DisplayName, sum(js.Quantity) as Quantity
from [service] s
inner join jobservice js on js.ServiceId = s.id
inner join job j on j.id = js.JobId
inner join [order] o on o.id = j.OrderId
where j.IsCanceled = 0
and o.IsCanceled = 0
and js.IsComplete = 1
and o.OrderType in(2,4)
and j.ShipDate between @date1 and @date2
--pinwheel and fusion services
and js.ServiceId in(53,98,100,104,146,147,148,150,151,152,153,154,155,156,157,158,159,160,161,166,167,169,275,422,423,446,447,448,449,450,499,644,645,646,647,656,657,89,190,191,192,193,194,195,196,197,198,258,259,260,269,451)
group by s.DisplayName