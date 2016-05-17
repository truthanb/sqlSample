select p.ProductNumber
from product p
left join ProductProductCategory ppc on ppc.ProductId = p.id
where p.IsEnabled = 1
and p.IsWebVisible =1
and ppc.id is null