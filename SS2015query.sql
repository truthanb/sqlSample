/*
Is there any relevant backstory on why it needs to be changed?  
Dyenomite increased pricing Feb. of this year. If S&S did not replenish some of these styles I want to make sure I do not give them the upcharged price on the end of year return. 

What data is needed?
Replenished styles from S&S starting Feb. 2015

What are the intended purposes of use with this data?
End of year return pricing. 
*/
select p.ProductNumber, c.name, sum(jpcs.Quantity)
from product p
inner join ProductColor pc on pc.ProductId = p.id
inner join color c on c.id = pc.ColorId
inner join JobProduct jp on jp.ProductColorId = pc.id
inner join JobProductColorSize jpcs on jpcs.JobProductId = jp.Id
inner join ProductColorSize pcs on pcs.Id = jpcs.ProductColorSizeId
inner join job j on j.id = jp.JobId
inner join orderview o on o.id = j.OrderId
where o.CustomerId = 46082
and o.OrderType = 4
and j.IsCanceled = 0
and o.FinalizedDate > '2/1/2015'
and (jp.ProductColorId in(245337
,238364
,245335
,238363
,245336
,238362
,245339
,245338
,244154
,277911
,235990
,235993
,236003
,236002
,236001
,217950
,220859
,220858
,220860
,217923
,246141
,246143
,223339
,223336
,223337
,223338
,223335
,223334
) or pcs.id in(435409
,435410
,435411
,435412
,435413
,434734
,434735
,434736
,434737
,434738))
group by p.ProductNumber, c.Name
order by p.ProductNumber, c.Name