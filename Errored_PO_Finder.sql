SELECT vo.Id, vo.CreatedDate, j.OrderId, j.JobName 
FROM DeletedVendorOrder vo 
LEFT JOIN DeletedInventoryTransaction it ON it.VendorOrderId = vo.id 
LEFT JOIN jobproductcolorsize jpcs on jpcs.id = it.JobProductColorSizeId 
LEFT JOIN jobproduct jp on jp.Id = jpcs.JobProductId 
LEFT JOIN job j ON j.id = jp.JobId 
WHERE vo.CreatedDate > convert(date, getdate()) 
ORDER BY vo.id DESC