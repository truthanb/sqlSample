select p.Id as ProdId, p.Name, p.ProductNumber, pc.Id as PCID, c.Name as ColorName 
from Product p 
	inner join ProductColor pc on p.DefaultColorId = pc.Id
	inner join Color c on pc.ColorId = c.Id 
where p.IsEnabled = 1 and pc.IsEnabled = 0 and p.IsWebVisible = 1 