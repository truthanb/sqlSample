DECLARE @Now datetime = GETDATE();

SELECT jp.Id JobId, SUM(it.Quantity) TransQty, jp.ProductQuantity, o.Id OrderId, j.JobName, p.ProductNumber, p.Name
	FROM InventoryTransaction it
	INNER JOIN VendorOrder vo ON vo.Id = it.VendorOrderId
	INNER JOIN JobProductColorSize jpcs ON jpcs.Id = it.JobProductColorSizeId
	INNER JOIN JobProduct jp ON jp.Id = jpcs.JobProductId
	INNER JOIN Job j ON j.Id = jp.JobId
	INNER JOIN OrderView o ON o.Id = j.OrderId
	INNER JOIN ProductColor pc ON pc.Id = jp.ProductColorId
	INNER JOIN Product p ON p.Id = pc.ProductId
	WHERE (it.IsReceived = 1 OR vo.AllReceivedDate IS NOT NULL)
		AND it.Quantity > 0
		AND j.InventoryToArriveDate < @Now
		AND j.IsInventoryPulled = 0
		AND j.IsBackOrdered = 0
		AND o.OrderType = 4
		AND j.IsCanceled = 0
		AND j.IsDropShip = 0
	GROUP BY jp.Id, jp.ProductQuantity, o.Id, j.JobName, p.ProductNumber, p.Name
	HAVING SUM(it.Quantity) >= jp.ProductQuantity
	