Declare @date1 datetime = '10/27/2014';
Declare @date2 datetime = '10/31/2014';

Select A.Name, IT.StockUnitCost, P.Name, VO.Id
from VendorOrder VO
inner join Affiliate A on A.Id = VO.AffiliateId
inner join InventoryTransaction IT on IT.VendorOrderId = VO.Id
left join ProductColorSize PCS on PCS.ID = IT.ProductColorSizeId
left join ProductColor PC on PC.Id = PCS.ProductColorId
left join Product P on P.id = PC.ProductId
where IT.IsBackStock = 1 and
IT.CreatedDate between @date1 and @date2 and
IT.StockUnitCost > 0
order by IT.StockUnitCost desc