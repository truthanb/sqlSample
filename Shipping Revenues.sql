declare @beginDate datetime = '10/1/2014 00:00:01';
declare @endDate datetime = '10/31/2014 23:59:59';
declare @affiliate int = 1; --institution id, 1 for ares 3 for dyenomite

with cte_VirtualShippingProduct(virtualShippingProduct) as
(
select sum(jp.SubtotalPrice) as virtualShippingProduct
from JobProduct jp
inner join Job j on j.id = jp.JobId
inner join OrderView ord on ord.Id = j.OrderId
inner join Customer cust on cust.Id = ord.CustomerId
inner join Institution inst on inst.Id = cust.InstitutionId
where ord.OrderType = 4 and
ord.FinalizedDate between @beginDate and @endDate and
jp.ProductColorId = 271747 and
inst.AffiliateId = @affiliate
), 

cte_conventionalShippingRevenue(conventional) as
(
select sum(ord.TotalShippingFee)
from OrderView ord
inner join Customer cust on cust.Id = ord.CustomerId
inner join Institution inst on inst.Id = cust.InstitutionId
where ord.OrderType = 4 and
ord.FinalizedDate between @beginDate and @endDate and
inst.AffiliateId = @affiliate
)
select (conventional+isnull(virtualShippingProduct, 0)) as [Shipping Revenue]
from cte_conventionalShippingRevenue, cte_VirtualShippingProduct