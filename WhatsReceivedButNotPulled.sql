--This should return a list of partials that might have fallen off the tracks, so to speak.
declare @now date
set @now = getdate() 
select o.Id as [Order Mumber], j.JobName, p.ProductNumber, c.Name as [Color], ps.Name as [Size], jpcs.Quantity, it.VendorOrderId as [Vendor Order]
from InventoryTransaction it
inner join JobProductColorSize jpcs on jpcs.Id = it.JobProductColorSizeId
inner join ProductColorSize pcs on pcs.Id = jpcs.ProductColorSizeId
inner join  JobProduct jp on jp.Id = jpcs.JobProductId
inner join ProductColor pc on pc.Id = jp.ProductColorId
inner join Product p on p.Id = pc.ProductId 
inner join Job j on j.Id = jp.JobId
inner join OrderView o on o.Id = j.OrderId
inner join ProductSizes ps on ps.Id = pcs.SizeId
inner join Color c on c.Id = pc.ColorId 
where j.IsInventoryPulled = 0 and --job inventory not marked as pulled. ie doesn't look ready for production to proceed.
j.IsBackOrdered = 0 and --Prob dont care about backorders
j.InventoryToArriveDate < @now and  --We're past the time frame where we think we should've received the inventory
o.OrderType in(4) and --dealing only with normal orders
it.IsReceived = 1 and --the inventory is marked received (but the job's not pulled ^)
it.VendorOrderId is not null --clears out some noise
order by o.Id, ps.Name