--Meant to be part of an email that goes to Dan Girard to show any product color sizes that have not had an inventory update in the past 3 days.

declare @today date
set @today = getdate();

declare @3DaysAgo date
set @3DaysAgo = dateadd(Day,-3, @today)

select v.name, p.name, c.DisplayName, s.Name
from Product p
inner join ProductColor pc on pc.ProductId = p.Id
inner join ProductColorSize pcs on pcs.ProductColorId = pc.Id
inner join Color c on c.id = pc.ColorId
inner join ProductSizes s on s.Id = pcs.SizeId
inner join Vendor v on v.id = pc.VendorId
where pcs.VendorLastUpdateDate = @3DaysAgo