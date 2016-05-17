declare @today date
set @today = getdate(); 
Select o.[Id], o.FinalizedDate
From OrderView o
Inner Join Job j on j.OrderId = O.Id
Inner Join JobProduct jp on jp.JobId = j.Id
Inner Join ProductColor pc on pc.Id = jp.ProductColorId
Inner Join Product p on p.Id = pc.ProductId
Where o.CustomerId in(46087, 2287451, 46082, 2274185, 2288094, 45711, 60505, 2284734, 2282696, 49725)
and p.id = 7086
and o.FinalizedDate > dateadd(day, -1, getdate())