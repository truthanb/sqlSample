select p.ProductNumber, c.DisplayName, ps.name, pcz.StockQuantity
from productcolorsize pcz
inner join ProductSizes PS on PS.Id = pcz.SizeId
inner join productcolor pc on pc.id = pcz.ProductColorId
inner join color c on c.id = pc.ColorId
inner join product p on p.id = pc.ProductId
where p.AffiliateId = 3 and p.ProductNumber = '200pg' and pcz.StockQuantity > 0