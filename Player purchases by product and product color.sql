DECLARE @StartDate datetime = '10/1/2015';
DECLARE @EndDate datetime = '1/1/2016';

select p.ProductNumber, count(tpp.id) as qty
from TeamPlayerPurchase tpp
inner join JobProductColorSize jpcs on jpcs.id = tpp.PurchaseId
inner join JobProduct jp on jp.id = jpcs.JobProductId
inner join ProductColor pc on pc.id = jp.ProductColorId
inner join color c on c.id = pc.ColorId
inner join product p on p.id = pc.ProductId
inner join job j on j.id = jp.JobId
inner join orderview o on o.id = j.OrderId
inner join ShowroomProgram sp on sp.OrderId = o.Id
where o.FinalizedDate between @StartDate and @EndDate
and sp.[Status] <> 64
group by p.ProductNumber
order by 2 desc, p.ProductNumber

select p.ProductNumber, c.name as [Color Name], count(tpp.id) as qty
from TeamPlayerPurchase tpp
inner join JobProductColorSize jpcs on jpcs.id = tpp.PurchaseId
inner join JobProduct jp on jp.id = jpcs.JobProductId
inner join ProductColor pc on pc.id = jp.ProductColorId
inner join color c on c.id = pc.ColorId
inner join product p on p.id = pc.ProductId
inner join job j on j.id = jp.JobId
inner join orderview o on o.id = j.OrderId
inner join ShowroomProgram sp on sp.OrderId = o.Id
where o.FinalizedDate between @StartDate and @EndDate
and sp.[Status] <> 64
group by p.ProductNumber, c.name
order by 3 desc, p.ProductNumber, c.name