select p.ProductNumber, sum(jp.ProductQuantity) as [Product Quantity], count(sp.id) as [Unique Stores]
from product p
inner join ProductColor pc on pc.ProductId = p.Id
inner join Color c on c.id = pc.ColorId
inner join JobProduct jp on jp.ProductColorId = pc.Id
inner join Job j on j.id = jp.JobId
inner join OrderView o on o.Id = j.OrderId
inner join ShowroomProgram sp on sp.OrderId = o.Id
where sp.CreatedDate between dateadd(DAY, -365, getdate()) and getdate()
and o.ordertype = 4 --only stores that have gone to production
and sp.[Status] != 64 --no fuckin league orders pls.
group by p.ProductNumber
order by 2 desc