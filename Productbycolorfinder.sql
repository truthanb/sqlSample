SELECT p.Id ProductId, p.ProductNumber
	FROM ProductView p
	INNER JOIN ProductColorView pc ON pc.ProductId = p.Id
	WHERE pc.ColorId = 334