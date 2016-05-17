select PV.ProductNumber as Product,PCSV.VendorSKU as GTIN, CV.DisplayName as Color, PCSV.SizeId
from ProductColorSizeView PCSV
inner join ProductColorView PCV on PCSV.ProductColorId = PCV.Id
inner join ColorView CV on PCV.ColorId = CV.Id
inner join ProductView PV on PCV.ProductId = PV.Id
where PCV.VendorId = 65 and PV.IsEnabled = 1 and PV.IsWebVisible = 1 and pcv.IsEnabled = 1 and pcsv.IsEnabled = 1