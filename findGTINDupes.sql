--Run the bad findBadJob.sql query. See if any of those jobProducts match any items on this list of dupe gtins. (Hint: Usually the problem is a sanmar product)
WITH DistinctGtins AS
(
  SELECT DISTINCT pcs.VendorSKU FROM ProductColorSize pcs WHERE pcs.VendorSKU <> ''
),
Duplicates AS (
  SELECT pcs.VendorSKU, p.ProductNumber, c.Name Color, ps.Name Size, COUNT(pcs.Id) OVER (PARTITION BY pcs.VendorSKU) DupeCount, v.Name Vendor
    FROM DistinctGtins gtin
    INNER JOIN ProductColorSize pcs ON pcs.VendorSKU = gtin.VendorSKU
    INNER JOIN ProductColor pc ON pc.id = pcs.ProductColorId
    INNER JOIN Product p ON p.Id = pc.ProductId
    INNER JOIN Color c ON c.Id = pc.ColorId
    INNER JOIN ProductSizes ps ON ps.Id = pcs.SizeId
    INNER JOIN Vendor v ON v.Id = pc.VendorId
    WHERE p.AffiliateId = 1
      AND p.IsEnabled = 1
      AND pc.IsEnabled = 1
      AND pcs.IsEnabled = 1
)
SELECT * FROM Duplicates WHERE DupeCount > 1 ORDER BY DupeCount, VendorSKU