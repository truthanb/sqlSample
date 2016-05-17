select p.ProductNumber, p.name, c.DisplayName
from ProductView p
inner join productcolorview pc on pc.ProductId = p.id
inner join ColorView c on c.Id = pc.ColorId
where pc.id = 219561 or pc.id = 113607 or pc.id = 218397 or pc.id = 113428 or pc.id = 208889 or pc.id = 219525 or pc.id = 228173 or pc.id = 235686 or pc.id = 235802 or pc.id = 224849 or pc.id = 212443 or pc.id = 226769 or pc.id = 240887 or pc.id = 239648 or pc.id = 240729