Select distinct PV.ProductNumber as Code, PV.Name from ProductView PV
join ProductColorView PCV on PCV.ProductId = PV.Id
where PCV.IsCommodity = 1 and PV.IsEnabled = 1