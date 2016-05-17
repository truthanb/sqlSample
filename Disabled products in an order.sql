Select Distinct PV.Name, PV.ProductNumber, JV.JobName
from ProductView PV
join ProductColorView PCV on PCV.ProductId = PV.Id 
join JobProductView JPV on JPV.ProductColorId = PCV.Id
join JobView JV on JV.id = JPV.JobId  
join Orderview OV on OV.Id = JV.OrderId
where OV.Id = 262810 and PV.Isenabled = 0
order by JV.JobName asc