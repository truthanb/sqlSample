DECLARE @AffiliateId bigint = 3;
DECLARE @StartDate datetime = '1/1/2015';
DECLARE @EndDate datetime = '1/19/2016';
DECLARE @ExcludeMarkets varchar = '103';

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

--SET STATISTICS PROFILE ON

WITH PieceCount AS(
	SELECT c.Id CustomerId, c.Name CustomerName, sto.InstitutionName Recipient, a.AddressLine1, a.City, a.StateProvince, a.ZipCode, 
		 SUM(jp.ProductQuantity) PieceCount
	FROM Customer c
	INNER JOIN Institution i ON i.Id = c.InstitutionId
	INNER JOIN [Order] o ON o.CustomerId = c.Id
	INNER JOIN ShipToOverride sto ON sto.Id = o.ShipToId
	INNER JOIN AddressView a ON a.Id = sto.AddressId
	INNER JOIN Job j ON j.OrderId = o.Id
	INNER JOIN JobProduct jp ON jp.JobId = j.Id
	WHERE i.AffiliateId = @AffiliateId
		AND o.FinalizedDate BETWEEN @StartDate AND @EndDate
		AND o.OrderType = 4
		AND c.MarketId NOT IN (103)
		--AND c.MarketId NOT IN (@ExcludeMarkets)
	GROUP BY c.Id, c.Name, sto.InstitutionName, a.AddressLine1, a.City, a.StateProvince, a.ZipCode
	HAVING SUM(o.TotalOrderCost) > 0
)
SELECT c.Name CustomerName, sto.InstitutionName Recipient, a.AddressLine1, a.City, a.StateProvince, a.ZipCode, 
		p.FirstName + ' ' + p.LastName MarketingContact,
		ph.AreaCode + '-' + ph.Exchange + '-' + ph.Line MarketingPhone,
		isnull(isnull(p.WorkEmail, p.HomeEmail), p.WebLoginEmail),
		COUNT(o.Id) OrderCount,
		SUM(o.TotalOrderCost) OrderTotal,
		jpc.PieceCount
	FROM Customer c
	INNER JOIN Institution i ON i.Id = c.InstitutionId
	INNER JOIN PersonView p ON p.Id = c.MarketingContactId
	INNER JOIN phone ph ON ph.Id = p.BusinessPhoneId
	INNER JOIN [Order] o ON o.CustomerId = c.Id
	INNER JOIN ShipToOverride sto ON sto.Id = o.ShipToId
	INNER JOIN AddressView a ON a.Id = sto.AddressId
	
	INNER JOIN PieceCount jpc ON jpc.CustomerId = c.Id AND jpc.Recipient = sto.InstitutionName AND jpc.AddressLine1 = a.AddressLine1

	WHERE i.AffiliateId = @AffiliateId
		AND o.FinalizedDate BETWEEN @StartDate AND @EndDate
		AND o.OrderType = 4
		AND c.MarketId NOT IN (103)
		--AND c.MarketId NOT IN (@ExcludeMarkets)
	GROUP BY c.Id, c.Name, sto.InstitutionName, a.AddressLine1, a.City, a.StateProvince, a.ZipCode, p.FirstName, p.LastName, jpc.PieceCount, ph.AreaCode, ph.Exchange, ph.Line, p.WorkEmail, p.HomeEmail, p.WebLoginEmail
	HAVING SUM(o.TotalOrderCost) > 0
	ORDER BY jpc.PieceCount desc
