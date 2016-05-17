SELECT avg(p.ActualWeight) AvgWeight, avg(p.PackageCost) AvgCost
FROM PackageSummary ps
INNER JOIN Package p ON p.SummaryId = ps.Id
WHERE ps.ShippingType IN (512, 4096)
	AND ps.IsVoid = 0