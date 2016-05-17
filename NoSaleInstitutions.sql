--This finds institutions which customers have never placed a quote or order with us. It also shows how many catalog mailings we've sent to it's customers,
--along with the first and last recorded catalog mailing date.

set transaction isolation level read uncommitted

begin tran;

with cte_InstOrdCount as (
	select I.Id Institution
	from Institution I
	left join customer c on c.InstitutionId = i.Id
	left join orderview o on o.customerId = c.Id
	group by I.Id
	having count(o.Id) = 0
), cteCatalogs as (
	select cust.InstitutionId, count(*) Catalogs, count(distinct cust.Id) Customers, 
	min(cast(coalesce(mw.StartDate, mw.EffectiveDateStart, mw.TargetDate, mw.CreatedDate) as date)) [First], max(cast(coalesce(mw.StartDate, mw.EffectiveDateStart, mw.TargetDate, mw.CreatedDate) as date)) [Last]
	from  CustomerView cust 
	inner join MarketingWaveCustomer mwc on mwc.CustomerId = cust.Id
	inner join MarketingWave mw on mw.id = mwc.MarketingWaveId
	inner join MarketingPiece mp on mp.Id = mw.MarketingPieceId
	where mp.[Type] = 1
	group by cust.InstitutionId
)
select addr.StateProvince, I.Name, it.Name [Type], school.Name SchoolType, cteCatalogs.Customers, cteCatalogs.Catalogs, cteCatalogs.[First], cteCatalogs.[Last]
from Institution I
inner join  InstitutionType it on it.Id=I.InstitutionType
left join SchoolType school on school.Id=I.SchoolType
inner join cte_InstOrdCount C on C.Institution = I.Id
inner join cteCatalogs on cteCatalogs.InstitutionId=I.Id
left join AddressView addr on addr.Id = coalesce(I.PhysicalAddressId, I.ShippingAddressId, I.PrimaryBillingAddressId)
	where I.IsDisabled = 0
	and I.AffiliateId = 1
order by 1, 2

commit tran