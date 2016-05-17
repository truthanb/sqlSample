select p.firstname, p.lastname, coalesce(p.WebLoginEmail, p.WorkEmail, p.HomeEmail) as [email], c.id, c.Name as name, sum(jp.ProductQuantity) as[total pieces ordered]
from person p
inner join orderview o on o.ResponsiblePartyId = p.Id
inner join customer c on c.id = o.CustomerId
inner join job j on j.OrderId = o.Id
inner join jobproduct jp on jp.JobId = j.Id
inner join productcolor pc on pc.id = jp.ProductColorId
left join ShowroomProgram sp on sp.OrderId = o.id
where o.DateLastJobShipped > DATEADD(year, -3, getdate())
and pc.ProductId in(3139, 3140) --Hoodie
and sp.id is null
group by c.id, c.name, p.WebLoginEmail, p.WorkEmail, p.HomeEmail, p.firstname, p.lastname
order by 6 desc


