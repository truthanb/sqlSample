select jp.id, jp.Alias, pc.IsEnabled, p.IsWebVisible, p.IsEnabled
from jobproduct jp
inner join job j on j.id = jp.JobId
inner join orderview o on o.id = j.OrderId
inner join productcolor pc on pc.id = jp.ProductColorId
inner join product p on p.id = pc.ProductId
where o.id = 353359