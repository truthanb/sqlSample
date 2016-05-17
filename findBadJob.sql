--change the finalized date to whatever, it's helpful if you can figure out when shit went awry and set the finalized datetime
-- to something right about then. usually it's sanmar products causing the issues (youth gtin and adult gtin duping each other for a given product color)

SELECT o.Id, j.JobName, p.Name, p.ProductNumber, v.Name, col.Name
  FROM [Order] o
  INNER JOIN Job j ON j.OrderId = o.Id
  INNER JOIN JobProduct jp ON jp.JobId = j.id
  INNER JOIN ProductColor pc ON pc.Id = jp.ProductColorId
  INNER JOIN Product p ON p.Id = pc.ProductId
  INNER JOIN Vendor v ON v.Id = pc.VendorId
  INNER JOIN Color col ON col.Id = pc.ColorId
  WHERE o.FinalizedDate > '5/16/2016 3:00 PM'